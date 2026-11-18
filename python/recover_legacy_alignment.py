"""Identify where the thesis dataset (Matlab/*.mat) came from.

The .mat files have no timestamps. This slides each legacy column over the
corresponding daily series and reports the best match:
  * stage    vs USGS 07374000 (Mississippi River at Baton Rouge) daily mean
  * humidity vs ASOS BTR daily mean relative humidity
  * rain     vs ASOS BTR daily precipitation (checked at the stage offset)
It also checks which target alignment is right (the targets file has a
leading NaN) and the stage threshold that generated the original labels.

Result (2026-11): stage matches with r = 0.9997 starting 2011-02-16, i.e. the
thesis data is DAILY, 2011-02-16 .. 2018-03-22, Mississippi at Baton Rouge.

Writes data/processed/legacy_alignment.json. Exit code 2 if stage does not match.
Requires data/processed/mississippi_br_daily.csv (python/dataset.py).
"""
from __future__ import annotations

import json
import sys

import numpy as np
import pandas as pd
import scipy.io as sio

import config
import dataset

MIN_CORR = 0.95


def load_legacy() -> tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray]:
    X = sio.loadmat(config.ROOT / "Matlab" / "BatonRougeTrainingDataset.mat")["BatonRougeTrainingDataset"].astype(float)
    T = sio.loadmat(config.ROOT / "Matlab" / "BatonRougeTrainingDatasetTargets.mat")["BatonRougeTargets"].ravel()
    return X[:, 0], X[:, 1], X[:, 2], T


def clean_legacy_stage(stage: np.ndarray) -> np.ndarray:
    s = pd.Series(np.where(stage == 0, np.nan, stage))
    return dataset.fill_short_gaps(dataset.despike(s), max_gap=30).to_numpy()


def best_offset(legacy: np.ndarray, series: np.ndarray) -> tuple[int, float]:
    """Offset into `series` maximizing Pearson correlation with `legacy` (no NaNs in legacy)."""
    n = len(legacy)
    a = legacy - legacy.mean()
    a /= np.linalg.norm(a)
    s = pd.Series(series).interpolate(limit_area="inside").to_numpy()
    valid = ~np.isnan(s)
    s0 = np.where(valid, s, 0.0)
    c1, c2, cv = (np.r_[0, np.cumsum(v)] for v in (s0, s0 ** 2, valid))
    mean = (c1[n:] - c1[:-n]) / n
    var = (c2[n:] - c2[:-n]) / n - mean ** 2
    corr = np.correlate(s0, a, mode="valid") / np.sqrt(np.maximum(var, 1e-12) * n)
    corr[(cv[n:] - cv[:-n]) < n] = -np.inf
    k = int(np.argmax(corr))
    return k, float(corr[k])


def main() -> int:
    stage_raw, rain_leg, hum_leg, T = load_legacy()
    df = dataset.load_processed()
    out: dict = {}

    leg_stage = clean_legacy_stage(stage_raw)
    k, corr = best_offset(leg_stage, df["stage_br"].to_numpy())
    start = df.index[k]
    seg = df["stage_br"].iloc[k:k + len(leg_stage)].to_numpy()
    out["stage"] = {
        "usgs_site": config.USGS_DAILY["stage_br"][0], "start": str(start.date()),
        "end": str((start + pd.Timedelta(days=len(leg_stage) - 1)).date()),
        "corr": corr, "rmse_ft": float(np.sqrt(np.nanmean((seg - leg_stage) ** 2))),
        "legacy_zero_rows": int((stage_raw == 0).sum()),
    }
    print(f"stage    vs USGS 07374000 daily: start {start.date()} corr={corr:.4f} rmse={out['stage']['rmse_ft']:.2f} ft")

    kh, ch = best_offset(hum_leg, (df["relh_BTR"] / 100.0).to_numpy())
    out["humidity"] = {"start": str(df.index[kh].date()), "corr": ch}
    print(f"humidity vs BTR daily mean RH:   start {df.index[kh].date()} corr={ch:.4f}")

    r = df["rain_BTR"].iloc[k:k + len(rain_leg)].to_numpy()
    ok = ~np.isnan(r)
    cr = float(np.corrcoef(r[ok], rain_leg[ok])[0, 1])
    ratio = float(np.nanmax(r) / rain_leg.max())
    out["rain"] = {"corr_at_stage_offset": cr, "max_ratio_btr_over_legacy": ratio}
    print(f"rain     vs BTR daily total at the same dates: corr={cr:.3f} (BTR max / legacy max = {ratio:.1f})")

    for name, t in {"T[1:]": T[1:], "T[:-1] (used in dataset.h)": np.where(np.isnan(T[:-1]), -1, T[:-1])}.items():
        pos, neg = stage_raw[t == 1], stage_raw[(t == -1) & (stage_raw > 0)]
        out[f"labels {name}"] = {"min_stage_flood": float(pos.min()), "max_stage_no_flood": float(neg.max())}
        print(f"labels {name}: min stage when flood {pos.min():.2f}, max stage when no flood {neg.max():.2f}")

    config.DATA_PROCESSED.mkdir(parents=True, exist_ok=True)
    (config.DATA_PROCESSED / "legacy_alignment.json").write_text(json.dumps(out, indent=2))
    return 0 if corr >= MIN_CORR else 2


if __name__ == "__main__":
    sys.exit(main())
