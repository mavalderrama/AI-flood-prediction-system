#include "features.h"

#include <cmath>

#include "ann_ref.h"

void FeatureExtractor::push(const DailyReading& r) {
    history_.push_back(r);
    while (history_.size() > static_cast<size_t>(HISTORY_ROWS)) history_.pop_front();
}

bool FeatureExtractor::compute(double out[N_IN]) const {
    if (!ready()) return false;
    const size_t t = history_.size() - 1;
    for (int i = 0; i < N_IN; i++) {
        const int c = FEAT_COL[i];
        const int p = FEAT_PARAM[i];
        double v = NAN;
        switch (FEAT_KIND[i]) {
            case FEAT_LEVEL:
                v = history_[t].v[c];
                break;
            case FEAT_DELTA:
                v = history_[t].v[c] - history_[t - p].v[c];
                break;
            case FEAT_SUM:
                // Oldest to newest, same order as the Python reference.
                v = 0.0;
                for (size_t k = t + 1 - p; k <= t; k++) v += history_[k].v[c];
                break;
        }
        if (std::isnan(v)) return false;
        out[i] = v;
    }
    return true;
}

void normalize_and_quantize(const double features[N_IN], int32_t x_raw[N_IN]) {
    const double max_in = 8.0 - 1.0 / 16777216.0;
    for (int i = 0; i < N_IN; i++) {
        double z = (features[i] - FEAT_MEAN[i]) / FEAT_STD[i];
        if (z > max_in) z = max_in;
        if (z < -8.0) z = -8.0;
        x_raw[i] = annref::to_raw(z);
    }
}
