// CPU reference of the topann IP, bit-exact with Vivado/HLS/topann.cpp and
// python/fixedpoint.py. Plain C++11, no Xilinx headers, so it runs on the ARM
// and on the development host.
#ifndef ANN_REF_H
#define ANN_REF_H

#include <stdint.h>

#include "model_params.h"

namespace annref {

const int FRAC_BITS = 24;

// float -> Q8.24 raw, round half to even, saturating (same as python to_raw).
int32_t to_raw(double x);
double from_raw(int32_t raw);

// tanh look-up exactly as the IP does it.
int32_t tanh_lut(int32_t z_raw);

// Q16.48 accumulator -> Q8.24, round half to even, saturate.
int32_t round_conv_sat(int64_t acc);

// Pre-activation (before tanh) of hidden neuron j with the exported weights.
int32_t hidden_preact(const int32_t x_raw[N_IN], int j);

// Full forward pass with explicit parameters (raw Q8.24).
int32_t infer(const int32_t x_raw[N_IN], const int32_t* w1_raw, const int32_t* b1_raw,
              const int32_t* w2_raw, int32_t b2_raw);

// Forward pass with the exported model (model_params.h).
int32_t infer(const int32_t x_raw[N_IN]);

}  // namespace annref

#endif
