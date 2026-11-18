"""Models and metrics: tanh MLP (the hardware architecture), logistic
regression, and the persistence / trend baselines."""
from __future__ import annotations

from dataclasses import dataclass

import numpy as np
from scipy.optimize import minimize

import fixedpoint


# --------------------------------------------------------------------------- MLP
@dataclass
class MLP:
    """N_IN -> H_HID (tanh) -> 1 (tanh). Output in (-1, 1); score > threshold => flood."""
    W1: np.ndarray   # (H_HID, N_IN)
    b1: np.ndarray   # (H_HID,)
    W2: np.ndarray   # (H_HID,)
    b2: float

    def __call__(self, Z: np.ndarray) -> np.ndarray:
        h = np.tanh(Z @ self.W1.T + self.b1)
        return np.tanh(h @ self.W2 + self.b2)

    def quantized(self) -> fixedpoint.QuantizedMLP:
        return fixedpoint.QuantizedMLP(self.W1, self.b1, self.W2, self.b2)


def clip_inputs(Z: np.ndarray) -> np.ndarray:
    """Same input range the IP accepts."""
    return np.clip(Z, fixedpoint.INPUT_MIN, fixedpoint.INPUT_MAX)


def class_weights(y: np.ndarray) -> np.ndarray:
    pos = max(y.sum(), 1.0)
    neg = max(len(y) - y.sum(), 1.0)
    w = np.where(y == 1, len(y) / (2 * pos), len(y) / (2 * neg))
    return w / w.mean()


def fit_mlp(Z: np.ndarray, y: np.ndarray, hidden: int, l2: float, seed: int, maxiter: int = 2000) -> MLP:
    """Class-weighted MSE on targets in {-1, +1} plus L2, minimized with L-BFGS."""
    rng = np.random.default_rng(seed)
    n_in = Z.shape[1]
    t = 2.0 * y - 1.0
    w = class_weights(y)
    shapes = [(hidden, n_in), (hidden,), (hidden,), (1,)]
    sizes = [int(np.prod(s)) for s in shapes]

    def unpack(p):
        out, a = [], 0
        for s, n in zip(shapes, sizes):
            out.append(p[a:a + n].reshape(s))
            a += n
        return out

    def loss_grad(p):
        W1, b1, W2, b2 = unpack(p)
        a1 = Z @ W1.T + b1
        h = np.tanh(a1)
        o = np.tanh(h @ W2 + b2[0])
        err = o - t
        n = len(t)
        loss = np.sum(w * err ** 2) / n + l2 * np.sum(p ** 2)
        d_o = 2 * w * err / n * (1 - o ** 2)              # dL/d(pre-output)
        gW2 = h.T @ d_o
        gb2 = np.array([d_o.sum()])
        d_h = np.outer(d_o, W2) * (1 - h ** 2)
        gW1 = d_h.T @ Z
        gb1 = d_h.sum(axis=0)
        g = np.concatenate([gW1.ravel(), gb1, gW2, gb2]) + 2 * l2 * p
        return loss, g

    p0 = np.concatenate([rng.normal(0, 1 / np.sqrt(n_in), sizes[0]), np.zeros(hidden),
                         rng.normal(0, 1 / np.sqrt(hidden), hidden), np.zeros(1)])
    res = minimize(loss_grad, p0, jac=True, method="L-BFGS-B", options={"maxiter": maxiter})
    W1, b1, W2, b2 = unpack(res.x)
    return MLP(W1, b1, W2, float(b2[0]))


# --------------------------------------------------------------------------- logistic regression
@dataclass
class Logistic:
    w: np.ndarray
    b: float

    def __call__(self, Z: np.ndarray) -> np.ndarray:
        return np.tanh(0.5 * (Z @ self.w + self.b))   # same (-1, 1) score scale as the MLP


def fit_logistic(Z: np.ndarray, y: np.ndarray, l2: float = 1e-3) -> Logistic:
    w8 = class_weights(y)

    def loss_grad(p):
        a = Z @ p[:-1] + p[-1]
        pr = 1 / (1 + np.exp(-a))
        eps = 1e-12
        loss = -np.mean(w8 * (y * np.log(pr + eps) + (1 - y) * np.log(1 - pr + eps))) + l2 * np.sum(p[:-1] ** 2)
        d = w8 * (pr - y) / len(y)
        g = np.concatenate([Z.T @ d + 2 * l2 * p[:-1], [d.sum()]])
        return loss, g

    res = minimize(loss_grad, np.zeros(Z.shape[1] + 1), jac=True, method="L-BFGS-B")
    return Logistic(res.x[:-1], float(res.x[-1]))


# --------------------------------------------------------------------------- metrics
def prf(pred: np.ndarray, y: np.ndarray) -> dict:
    pred, y = pred.astype(bool), y.astype(bool)
    tp = int(np.sum(pred & y)); fp = int(np.sum(pred & ~y)); fn = int(np.sum(~pred & y))
    p = tp / (tp + fp) if tp + fp else 0.0
    r = tp / (tp + fn) if tp + fn else 0.0
    f1 = 2 * p * r / (p + r) if p + r else 0.0
    return {"precision": p, "recall": r, "f1": f1, "tp": tp, "fp": fp, "fn": fn}


def flood_onsets(stage: np.ndarray, flood_stage: float, min_gap: int = 3) -> np.ndarray:
    """Indices where the river goes above flood stage after >= min_gap days at or below it."""
    above = stage > flood_stage
    onsets, below_run = [], min_gap
    for i, a in enumerate(above):
        if a:
            if below_run >= min_gap:
                onsets.append(i)
            below_run = 0
        else:
            below_run += 1
    return np.array(onsets, dtype=int)


def event_metrics(alarm: np.ndarray, stage: np.ndarray, flood_stage: float, horizon: int) -> dict:
    """Event-level warning skill on one contiguous period.

    An onset is *warned* if an alarm is raised on a non-flood day within the
    `horizon` days before it. Lead time = days between the first such alarm and
    the onset. A false alarm is a run of alarms on non-flood days not followed
    by an onset within `horizon` days of the run start.
    """
    above = stage > flood_stage
    onsets = flood_onsets(stage, flood_stage)
    leads = []
    for o in onsets:
        window = [d for d in range(max(0, o - horizon), o) if alarm[d] and not above[d]]
        leads.append(o - window[0] if window else 0)
    leads = np.array(leads)
    false_alarms = 0
    d = 0
    n = len(alarm)
    while d < n:
        if alarm[d] and not above[d]:
            start = d
            while d < n and alarm[d] and not above[d]:
                d += 1
            if not np.any(above[start:min(n, start + horizon + 1)]):
                false_alarms += 1
        else:
            d += 1
    years = n / 365.25
    return {
        "events": int(len(onsets)),
        "warned": int(np.sum(leads > 0)),
        "warned_frac": float(np.mean(leads > 0)) if len(onsets) else float("nan"),
        "median_lead_days": float(np.median(leads[leads > 0])) if np.any(leads > 0) else 0.0,
        "false_alarms": false_alarms,
        "false_alarms_per_year": false_alarms / years if years else float("nan"),
    }


def best_threshold(score: np.ndarray, y: np.ndarray, mask: np.ndarray) -> float:
    """Threshold maximizing F1 on the `mask` subset (non-flooded days)."""
    best_t, best_f = 0.0, -1.0
    for t in np.linspace(-0.95, 0.95, 77):
        f = prf(score[mask] > t, y[mask])["f1"]
        if f > best_f:
            best_t, best_f = float(t), f
    return best_t
