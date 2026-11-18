#include "ann_ref.h"

#include <cmath>

#include "tanh_lut.h"

namespace annref {

int32_t to_raw(double x) {
    double scaled = std::rint(x * 16777216.0);   // FE_TONEAREST: ties to even
    if (scaled >= 2147483647.0) return INT32_MAX;
    if (scaled <= -2147483648.0) return INT32_MIN;
    return static_cast<int32_t>(scaled);
}

double from_raw(int32_t raw) { return static_cast<double>(raw) / 16777216.0; }

int32_t round_conv_sat(int64_t acc) {
    // Arithmetic right shift (floor) for negative values: guaranteed by GCC/Clang.
    int64_t q = acc >> FRAC_BITS;
    int64_t r = acc & ((INT64_C(1) << FRAC_BITS) - 1);
    const int64_t half = INT64_C(1) << (FRAC_BITS - 1);
    if (r > half || (r == half && (q & 1))) q += 1;
    if (q > INT32_MAX) return INT32_MAX;
    if (q < INT32_MIN) return INT32_MIN;
    return static_cast<int32_t>(q);
}

int32_t tanh_lut(int32_t z_raw) {
    int64_t idx = (static_cast<int64_t>(z_raw) + (INT64_C(8) << FRAC_BITS)) >> 16;
    if (idx < 0) idx = 0;
    if (idx > 4095) idx = 4095;
    return TANH_LUT_RAW[idx];
}

static int32_t preact(const int32_t x_raw[N_IN], const int32_t* w1_raw, const int32_t* b1_raw, int j) {
    int64_t acc = static_cast<int64_t>(b1_raw[j]) * (INT64_C(1) << FRAC_BITS);
    for (int i = 0; i < N_IN; i++)
        acc += static_cast<int64_t>(w1_raw[j * N_IN + i]) * x_raw[i];
    return round_conv_sat(acc);
}

int32_t hidden_preact(const int32_t x_raw[N_IN], int j) { return preact(x_raw, W1_RAW, B1_RAW, j); }

int32_t infer(const int32_t x_raw[N_IN], const int32_t* w1_raw, const int32_t* b1_raw,
              const int32_t* w2_raw, int32_t b2_raw) {
    int32_t hidden[H_HID];
    for (int j = 0; j < H_HID; j++) hidden[j] = tanh_lut(preact(x_raw, w1_raw, b1_raw, j));
    int64_t acc = static_cast<int64_t>(b2_raw) * (INT64_C(1) << FRAC_BITS);
    for (int j = 0; j < H_HID; j++)
        acc += static_cast<int64_t>(w2_raw[j]) * hidden[j];
    return tanh_lut(round_conv_sat(acc));
}

int32_t infer(const int32_t x_raw[N_IN]) {
    return infer(x_raw, W1_RAW, B1_RAW, W2_RAW, B2_RAW);
}

}  // namespace annref
