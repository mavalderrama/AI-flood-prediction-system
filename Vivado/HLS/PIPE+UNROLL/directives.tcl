############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_interface -mode m_axi -depth 3 -offset slave -bundle INPUTS "TOPANN" inputs
set_directive_interface -mode s_axilite "TOPANN"
set_directive_array_partition -type block -factor 2 -dim 3 "TOPANN" layerWeigth
set_directive_interface -mode s_axilite "TOPANN" bias
set_directive_interface -mode s_axilite "TOPANN" outputLayerWeigth
set_directive_interface -mode s_axilite "TOPANN" outputLayerBias
set_directive_interface -mode m_axi -depth 1 -offset slave -bundle OUTPUTS "TOPANN" result
set_directive_inline "resultNeuron"
set_directive_pipeline -II 1 "ANN/neuronLoop"
set_directive_unroll -factor 2 "ANN/layerLoop"
set_directive_interface -mode s_axilite "TOPANN" layerWeigth
