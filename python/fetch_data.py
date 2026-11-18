"""Download the raw inputs for the forecasting dataset.

* USGS daily means (statistic 00003) from the Water Data OGC API
  (api.waterdata.usgs.gov, collection "daily"). The legacy waterservices API
  is being retired in early 2027, so it is not used.
* ASOS hourly precipitation (p01i, inches) and relative humidity (relh, %)
  from the Iowa Environmental Mesonet; aggregated to days in dataset.py.

Raw files are cached in data/raw/. Completed years of ASOS data are not
re-downloaded; USGS daily series are always refreshed (one request each).

Usage:  python python/fetch_data.py
"""
from __future__ import annotations

import argparse
import csv
import io
import time
import urllib.error
import urllib.parse
import urllib.request
from datetime import date, datetime, timezone

import config

USGS_DAILY_URL = "https://api.waterdata.usgs.gov/ogcapi/v0/collections/daily/items"
IEM_URL = "https://mesonet.agron.iastate.edu/cgi-bin/request/asos.py"
USGS_PAGE_LIMIT = 50000


def _get(url: str, retries: int = 5) -> str:
    req = urllib.request.Request(url, headers={"User-Agent": config.HTTP_USER_AGENT})
    for attempt in range(retries):
        try:
            with urllib.request.urlopen(req, timeout=180) as resp:
                return resp.read().decode("utf-8")
        except (urllib.error.URLError, TimeoutError) as exc:
            wait = 5 * 2 ** attempt
            print(f"    retry {attempt + 1}/{retries} in {wait}s ({exc})")
            time.sleep(wait)
    raise RuntimeError(f"failed after {retries} attempts: {url}")


def fetch_usgs_daily(site: str, pcode: str, start: str, end: str) -> int:
    params = {
        "f": "csv",
        "monitoring_location_id": f"USGS-{site}",
        "parameter_code": pcode,
        "statistic_id": "00003",
        "time": f"{start}/{end}",
        "properties": "time,value,approval_status",
        "skipGeometry": "true",
        "limit": str(USGS_PAGE_LIMIT),
    }
    text = _get(USGS_DAILY_URL + "?" + urllib.parse.urlencode(params))
    rows = [(r["time"], r["value"], r.get("approval_status", "")) for r in csv.DictReader(io.StringIO(text))]
    if len(rows) >= USGS_PAGE_LIMIT:
        raise RuntimeError("daily page limit reached; split the request")
    rows.sort()
    out = config.DATA_RAW / f"usgs_daily_{site}_{pcode}.csv"
    with out.open("w", newline="") as fh:
        w = csv.writer(fh)
        w.writerow(["date", "value", "approval_status"])
        w.writerows(rows)
    return len(rows)


def fetch_asos(station: str, first_year: int, last_year: int) -> None:
    now_year = datetime.now(timezone.utc).year
    for year in range(first_year, last_year + 1):
        out = config.DATA_RAW / f"asos_{station}_{year}.csv"
        if out.exists() and year < now_year:
            continue
        params = [
            ("station", station), ("data", "p01i"), ("data", "relh"),
            ("year1", year), ("month1", 1), ("day1", 1),
            ("year2", year + 1), ("month2", 1), ("day2", 1),
            ("tz", "Etc/UTC"), ("format", "onlycomma"), ("latlon", "no"),
            ("missing", "M"), ("trace", "0.0001"), ("direct", "no"),
            ("report_type", "3"),  # routine hourly METARs only
        ]
        text = _get(IEM_URL + "?" + urllib.parse.urlencode(params))
        out.write_text(text)
        print(f"  ASOS {station} {year}: {text.count(chr(10)) - 1} rows")
        time.sleep(2)  # be polite to IEM


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--start", default=config.START)
    ap.add_argument("--end", default=date.today().isoformat())
    args = ap.parse_args()
    config.DATA_RAW.mkdir(parents=True, exist_ok=True)
    for col, (site, pcode) in config.USGS_DAILY.items():
        n = fetch_usgs_daily(site, pcode, args.start, args.end)
        print(f"USGS {site} {pcode} ({col}): {n} days")
    for stn in config.ASOS_STATIONS:
        print(f"ASOS {stn}")
        fetch_asos(stn, int(args.start[:4]), int(args.end[:4]))


if __name__ == "__main__":
    main()
