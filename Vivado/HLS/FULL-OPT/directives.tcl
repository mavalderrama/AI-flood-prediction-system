############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_interface -mode s_axilite "TOPANN" inputs
set_directive_interface -mode s_axilite "TOPANN" layerWeigth
set_directive_interface -mode s_axilite "TOPANN" bias
set_directive_interface -mode s_axilite "TOPANN" outputLayerWeigth
set_directive_interface -mode s_axilite "TOPANN" outputLayerBias
set_directive_interface -mode s_axilite -register "TOPANN" result
set_directive_inline "resultNeuron"
set_directive_pipeline -II 1 "ANN/neuronLoop"
set_directive_dataflow "TOPANN"
