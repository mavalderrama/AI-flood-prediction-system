"""Train and evaluate flood forecasters for the Mississippi River at Baton Rouge.

For each horizon H (days) the label is "stage exceeds the flood stage on any
of the next H days". Models are compared on a chronological split:
  * persistence  (flooded tomorrow if flooded today)
  * trend        (stage + alpha * H * 3-day slope > flood stage, alpha tuned on val)
  * logistic regression
  * MLP local    (only Baton Rouge stage/rain: ablation without upstream gauges)
  * MLP          (all features; the architecture the FPGA runs)

The headline metric is F1 on days when the river is NOT already in flood
("onset" days): predicting that a flood continues is trivial, predicting that
one is coming is the actual forecasting problem.

Usage:  python python/train.py [--flood-stage 30] [--seeds 3]
Writes python/reports/metrics_<stage>ft.md and python/reports/models_<stage>ft.json
"""
from __future__ import annotations

import argparse
import itertools
import json

import numpy as np
import pandas as pd

import config
import dataset
import models

LOCAL_FEATURES = ("stage", "d_stage_1d", "d_stage_3d", "rain_BTR_7d")
HIDDEN = (4, 6, 8)
L2 = (1e-4, 1e-3, 1e-2)


def split_eval(name, score, thr, y, valid, stage, split_mask, flood_stage, horizon):
    """Metrics on one split. `score > thr` is the alarm."""
    m = split_mask & valid
    alarm = score > thr
    onset_days = m & (stage <= flood_stage)
    seg = np.flatnonzero(split_mask)
    ev = models.event_metrics(np.where(valid[seg], alarm[seg], False),
                              np.nan_to_num(stage[seg], nan=-np.inf), flood_stage, horizon)
    return {
        "model": name,
        "all": models.prf(alarm[m], y[m]),
        "onset": models.prf(alarm[onset_days], y[onset_days]),
        "events": ev,
    }


def run_horizon(df, feats, horizon, flood_stage, split, seeds, log):
    y_s = dataset.make_labels(df[config.TARGET_COL], horizon, flood_stage)
    X = feats.to_numpy()
    y = y_s.to_numpy()
    stage = df[config.TARGET_COL].to_numpy()
    valid = ~np.isnan(X).any(axis=1) & ~np.isnan(y)
    masks = split.masks(df.index)
    tr, va = masks["train"] & valid, masks["val"] & valid
    y0 = np.nan_to_num(y)

    norm = dataset.Normalizer.fit(X[tr])
    Z = models.clip_inputs(norm(np.nan_to_num(X)))
    nonflood_va = va & (stage <= flood_stage)

    results = {}

    # Persistence: no parameters.
    results["persistencia"] = (np.where(stage > flood_stage, 1.0, -1.0), 0.0, None)

    # Trend extrapolation, alpha tuned on validation onset F1.
    slope = feats["d_stage_3d"].to_numpy() / 3.0
    best = (-1.0, 0.0)
    for alpha in np.linspace(0, 2, 21):
        pred = stage + alpha * horizon * slope > flood_stage
        f = models.prf(pred[nonflood_va], y0[nonflood_va])["f1"]
        if f > best[0]:
            best = (f, alpha)
    alpha = best[1]
    results["tendencia"] = (np.where(stage + alpha * horizon * slope > flood_stage, 1.0, -1.0), 0.0, {"alpha": alpha})

    # Logistic regression.
    lr = models.fit_logistic(Z[tr], y0[tr])
    s = lr(Z)
    results["logistica"] = (s, models.best_threshold(s, y0, nonflood_va), None)

    def select_mlp(cols):
        idx = [list(feats.columns).index(c) for c in cols]
        best = None
        for hidden, l2, seed in itertools.product(HIDDEN, L2, range(seeds)):
            mlp = models.fit_mlp(Z[tr][:, idx], y0[tr], hidden, l2, seed)
            sc = mlp(Z[:, idx])
            thr = models.best_threshold(sc, y0, nonflood_va)
            f = models.prf(sc[nonflood_va] > thr, y0[nonflood_va])["f1"]
            if best is None or f > best[0]:
                best = (f, mlp, thr, {"hidden": hidden, "l2": l2, "seed": seed})
        return best

    _, mlp_l, thr_l, cfg_l = select_mlp(LOCAL_FEATURES)
    idx_l = [list(feats.columns).index(c) for c in LOCAL_FEATURES]
    results["MLP solo local"] = (mlp_l(Z[:, idx_l]), thr_l, cfg_l)

    _, mlp, thr, cfg = select_mlp(list(feats.columns))
    results["MLP"] = (mlp(Z), thr, cfg)

    # Quantized (bit-exact hardware) version of the selected MLP.
    q = mlp.quantized()
    sq = q(Z)
    results["MLP Q8.24 (FPGA)"] = (sq, thr, cfg)

    out = {"horizon": horizon, "flood_stage": flood_stage, "splits": {}}
    for split_name in ("val", "test"):
        out["splits"][split_name] = [
            split_eval(name, sc, t, y0, valid, stage, masks[split_name], flood_stage, horizon)
            for name, (sc, t, _) in results.items()
        ]
    te = masks["test"] & valid
    out["quantization_agreement_test"] = float(np.mean((sq[te] > thr) == (results["MLP"][0][te] > thr)))
    out["max_abs_score_diff_test"] = float(np.max(np.abs(sq[te] - results["MLP"][0][te])))
    out["configs"] = {name: c for name, (_, _, c) in results.items() if c}
    out["model"] = {
        "features": list(feats.columns), "W1": mlp.W1.tolist(), "b1": mlp.b1.tolist(),
        "W2": mlp.W2.tolist(), "b2": mlp.b2, "threshold": thr,
        "norm_mean": norm.mean.tolist(), "norm_std": norm.std.tolist(),
        "max_abs_weight": float(max(np.abs(mlp.W1).max(), np.abs(mlp.b1).max(), np.abs(mlp.W2).max(), abs(mlp.b2))),
    }
    log(f"  H={horizon}d done: MLP {cfg}, thr={thr:.3f}, quantization agreement {out['quantization_agreement_test']:.4f}")
    return out


