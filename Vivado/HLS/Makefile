# Local C simulation of the topann IP (no Vivado needed).
#
#   make csim     compile topann.cpp + tb_topann.cpp with Xilinx's open-source
#                 ap_fixed headers and check them against the golden vectors
#
# Synthesis, co-simulation and IP export: vivado_hls -f run_hls.tcl

AP_TYPES := third_party/HLS_arbitrary_Precision_Types
CXX      ?= c++
# host_shim/ comes first: it stubs the std::complex<> specializations, which
# do not compile with libc++ (macOS) and are not used by topann.
CXXFLAGS := -std=c++14 -O2 -Wall -Wno-unknown-pragmas -Wno-unused-label -I. -Ihost_shim -I$(AP_TYPES)/include

.PHONY: csim clean

csim: build/tb_topann
	./build/tb_topann

build/tb_topann: tb_topann.cpp topann.cpp topann.h model_params.h tanh_lut.h golden_vectors.h | $(AP_TYPES)
	@mkdir -p build
	$(CXX) $(CXXFLAGS) tb_topann.cpp topann.cpp -o $@

$(AP_TYPES):
	git clone --depth 1 https://github.com/Xilinx/HLS_arbitrary_Precision_Types.git $@

clean:
	rm -rf build
