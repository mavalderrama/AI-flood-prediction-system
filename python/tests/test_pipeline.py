"""Tests for the data pipeline, labels, features, splits, fixed point and metrics.

Run from the repo root:  pytest python/tests
Uses the committed data/processed/mississippi_br_daily.csv and Matlab/*.mat.
"""
import numpy as np
import pandas as pd
import pytest

import config
import dataset
import export
import fixedpoint as fp
import models
import recover_legacy_alignment as legacy


@pytest.fixture(scope="module")
def df():
    return dataset.load_processed()


# --------------------------------------------------------------------------- legacy thesis data
def test_legacy_dataset_is_mississippi_daily_from_2011_02_16(df):
    stage_raw, _, _, _ = legacy.load_legacy()
    k, corr = legacy.best_offset(legacy.clean_legacy_stage(stage_raw), df["stage_br"].to_numpy())
    assert df.index[k] == pd.Timestamp("2011-02-16")
    assert corr > 0.999


def test_legacy_labels_are_stage_above_30ft_only_with_correct_alignment():
    stage, _, _, T = legacy.load_legacy()
    t = T[1:]                                    # drop the leading NaN (correct alignment)
    assert stage[t == 1].min() > 30.0 >= stage[(t == -1) & (stage > 0)].max()
    t_thesis = np.where(np.isnan(T[:-1]), -1, T[:-1])   # what Vivado/HLS/dataset.h used
    assert stage[t_thesis == 1].min() < stage[(t_thesis == -1) & (stage > 0)].max()


# --------------------------------------------------------------------------- labels / features / split
def test_labels_only_look_at_the_future():
    stage = pd.Series([10.0, 10, 10, 31, 10, 10, 10, 10], index=pd.date_range("2020-01-01", periods=8))
    y = dataset.make_labels(stage, horizon=2, flood_stage=30.0)
    # y(t)=1 iff a flood occurs on t+1 or t+2; the flooded day itself (t=3) looks ahead only.
    assert list(y.iloc[:6]) == [0, 1, 1, 0, 0, 0]
    assert y.iloc[-2:].isna().all()              # not enough future


def test_features_are_causal(df):
    sub = df.iloc[1000:1100].copy()
    base = dataset.make_features(sub)
    t = 50
    perturbed = sub.copy()
    perturbed.iloc[t + 1:] = perturbed.iloc[t + 1:] * 3 + 7
    after = dataset.make_features(perturbed)
    pd.testing.assert_frame_equal(base.iloc[:t + 1], after.iloc[:t + 1])


def test_split_is_chronological_and_disjoint(df):
    m = dataset.Split().masks(df.index)
    total = m["train"].astype(int) + m["val"].astype(int) + m["test"].astype(int)
    assert np.all(total == 1)
    assert df.index[m["train"]].max() < df.index[m["val"]].min()
    assert df.index[m["val"]].max() < df.index[m["test"]].min()


def test_loop_reference_features_match_pandas(df):
    sub = df.iloc[2000:2400]
    feats = dataset.make_features(sub).to_numpy()
    mean, std = np.nanmean(feats, axis=0), np.nanstd(feats, axis=0)
    x_raw, ok = export.features_reference(sub[dataset.INPUT_COLUMNS].to_numpy(), mean, std)
    expected = np.clip((feats - mean) / std, fp.INPUT_MIN, fp.INPUT_MAX)
    assert ok.sum() > 350
    assert np.max(np.abs(fp.from_raw(x_raw[ok]) - expected[ok])) < 1e-6


# --------------------------------------------------------------------------- fixed point
def test_tanh_lut_error_bound():
    z = np.linspace(-7.999, 7.999, 200001)
    approx = fp.from_raw(fp.tanh_raw(fp.to_raw(z)))
    assert np.max(np.abs(approx - np.tanh(z))) <= 0.004
    assert fp.from_raw(fp.tanh_raw(fp.to_raw(np.array([50.0, -50.0])))).tolist() == pytest.approx([1, -1], abs=1e-6)


@pytest.mark.parametrize("acc,expected", [
    (5 * fp.ONE + fp.ONE // 2, 6),        # 5.5 -> 6 (even)
    (4 * fp.ONE + fp.ONE // 2, 4),        # 4.5 -> 4 (even)
    (-(4 * fp.ONE + fp.ONE // 2), -4),    # -4.5 -> -4
    (-(5 * fp.ONE + fp.ONE // 2), -6),    # -5.5 -> -6
    (5 * fp.ONE + fp.ONE // 2 + 1, 6),
    (5 * fp.ONE + fp.ONE // 2 - 1, 5),
])
def test_round_half_even(acc, expected):
    assert int(fp.round_half_even_shift(np.array([acc]), fp.FRAC_BITS)[0]) == expected


def test_quantized_model_close_to_float():
    rng = np.random.default_rng(0)
    W1, b1, W2, b2 = rng.normal(0, 1, (6, 8)), rng.normal(0, 1, 6), rng.normal(0, 1, 6), 0.1
    mlp = models.MLP(W1, b1, W2, b2)
    Z = rng.normal(0, 2, (5000, 8))
    diff = np.abs(mlp.quantized()(Z) - mlp(models.clip_inputs(Z)))
    assert diff.max() < 0.02


def test_weight_limit_is_enforced():
    with pytest.raises(ValueError):
        fp.QuantizedMLP(np.full((2, 2), 40.0), np.zeros(2), np.zeros(2), 0.0)


# --------------------------------------------------------------------------- metrics
def test_event_metrics():
    stage = np.array([10, 20, 25, 31, 32, 20, 10, 10, 10, 10, 10, 10], dtype=float)
    alarm = np.zeros_like(stage, dtype=bool)
    alarm[1] = True                      # 2 days before the onset at index 3
    alarm[8] = True                      # no flood follows: false alarm
    ev = models.event_metrics(alarm, stage, flood_stage=30.0, horizon=3)
    assert ev["events"] == 1 and ev["warned"] == 1 and ev["median_lead_days"] == 2
    assert ev["false_alarms"] == 1


def test_persistence_has_no_onset_skill(df):
    """On non-flooded days persistence never alarms: the thesis-style detector cannot forecast."""
    stage = df["stage_br"].to_numpy()
    y = dataset.make_labels(df["stage_br"], 5).to_numpy()
    nonflood = (stage <= config.FLOOD_STAGE_FT) & ~np.isnan(y)
    pred = stage > config.FLOOD_STAGE_FT
    assert models.prf(pred[nonflood], y[nonflood])["recall"] == 0.0