def fmt_report(all_out, flood_stage, split):
    lines = [
        f"# Pronóstico de inundación — Mississippi River at Baton Rouge (umbral {flood_stage:g} ft)",
        "",
        "Generado por `python/train.py`. Datos diarios USGS 07374000 (nivel), 07289000 (caudal en Vicksburg),",
        "07022000 (caudal en Thebes) y lluvia diaria de KBTR.",
        f"Split cronológico: train ≤ {split.train_end}, validación ≤ {split.val_end}, test después.",
        "",
        "**F1 inicio** = F1 solo en días en que el río NO está ya inundado (predecir que la inundación",
        "continúa es trivial; esta métrica mide si el modelo anticipa una inundación nueva).",
        "**Eventos avisados** = inicios de inundación con al menos una alarma en los H días previos.",
        "",
    ]
    for out in all_out:
        h = out["horizon"]
        lines += [f"## Horizonte {h} día(s)", "",
                  "| Modelo | F1 inicio (val) | P / R / F1 inicio (test) | F1 global (test) | Eventos avisados (test) | Anticipación mediana | Falsas alarmas/año |",
                  "|---|---|---|---|---|---|---|"]
        val = {r["model"]: r for r in out["splits"]["val"]}
        for r in out["splits"]["test"]:
            o, a, e = r["onset"], r["all"], r["events"]
            lines.append(
                f"| {r['model']} | {val[r['model']]['onset']['f1']:.2f} | {o['precision']:.2f} / {o['recall']:.2f} / {o['f1']:.2f} "
                f"| {a['f1']:.2f} | {e['warned']}/{e['events']} | {e['median_lead_days']:.0f} d | {e['false_alarms_per_year']:.1f} |")
        lines += ["", f"Configuración MLP elegida en validación: `{out['configs'].get('MLP')}`; "
                      f"concordancia float vs Q8.24 en test: {out['quantization_agreement_test']:.4f} "
                      f"(máx. |Δscore| = {out['max_abs_score_diff_test']:.4f}).", ""]
    return "\n".join(lines)


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--flood-stage", type=float, default=config.FLOOD_STAGE_FT)
    ap.add_argument("--seeds", type=int, default=3)
    ap.add_argument("--horizons", type=int, nargs="*", default=config.HORIZONS_DAYS)
    args = ap.parse_args()

    df = dataset.load_processed()
    feats = dataset.make_features(df)
    split = dataset.Split()
    all_out = []
    for h in args.horizons:
        all_out.append(run_horizon(df, feats, h, args.flood_stage, split, args.seeds, print))

    config.REPORTS.mkdir(parents=True, exist_ok=True)
    tag = f"{args.flood_stage:g}ft"
    (config.REPORTS / f"metrics_{tag}.md").write_text(fmt_report(all_out, args.flood_stage, split))
    (config.REPORTS / f"models_{tag}.json").write_text(json.dumps(all_out, indent=1))
    print(f"wrote {config.REPORTS / f'metrics_{tag}.md'}")


if __name__ == "__main__":
    main()
