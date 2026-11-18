// Causal feature extraction, mirroring python/dataset.py (FEATURES) and the
// loop reference python/export.py:features_reference(). The feature list is
// not hard-coded: it is the FEAT_KIND / FEAT_COL / FEAT_PARAM table in
// model_params.h, generated from the Python definition.
#ifndef FEATURES_H
#define FEATURES_H

#include <stdint.h>

#include <deque>

#include "model_params.h"

// One daily row (columns in model_params.h order). Use NAN for missing values.
struct DailyReading {
    double v[N_COLS];
};

class FeatureExtractor {
public:
    void push(const DailyReading& r);
    bool ready() const { return history_.size() >= static_cast<size_t>(HISTORY_ROWS); }
    // Raw (un-normalized) features. Returns false if not ready or any value is NaN.
    bool compute(double out[N_IN]) const;

private:
    std::deque<DailyReading> history_;   // oldest first, at most HISTORY_ROWS rows
};

// (x - mean) / std, clamped to the IP input range, then Q8.24 (round half even).
void normalize_and_quantize(const double features[N_IN], int32_t x_raw[N_IN]);

#endif
