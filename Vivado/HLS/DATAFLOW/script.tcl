############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
open_project ANN
set_top TOPANN
add_files ANN/hardware.h
add_files ANN/coe3.h
add_files ANN/ANN.cpp
add_files -tb ANN/FULL-OPT/csim/build/TrainWeigths.h
add_files -tb ANN/main.cpp
open_solution "DATAFLOW"
set_part {xc7z010clg400-1}
create_clock -period 10 -name default
source "./ANN/DATAFLOW/directives.tcl"
csim_design
csynth_design
cosim_design -trace_level all
export_design -flow impl -rtl verilog -format ip_catalog -version "1.5" -display_name "DATAFLOW"
