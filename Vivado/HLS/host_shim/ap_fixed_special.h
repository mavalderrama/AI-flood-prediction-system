// Host C-simulation shim (see Vivado/HLS/Makefile): replaces the Xilinx header of the
// same name, which only specializes std::complex<> and does not compile with libc++.
// topann does not use std::complex; Vivado HLS uses its own headers, not this one.
