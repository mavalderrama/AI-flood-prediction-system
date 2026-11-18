# Building for the board: AMD 2026.2 + EDF (Yocto)

AMD replaced PetaLinux with the **Embedded Development Framework (EDF)**,
which is Yocto-based, starting with release 2025.1. This guide targets the
latest release, **AMD 2026.2 / EDF v26.11** (Yocto Wrynose, kernel 6.18). The
2017.4 flow of the thesis (Vivado HLS, `.hdf`, PetaLinux, `/dev/xdevcfg`) no
longer works with current tools.

> **Status:** written against the AMD 2026.2 / EDF v26.11 documentation and
> not yet built on a ZYBO. The app, driver and fixed-point model are tested on
> the host (`make -C Zynq7K/Software host-test`). The Vivado, sdtgen and
> BitBake steps have not been run. EDF documents Zynq-7000 custom boards only
> partially (sdtgen, SD boot mode, the ZC706 BSP), so expect to check the
> points under [Troubleshooting](#troubleshooting).

## What changed from the thesis setup

| | Thesis (2017.4) | Now (2026.2 / EDF v26.11) |
|---|---|---|
| HLS | `vivado_hls -f`, `open_project/open_solution` | `vitis-run --mode hls --tcl`, `open_component` |
| Hardware | hand-made Vivado project, ACP + SmartConnect | `Vivado/build_hw.tcl` rebuilds the block design; AXI4-Lite only |
| Handoff | `.hdf` | `.xsa` → System Device Tree (`sdtgen`) |
| Linux | PetaLinux, `system-user.dtsi`, bootargs | EDF/Yocto, layer `Yocto/meta-flood`, `gen-machine-conf parse-sdt` |
| UIO binding | `uio_pdrv_genirq.of_id=generic-uio` bootarg | module option in `/etc/modprobe.d` (no bootargs) |
| PL loading | `cat x.bit > /dev/xdevcfg` | FPGA Manager with byte-swapped `.bit.bin` (`topann-load`) |
| App build | Linaro `arm-linux-gnueabihf-g++` | BitBake recipe `flood-predictor` (or the EDF SDK `$CXX`) |

## Steps

Prerequisites:
- AMD 2026.2 tools: Vivado, `vitis-run`, `bootgen`, `sdtgen`.
- A Linux build host for Yocto.
- Run commands from the repository root unless noted.

### 1. HLS IP

```bash
cd Vivado/HLS && vitis-run --mode hls --tcl run_hls.tcl && cd ../..
```

This builds the WO-OPT, PIPELINE and FULL-PIPE components. Each one runs
C simulation against the golden vectors, synthesis, co-simulation and IP
export. It then copies the generated `xtopann_hw.h` to `Zynq7K/Software/`.
Commit that header: the app recipe uses it.

### 2. Hardware (bitstream + XSA)

```bash
vivado -mode batch -source Vivado/build_hw.tcl -tclargs WO-OPT
vivado -mode batch -source Vivado/build_hw.tcl -tclargs PIPELINE    # optional variants
vivado -mode batch -source Vivado/build_hw.tcl -tclargs FULL-PIPE
```

The script:
- Uses the Digilent ZYBO board files if they are installed. Otherwise it
  applies the PS7 settings of the thesis design: DDR3 MT41K128M16, UART1,
  SD0, ENET0, USB0, QSPI and the MIO electrical settings.
- Places `TOPANN_0` at **0x43C00000 / 64K**, with FCLK0 = 100 MHz.
- Stops with an error if implementation misses timing at 100 MHz (WNS or
  WHS < 0): such a bitstream would give occasional wrong results on the board.
- Writes `Vivado/build/<variant>/topann_zybo.xsa`,
  `Zynq7K/bitstreams/topann-<variant>.bit` and `.bit.bin`. The `.bit.bin` is
  made with `bootgen -arch zynq -process_bitstream bin`, as the Zynq-7000
  FPGA Manager requires.

### 3. System Device Tree

```bash
sdtgen Yocto/sdt.tcl
```

This writes `build/sdt/` and merges `Yocto/dts/topann-user.dtsi`, which marks
`TOPANN_0` as `generic-uio`.

### 4. EDF workspace and image (Linux host)

```bash
mkdir edf && cd edf
repo init -u https://github.com/Xilinx/yocto-manifests.git -b refs/tags/amd-edf-rel-v26.11 -m default-edf.xml
repo sync
source edf-init-build-env

REPO=/path/to/AI-flood-prediction-system
bitbake-layers add-layer $REPO/Yocto/meta-flood
gen-machine-conf parse-sdt --hw-description $REPO/build/sdt \
    -c $REPO/Yocto/meta-flood/conf --machine-name zybo-topann \
    --add-config CONFIG_SUBSYSTEM_BOOTMODE_5=y          # SD boot on Zynq-7000

cat >> conf/local.conf <<'EOF'
IMAGE_INSTALL:append = " flood-predictor"
TOPANN_VARIANTS = "WO-OPT"          # add PIPELINE FULL-PIPE if you built them
EOF

MACHINE=zybo-topann bitbake edf-linux-disk-image
MACHINE=zybo-topann bitbake xilinx-bootbin
```

`meta-flood` provides:
- **`flood-predictor`**: installs `/usr/bin/flood-predictor`,
  `/usr/bin/topann-load`, the bitstreams in `/lib/firmware/topann/`, the
  golden replay in `/usr/share/flood-predictor/`, and `/etc/modprobe.d` plus
  `/etc/modules-load.d` entries for `uio_pdrv_genirq`.
- **`linux-xlnx_%.bbappend`**: the kernel fragment `topann.cfg`, with UIO,
  `uio_pdrv_genirq` as a module, the Zynq FPGA Manager and `/dev/mem`.

### 5. On the board

```bash
topann-load WO-OPT          # programs the PL via FPGA Manager (skip if BOOT.BIN already does)
flood-predictor --replay /usr/share/flood-predictor/golden_replay.csv --check
#   expect: hw_cpu_mismatch=0 hw_timeouts=0 expected_mismatch=0
flood-predictor < daily_readings.csv     # date,stage_br,q_vicks,q_thebes,rain_BTR
```

Use `topann-load <variant>` to switch variants at runtime (dynamic
reconfiguration).
- It stops running predictors while the PL is reprogrammed, because an AXI
  access to an unconfigured PL stalls the bus.
- It resumes them only if programming succeeded. After a failure they stay
  stopped until a later successful `topann-load`, or until you kill them.
- The driver notices the empty weight registers of the new bitstream by itself
  and reloads them. The summary line reports `weight_reloads=`.
- `flood-predictor` refuses to start while
  `/sys/class/fpga_manager/fpga0/state` is not `operating`
  (`--skip-pl-check` overrides this).

### Without BitBake (EDF SDK)

```bash
source /opt/edf-sdk/environment-setup-*      # SDK made with: bitbake edf-linux-disk-image -c populate_sdk
make -C Zynq7K/Software arm                  # uses the SDK's $CXX (sysroot, hard-float)
```

## Troubleshooting

- **sdtgen: label `TOPANN_0` not found.** Open `build/sdt/pl.dtsi`, find the
  label of the node at `43c00000`, and use it in `Yocto/dts/topann-user.dtsi`.
- **`no UIO device for the topann IP`.** Check the following:
  - `ls /sys/class/uio` and `grep -ri topann /sys/class/uio/*/name`.
  - `modprobe uio_pdrv_genirq of_id=generic-uio`. Images without systemd
    don't read `/etc/modules-load.d`; add `uio_pdrv_genirq` to `/etc/modules`.
  - Whether the device tree has the node: `ls /proc/device-tree/*/ | grep -i 43c00000`.
  - For bring-up without UIO: `flood-predictor --devmem ...` (root).
- **`the PL is not configured`.** Run `topann-load WO-OPT`, or include the
  bitstream in BOOT.BIN. If the PL is programmed by something the FPGA
  Manager doesn't track (for example JTAG), use `--skip-pl-check`.
- **Predictors stuck in state `T` after `topann-load` failed.** This is
  intentional, so they don't touch an unconfigured PL. Fix the bitstream and
  run `topann-load` again (they resume), or kill them.
- **`accelerator timeout (ap_done never set)`.** Check the following:
  - The PL is programmed: `cat /sys/class/fpga_manager/fpga0/state` should say `operating`.
  - FCLK0 is running. Linux may gate unused PL clocks; check that the `clkc`
    node has `fclk-enable = <0x1>` (`/proc/device-tree/.../fclk-enable`), or
    boot once with `clk_ignore_unused` to confirm.
- **FPGA Manager rejects the file** ("could not find a sync word"). Use the
  `.bit.bin` from `build_hw.tcl`, not Vivado's `write_bitstream -bin_file`
  output, which is not byte-swapped.
- **`edf-linux-disk-image` does not build for the Zynq-7000 machine.** EDF
  does not document a Zynq-7000 disk image for custom boards. Build
  `core-image-minimal` with the same layer and machine instead, and boot it
  with the BOOT.BIN from `xilinx-bootbin`.

## Sources

- [AMD EDF documentation](https://edf.docs.amd.com/en/latest/): release notes, custom hardware (sdtgen), Yocto setup
- [AMD downloads, 2026.1](https://www.amd.com/en/support/downloads/adaptive-socs-and-fpgas/development-tools/2026-1.html) and the [PetaLinux SDK page](https://www.amd.com/en/products/software/adaptive-socs-and-fpgas/embedded-software/petalinux-sdk.html) (PetaLinux superseded by EDF)
- [gen-machine-conf](https://github.com/Xilinx/gen-machine-conf)
- [Vitis HLS: migrating to the Vitis Unified IDE (UG1399)](https://docs.amd.com/r/en-US/ug1399-vitis-hls/Migrating-from-Vitis-HLS-to-the-Vitis-Unified-IDE)
- [Zynq PL programming with FPGA Manager](https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841645/Solution+Zynq+PL+Programming+With+FPGA+Manager)
