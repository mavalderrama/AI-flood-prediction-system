"""Bit-exact model of the HLS inference IP (Vivado/HLS/topann.cpp).

Number format: Q8.24 == ap_fixed<32,8,AP_RND_CONV,AP_SAT>
  raw int32, value = raw / 2**24, range [-128, 128).

Neuron arithmetic (identical in topann.cpp and Zynq7K/Software/ann_ref.cpp):
  acc  = sum_i w_raw[i] * x_raw[i]  +  (b_raw << 24)        exact, scale 2**48
  z    = round_half_even(acc / 2**24), saturated to int32     -> Q8.24
  y    = TANH_LUT[clamp((z + (8 << 24)) >> 16, 0, 4095)]

TANH_LUT has 4096 entries covering [-8, 8) in steps of 1/256; entry i holds
tanh at the bin centre, -8 + (i + 0.5) / 256, rounded half-even to Q8.24.

Inputs are clamped to [INPUT_MIN, INPUT_MAX] and weights must satisfy
|w| < WEIGHT_LIMIT, which keeps every int64 accumulation exact.
"""
from __future__ import annotations

import numpy as np

FRAC_BITS = 24
ONE = 1 << FRAC_BITS
RAW_MIN, RAW_MAX = -(1 << 31), (1 << 31) - 1

LUT_SIZE = 4096
LUT_MIN = -8.0
LUT_SHIFT = 16                      # 2**24 / 256 per bin = 2**16
LUT_OFFSET_RAW = 8 << FRAC_BITS     # -LUT_MIN in raw units

INPUT_MAX = 8.0 - 1.0 / ONE
INPUT_MIN = -8.0
WEIGHT_LIMIT = 32.0


def round_half_even_shift(acc: np.ndarray, shift: int) -> np.ndarray:
    """Divide int64 `acc` by 2**shift, rounding half to even (AP_RND_CONV)."""
    acc = np.asarray(acc, dtype=np.int64)
    q = acc >> shift                                  # floor division
    r = acc & ((1 << shift) - 1)                      # 0 <= r < 2**shift
    half = np.int64(1 << (shift - 1))
    up = (r > half) | ((r == half) & ((q & 1) == 1))
    return q + up.astype(np.int64)


def saturate(raw: np.ndarray) -> np.ndarray:
    return np.clip(raw, RAW_MIN, RAW_MAX).astype(np.int64)


def to_raw(x: np.ndarray) -> np.ndarray:
    """float -> Q8.24 raw, round half even, saturate (same as C++ lrint at FE_TONEAREST)."""
    return saturate(np.rint(np.asarray(x, dtype=np.float64) * ONE).astype(np.int64))


def from_raw(raw: np.ndarray) -> np.ndarray:
    return np.asarray(raw, dtype=np.float64) / ONE


def make_tanh_lut() -> np.ndarray:
    centers = LUT_MIN + (np.arange(LUT_SIZE) + 0.5) / 256.0
    return to_raw(np.tanh(centers))


TANH_LUT = make_tanh_lut()


def tanh_raw(z_raw: np.ndarray) -> np.ndarray:
    idx = (np.asarray(z_raw, dtype=np.int64) + LUT_OFFSET_RAW) >> LUT_SHIFT
    return TANH_LUT[np.clip(idx, 0, LUT_SIZE - 1)]


def preactivation(x_raw: np.ndarray, w_raw: np.ndarray, b_raw: np.ndarray) -> np.ndarray:
    """x_raw: (n, in), w_raw: (out, in), b_raw: (out,) -> Q8.24 pre-activations (n, out)."""
    x = np.asarray(x_raw, dtype=np.int64)
    w = np.asarray(w_raw, dtype=np.int64)
    acc = np.zeros((x.shape[0], w.shape[0]), dtype=np.int64)
    for i in range(w.shape[1]):                       # same order as the HLS loop
        acc += x[:, i:i + 1] * w[:, i][None, :]
    acc += np.asarray(b_raw, dtype=np.int64)[None, :] << FRAC_BITS
    return saturate(round_half_even_shift(acc, FRAC_BITS))


def neuron_layer(x_raw: np.ndarray, w_raw: np.ndarray, b_raw: np.ndarray) -> np.ndarray:
    """x_raw: (n, in), w_raw: (out, in), b_raw: (out,) -> activations (n, out) raw."""
    return tanh_raw(preactivation(x_raw, w_raw, b_raw))


class QuantizedMLP:
    """N_IN -> H_HID (tanh) -> 1 (tanh), all in Q8.24."""

    def __init__(self, W1: np.ndarray, b1: np.ndarray, W2: np.ndarray, b2: float):
        for name, arr in {"W1": W1, "b1": b1, "W2": W2, "b2": np.atleast_1d(b2)}.items():
            if np.max(np.abs(arr)) >= WEIGHT_LIMIT:
                raise ValueError(f"{name} has |w| >= {WEIGHT_LIMIT}; retrain with stronger regularization")
        self.W1 = to_raw(W1)
        self.b1 = to_raw(b1)
        self.W2 = to_raw(np.asarray(W2).reshape(1, -1))
        self.b2 = to_raw(np.atleast_1d(b2))

    @staticmethod
    def quantize_inputs(x_norm: np.ndarray) -> np.ndarray:
        return to_raw(np.clip(x_norm, INPUT_MIN, INPUT_MAX))

    def hidden_preactivation_raw(self, x_raw: np.ndarray) -> np.ndarray:
        """Hidden-layer Q8.24 pre-activations (before tanh): exposes the rounding,
        which the tanh table hides at the output."""
        return preactivation(np.atleast_2d(x_raw), self.W1, self.b1)

    def forward_raw(self, x_raw: np.ndarray) -> np.ndarray:
        h = neuron_layer(np.atleast_2d(x_raw), self.W1, self.b1)
        return neuron_layer(h, self.W2, self.b2)[:, 0]

    def __call__(self, x_norm: np.ndarray) -> np.ndarray:
        return from_raw(self.forward_raw(self.quantize_inputs(x_norm)))
