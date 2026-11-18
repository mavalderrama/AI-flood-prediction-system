"""Daily dataset construction: loading, cleaning, causal features, labels, splits.

Conventions
-----------
* Index: daily DatetimeIndex (local calendar days, as USGS daily values use).
  The row for day t holds information available at the end of day t.
* Features at t only use rows <= t. Labels at t only use rows > t.
* The feature table (FEATURES) is exported to model_params.h and interpreted
  by Zynq7K/Software/features.cpp, so Python and C++ use one definition.
"""
from __future__ import annotations

from dataclasses import dataclass, field

import numpy as np
import pandas as pd

import config

MAX_GAP_DAYS = 3          # interior gaps up to this length are linearly interpolated
STAGE_SPIKE_FT = 5.0      # |stage - 7-day rolling median| above this is a glitch
MIN_ASOS_REPORTS = 20     # hourly reports needed for a valid daily rain total

# Columns of one daily input row, in the order the C++ side receives them.
INPUT_COLUMNS = ["stage_br", "q_vicks", "q_thebes", "rain_BTR"]


@dataclass(frozen=True)
class Feature:
    name: str
    kind: str        # "level" | "delta" | "sum"
    column: str      # one of INPUT_COLUMNS
    param: int = 0   # delta: lag in days; sum: window in days


FEATURES: tuple[Feature, ...] = (
    Feature("stage", "level", "stage_br"),
    Feature("d_stage_1d", "delta", "stage_br", 1),
    Feature("d_stage_3d", "delta", "stage_br", 3),
    Feature("q_vicks", "level", "q_vicks"),
    Feature("d_q_vicks_3d", "delta", "q_vicks", 3),
    Feature("q_thebes", "level", "q_thebes"),
    Feature("d_q_thebes_3d", "delta", "q_thebes", 3),
    Feature("rain_BTR_7d", "sum", "rain_BTR", 7),
)
FEATURE_KINDS = {"level": 0, "delta": 1, "sum": 2}


def history_days(features: tuple[Feature, ...] = FEATURES) -> int:
    """Rows (including t) needed to compute one feature vector."""
    need = 1
    for f in features:
        if f.kind == "delta":
            need = max(need, f.param + 1)
        elif f.kind == "sum":
            need = max(need, f.param)
    return need


# --------------------------------------------------------------------------- loading
def load_usgs_daily(site: str, pcode: str) -> pd.Series:
    path = config.DATA_RAW / f"usgs_daily_{site}_{pcode}.csv"
    if not path.exists():
        raise FileNotFoundError(f"{path} missing; run python/fetch_data.py")
    df = pd.read_csv(path, parse_dates=["date"])
    s = pd.Series(pd.to_numeric(df["value"], errors="coerce").values, index=df["date"]).sort_index()
    return s[~s.index.duplicated(keep="last")].asfreq("1D")


def load_asos_hourly(station: str) -> pd.DataFrame:
    files = sorted(config.DATA_RAW.glob(f"asos_{station}_*.csv"))
    if not files:
        raise FileNotFoundError(f"no ASOS files for {station}; run python/fetch_data.py")
    df = pd.concat([pd.read_csv(f, na_values=["M"]) for f in files], ignore_index=True)
    df.index = pd.to_datetime(df["valid"], utc=True)
    df = df.sort_index()
    return df[~df.index.duplicated(keep="last")]


def load_asos_daily(station: str) -> pd.DataFrame:
    """Daily totals/means over local standard time days."""
    h = load_asos_hourly(station)
    local = h.index.tz_convert(None) + pd.Timedelta(hours=config.LOCAL_UTC_OFFSET_H)
    h = h.set_index(local)
    rain = h["p01i"].astype(float)
    n_reports = h["p01i"].resample("1D").size()
    daily_rain = rain.resample("1D").sum(min_count=1).where(n_reports >= MIN_ASOS_REPORTS)
    return pd.DataFrame({
        f"rain_{station}": daily_rain,
        f"relh_{station}": h["relh"].astype(float).resample("1D").mean(),
    })


