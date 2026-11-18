#include "topann.h"

static fix_t tanh_lut(fix_t z) {
#pragma HLS INLINE
    ap_int<32> z_raw;
    z_raw.range(31, 0) = z.range(31, 0);
    ap_int<34> shifted = (ap_int<34>)z_raw + (ap_int<34>)(1 << 27);   // + 8.0
    ap_int<34> idx = shifted >> 16;                                    // 256 bins per unit
    if (idx < 0) idx = 0;
    if (idx > 4095) idx = 4095;
    fix_t y;
    y.range(31, 0) = ap_int<32>(TANH_LUT_RAW[idx.to_int()]).range(31, 0);
    return y;
}

fix_t hidden_preact(const fix_t inputs[N_IN], const fix_t w1[H_HID * N_IN], const fix_t b1[H_HID], int j) {
#pragma HLS INLINE
    acc_t acc = b1[j];
hidden_mac:
    for (int i = 0; i < N_IN; i++) {
        acc += w1[j * N_IN + i] * inputs[i];
    }
    return fix_t(acc);   // AP_RND_CONV + AP_SAT
}

void topann(const fix_t inputs[N_IN],
            const fix_t w1[H_HID * N_IN],
            const fix_t b1[H_HID],
            const fix_t w2[H_HID],
            fix_t b2,
            fix_t *result) {
#pragma HLS INTERFACE s_axilite port=inputs bundle=CTRL
#pragma HLS INTERFACE s_axilite port=w1 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=b1 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=w2 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=b2 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=result bundle=CTRL
#pragma HLS INTERFACE s_axilite port=return bundle=CTRL

    fix_t hidden[H_HID];

hidden_loop:
    for (int j = 0; j < H_HID; j++) {
        hidden[j] = tanh_lut(hidden_preact(inputs, w1, b1, j));
    }

    acc_t acc = b2;
output_mac:
    for (int j = 0; j < H_HID; j++) {
        acc += w2[j] * hidden[j];
    }
    *result = tanh_lut(fix_t(acc));
}
