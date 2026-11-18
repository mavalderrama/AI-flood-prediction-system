"""Shared configuration for the flood-forecasting pipeline.

The thesis dataset (Matlab/*.mat) turned out to be DAILY data for the
Mississippi River at Baton Rouge, 2011-02-16 .. 2018-03-22 (see
recover_legacy_alignment.py). The forecasting system keeps that target and
adds upstream gauges for lead time.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATA_RAW = ROOT / "data" / "raw"
DATA_PROCESSED = ROOT / "data" / "processed"
REPORTS = ROOT / "python" / "reports"
HLS_DIR = ROOT / "Vivado" / "HLS"
ZYNQ_SW_DIR = ROOT / "Zynq7K" / "Software"

# Vicksburg daily discharge starts 2008-01-01, which bounds the dataset.
# (Memphis has no daily discharge 2008-2014 and Ohio R. at Metropolis ends in 2015, so neither is used.)
START = "2008-01-01"

# USGS daily means (statistic 00003). column name -> (site, parameter code)
USGS_DAILY = {
    "stage_br": ("07374000", "00065"),   # Mississippi River at Baton Rouge, gage height (ft)  TARGET
    "q_vicks": ("07289000", "00060"),    # Mississippi River at Vicksburg, discharge (cfs)    ~3-4 days upstream
    "q_thebes": ("07022000", "00060"),   # Mississippi River at Thebes, IL, discharge (cfs)   upper Miss + Missouri, ~8-10 days
}
TARGET_COL = "stage_br"

# Weather: ASOS hourly reports aggregated to local-standard-time days (UTC-6).
ASOS_STATIONS = ["BTR"]
LOCAL_UTC_OFFSET_H = -6

# Flood definition. The thesis used stage > 30 ft; the NWS flood stage at Baton Rouge is 35 ft.
FLOOD_STAGE_FT = 30.0
NWS_FLOOD_STAGE_FT = 35.0
HORIZONS_DAYS = [1, 3, 5, 7]

HTTP_USER_AGENT = "flood-forecast-research/1.0"