# --------------------------------------------------------------------------- cleaning
def despike(s: pd.Series, window: int = 7, thresh: float = STAGE_SPIKE_FT) -> pd.Series:
    med = s.rolling(window, center=True, min_periods=1).median()
    return s.mask((s - med).abs() > thresh)


def fill_short_gaps(s: pd.Series, max_gap: int = MAX_GAP_DAYS) -> pd.Series:
    """Linearly interpolate interior gaps of at most `max_gap` samples; leave longer gaps NaN."""
    isna = s.isna()
    run_id = (isna != isna.shift()).cumsum()
    run_len = isna.groupby(run_id).transform("sum")
    interp = s.interpolate(method="linear", limit_area="inside")
    return s.where(~isna, interp.where(run_len <= max_gap))


def build_daily_frame() -> pd.DataFrame:
    cols = {name: load_usgs_daily(site, pc) for name, (site, pc) in config.USGS_DAILY.items()}
    df = pd.DataFrame(cols)
    for stn in config.ASOS_STATIONS:
        df = df.join(load_asos_daily(stn), how="left")
    df = df.loc[config.START:]
    df["stage_br"] = despike(df["stage_br"])
    for c in df.columns:
        df[c] = fill_short_gaps(df[c])
    df.index.name = "date"
    return df


def processed_path():
    return config.DATA_PROCESSED / "mississippi_br_daily.csv"


def load_processed() -> pd.DataFrame:
    return pd.read_csv(processed_path(), parse_dates=["date"], index_col="date").asfreq("1D")


# --------------------------------------------------------------------------- features / labels
def make_features(df: pd.DataFrame, features: tuple[Feature, ...] = FEATURES) -> pd.DataFrame:
    out = {}
    for f in features:
        col = df[f.column]
        if f.kind == "level":
            out[f.name] = col
        elif f.kind == "delta":
            out[f.name] = col - col.shift(f.param)
        elif f.kind == "sum":
            out[f.name] = col.rolling(f.param, min_periods=f.param).sum()
        else:
            raise ValueError(f.kind)
    return pd.DataFrame(out, index=df.index)


def make_labels(stage: pd.Series, horizon: int, flood_stage: float = config.FLOOD_STAGE_FT) -> pd.Series:
    """y(t) = 1 if max(stage[t+1 .. t+H]) > flood_stage; NaN if any of those days is missing."""
    fut = pd.concat([stage.shift(-k) for k in range(1, horizon + 1)], axis=1)
    y = (fut.max(axis=1) > flood_stage).astype(float)
    y[fut.isna().any(axis=1)] = np.nan
    return y.rename(f"flood_next_{horizon}d")


# --------------------------------------------------------------------------- splits
@dataclass(frozen=True)
class Split:
    train_end: str = "2016-12-31"
    val_end: str = "2020-12-31"
    # test: val_end+1 .. end

    def masks(self, index: pd.DatetimeIndex) -> dict[str, np.ndarray]:
        te, ve = pd.Timestamp(self.train_end), pd.Timestamp(self.val_end)
        return {
            "train": np.asarray(index <= te),
            "val": np.asarray((index > te) & (index <= ve)),
            "test": np.asarray(index > ve),
        }


@dataclass
class Normalizer:
    """x_n = (x - mean) / std, statistics from the training split only."""
    mean: np.ndarray = field(default_factory=lambda: np.zeros(0))
    std: np.ndarray = field(default_factory=lambda: np.ones(0))

    @classmethod
    def fit(cls, X: np.ndarray) -> "Normalizer":
        std = X.std(axis=0)
        std[std == 0] = 1.0
        return cls(mean=X.mean(axis=0), std=std)

    def __call__(self, X: np.ndarray) -> np.ndarray:
        return (X - self.mean) / self.std


def main() -> None:
    df = build_daily_frame()
    config.DATA_PROCESSED.mkdir(parents=True, exist_ok=True)
    df.to_csv(processed_path(), float_format="%.10g")
    print(f"wrote {processed_path()} ({len(df)} days, {df.index.min().date()} .. {df.index.max().date()})")
    print(df.isna().sum().to_string())


if __name__ == "__main__":
    main()
