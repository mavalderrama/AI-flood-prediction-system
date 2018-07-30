############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
open_project ANNTrain
add_files ANNTrain/ANN.cpp
add_files ANNTrain/coe3.h
add_files ANNTrain/dataset.h
add_files ANNTrain/hardware.h
add_files -tb ANNTrain/main.cpp
open_solution "solution1"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
#source "./ANNTrain/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
