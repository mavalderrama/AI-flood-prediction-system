// C-simulation / co-simulation testbench for topann.
// Feeds the golden vectors exported by python/export.py and requires a
// bit-exact match (0 LSB) with the Python fixed-point reference.
#include <cstdio>

#include "topann.h"
#include "golden_vectors.h"   // GOLDEN_N, GOLDEN_X_RAW[GOLDEN_N][N_IN], GOLDEN_Y_RAW[GOLDEN_N]

static fix_t from_raw(int32_t raw) {
    fix_t v;
    v.range(31, 0) = ap_int<32>(raw).range(31, 0);
    return v;
}

static int32_t to_raw(fix_t v) {
    ap_int<32> r;
    r.range(31, 0) = v.range(31, 0);
    return r.to_int();
}

int main() {
    fix_t w1[H_HID * N_IN], b1[H_HID], w2[H_HID];
    for (int k = 0; k < H_HID * N_IN; k++) w1[k] = from_raw(W1_RAW[k]);
    for (int j = 0; j < H_HID; j++) {
        b1[j] = from_raw(B1_RAW[j]);
        w2[j] = from_raw(W2_RAW[j]);
    }
    fix_t b2 = from_raw(B2_RAW);

    int mismatches = 0, z_mismatches = 0;
    for (int n = 0; n < GOLDEN_N; n++) {
        fix_t x[N_IN];
        for (int i = 0; i < N_IN; i++) x[i] = from_raw(GOLDEN_X_RAW[n][i]);
        for (int j = 0; j < H_HID; j++) {
            if (to_raw(hidden_preact(x, w1, b1, j)) != GOLDEN_Z_RAW[n][j]) {
                if (z_mismatches < 10)
                    std::printf("pre-activation mismatch at %d neuron %d: got %d expected %d\n", n, j,
                                to_raw(hidden_preact(x, w1, b1, j)), (int)GOLDEN_Z_RAW[n][j]);
                z_mismatches++;
            }
        }
        fix_t y;
        topann(x, w1, b1, w2, b2, &y);
        if (to_raw(y) != GOLDEN_Y_RAW[n]) {
            if (mismatches < 10)
                std::printf("mismatch at %d: got %d expected %d\n", n, to_raw(y), (int)GOLDEN_Y_RAW[n]);
            mismatches++;
        }
    }
    std::printf("topann testbench: %d vectors, %d output mismatches, %d pre-activation mismatches\n",
                GOLDEN_N, mismatches, z_mismatches);
    return (mismatches == 0 && z_mismatches == 0) ? 0 : 1;
}
