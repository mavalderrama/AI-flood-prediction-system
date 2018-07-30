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
open_solution "FULL-OPT"
set_part {xc7z010clg400-1}
create_clock -period 150MHz -name default
source "./ANN/FULL-OPT/directives.tcl"
csim_design
csynth_design
cosim_design -trace_level all
export_design -flow impl -rtl verilog -format ip_catalog -description "150MHz" -vendor "com.iot.accel" -version "1.2" -display_name "ANN"
