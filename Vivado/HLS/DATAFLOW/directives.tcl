############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_dataflow "TOPANN"
set_directive_interface -mode m_axi -depth 3 -offset slave -bundle 3 "TOPANN" inputs
set_directive_interface -mode s_axilite "TOPANN"
set_directive_interface -mode s_axilite "TOPANN" layerWeigth
set_directive_interface -mode s_axilite "TOPANN" bias
set_directive_interface -mode s_axilite "TOPANN" outputLayerWeigth
set_directive_interface -mode s_axilite "TOPANN" outputLayerBias
set_directive_interface -mode m_axi -depth 1 -offset slave -bundle OUTPUTS "TOPANN" result
