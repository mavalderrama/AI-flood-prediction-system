# AI Powered Flood Prediction System

An IoT edge system on a Zynq-7000 (ZYBO) that **forecasts** floods of the
Mississippi River at Baton Rouge: every day it answers *"will the stage go
above 30 ft in the next 5 days?"*. A small neural network runs on an FPGA
accelerator generated with Vivado HLS, and a bit-exact CPU reference checks it.

This is a revision of the original 2018 master's thesis code. The thesis
model looked good in MATLAB but inferred poorly on the board. The causes and
the fixes are listed in [What was wrong in the thesis version](#what-was-wrong-in-the-thesis-version).

## Results (test period 2021-2026, never used for training or tuning)

Horizon 5 days, flood = stage > 30 ft at USGS 07374000. "Onset F1" only counts
days when the river is not already flooded, so it measures whether a *new*
flood is anticipated. Predicting that an ongoing flood continues is trivial.

| Model | Onset P / R / F1 | Floods warned | Median lead | False alarms/yr |
|---|---|---|---|---|
| Persistence (flooded tomorrow if flooded today) | 0.00 / 0.00 / 0.00 | 0/9 | - | 0.0 |
| Trend extrapolation | 0.46 / 0.75 / 0.57 | 9/9 | 5 d | 1.5 |
| Logistic regression | 0.78 / 0.57 / 0.66 | 8/9 | 3 d | 0.7 |
| MLP, Baton Rouge data only | 0.68 / 0.77 / 0.72 | 9/9 | 4 d | 1.2 |
| **MLP with upstream gauges (FPGA, Q8.24)** | **0.83 / 0.80 / 0.81** | **9/9** | **4 d** | **0.7** |

All horizons (1, 3, 5, 7 days) and the official NWS flood stage (35 ft) are in
[`python/reports/metrics_30ft.md`](python/reports/metrics_30ft.md) and
[`python/reports/metrics_35ft.md`](python/reports/metrics_35ft.md). Two honest caveats:
- At 1 day, simple trend extrapolation beats the MLP.
- At 35 ft the test period has only 4 floods, and the MLP does not beat trend.

## Data

| Column | Source |
|---|---|
| `stage_br` | Mississippi River at Baton Rouge, gage height, USGS 07374000 (target) |
| `q_vicks` | Mississippi River at Vicksburg, discharge, USGS 07289000 (~3-4 days upstream) |
| `q_thebes` | Mississippi River at Thebes, IL, discharge, USGS 07022000 (upper Mississippi + Missouri) |
| `rain_BTR` | Daily precipitation at Baton Rouge Metro airport (ASOS, Iowa Environmental Mesonet) |

The data is daily from 2008 to 2026. USGS data comes from the new Water Data API
(`api.waterdata.usgs.gov`); the legacy waterservices API is being retired in
early 2027. The cleaned dataset is committed as
`data/processed/mississippi_br_daily.csv`, so results stay reproducible.

`python/recover_legacy_alignment.py` showed what the thesis `.mat` files are:
**daily** values of the same gauge from **2011-02-16 to 2018-03-22**. The stage
matches USGS with r = 0.9997, humidity matches BTR with r = 0.98, and rain
matches BTR with r = 0.90.

## Pipeline

```
python/fetch_data.py   download USGS + ASOS (data/raw/, not committed)
python/dataset.py      clean, build data/processed/mississippi_br_daily.csv
python/train.py        train + evaluate vs baselines -> python/reports/
python/export.py       model -> Vivado/HLS/model_params.h, tanh_lut.h, golden vectors
Vivado/HLS             topann IP (inference only, all AXI4-Lite)
Zynq7K/Software        UIO driver, feature extraction, predictor app
```

The same definitions are used everywhere:
- The feature table in `python/dataset.py` is exported to `model_params.h`, and
  `Zynq7K/Software/features.cpp` interprets it, so Python and C++ cannot drift apart.
- The fixed-point arithmetic (Q8.24, round half to even, saturation, 4096-entry
  tanh table over [-8, 8)) is specified once in `python/fixedpoint.py`.
- `topann.cpp` (HLS) and `ann_ref.cpp` (CPU) match it bit for bit.

### Reproduce and test (no hardware needed)

```bash
python3 -m venv .venv && .venv/bin/pip install -r python/requirements.txt
.venv/bin/python python/fetch_data.py          # optional: data/processed is committed
.venv/bin/python python/dataset.py
.venv/bin/python python/recover_legacy_alignment.py
.venv/bin/python python/train.py --flood-stage 30
.venv/bin/python python/export.py --flood-stage 30 --horizon 5

.venv/bin/python -m pytest python/tests        # data, labels, causality, split, fixed point, metrics
make -C Vivado/HLS csim                        # HLS source vs golden vectors (outputs + pre-activations)
make -C Zynq7K/Software host-test              # driver vs simulated IP + full C++ replay of 2021-2026
```

### Build the hardware (Vivado HLS / Vivado 2017.4)

1. `cd Vivado/HLS && vivado_hls -f run_hls.tcl`
   - This runs csim, csynth, cosim and IP export for the WO-OPT, PIPELINE and
     FULL-PIPE variants.
   - It copies the generated `xtopann_hw.h` to `Zynq7K/Software/`.
   - All variants share one register map, so dynamic reconfiguration keeps
     working with one driver. Do not add `array_partition` on the interface
     arrays: it changes the map.
2. In the Vivado block design (`Vivado/Syntesis`):
   - Replace `TOPANN 1.4` with the new `topann` IP. Keep the instance name
     **TOPANN_0** and the address **0x43C00000 / 64K**, so the device tree node
     still applies.
   - Remove `axi_smc` and the S_AXI_ACP connections: the new IP has no AXI master.
3. Generate the bitstreams and replace the ones in `Zynq7K/bitstreams/`. The
   old bitstreams contain the old IP and do not work with the new driver.

### Run on the board

```bash
make -C Zynq7K/Software arm                    # needs the regenerated xtopann_hw.h
# copy predictor.bin, Zynq7K/script/fpga.sh and data/processed/golden_replay.csv to the board
./fpga.sh topann.bit
./predictor.bin --replay golden_replay.csv --check   # FPGA vs CPU vs Python, expect 0 mismatches
./predictor.bin < daily_readings.csv                 # date,stage_br,q_vicks,q_thebes,rain_BTR
```

`fpga.sh` pauses a running predictor while the PL is reprogrammed, then sends
it `SIGHUP` to reload the weights. A new bitstream starts with empty weight
registers.

## What was wrong in the thesis version

| Problem | Effect | Fix |
|---|---|---|
| MATLAB's `feedforwardnet` applies `mapminmax` to the inputs; the exported `IW/LW/b` were used without it | Accuracy fell from 99% in MATLAB to ~53% on the hardware path | Normalization is exported with the model and applied in `features.cpp` |
| `loadWeigths()` accumulated pointer offsets (`ptr += i*100 + j*10 + k`) | Only 6 of 16 parameters reached their register; the IP always answered "no flood" | Direct indexing; host test checks every register |
| The completion loop `while(check >= 6)` exited while the IP was still running | The result was read before it existed | Wait for `ap_done`, with a timeout |
| Inputs and output were mapped through `/dev/mem` at physical page 0, and the m_axi pointer registers were never written | Undefined data path; writes into Linux RAM | All ports are AXI4-Lite through UIO; no `/dev/mem` |
| Labels were `stage(t) > 30 ft`, computed from one of the inputs, and shifted by one sample (`T[:-1]` instead of `T[1:]`) | The model detected an ongoing flood instead of forecasting one | Labels are `max(stage[t+1..t+H]) > 30 ft`, with features that only use data up to t |
| `fi(...,1,32,28)` saturates at ±8 while the HLS type is Q8.24 | Two weights clipped | One Q8.24 spec; export fails if a weight exceeds the limit |
| Random train/test split of a time series; evaluation on the training data | Optimistic accuracy | Chronological split, baselines, event-level metrics |

## Legacy (thesis) files

These are kept unchanged for reference:
- `Matlab/`
- `Vivado/HLS/{ANN.cpp,main.cpp,hardware.h,coe3.h,dataset.h}` and the old solution folders
- `Zynq7K/Software/{main.cpp,hardware.h,coe3.h,accel.bin,annFINAL.bit}`
- `Zynq7K/bitstreams/`

### Petalinux on ZYNQ7000
- Compiled with an Ubuntu 16 LTS file system.
- The device tree (`Zynq7K/Device Tree Source`) includes the UIO node for the
  accelerator and the gigabit Ethernet driver.
- Boot files are in `Zynq7K/Petalinux Boot Files`.
