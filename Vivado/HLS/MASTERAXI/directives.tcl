############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_interface -mode m_axi -depth 3 -offset slave -bundle Inputs "TOPANN" inputs
set_directive_interface -mode s_axilite "TOPANN" layerWeigth
set_directive_interface -mode s_axilite "TOPANN" bias
set_directive_interface -mode s_axilite "TOPANN" outputLayerWeigth
set_directive_interface -mode s_axilite "TOPANN" outputLayerBias
set_directive_interface -mode m_axi -depth 1 -offset slave -bundle Output "TOPANN" result
set_directive_inline "resultNeuron"
set_directive_interface -mode s_axilite "TOPANN"
set_directive_pipeline -II 1 "resultNeuron/resultNeuronLoop"
set_directive_latency -min 1 -max 10 "resultNeuron/resultNeuronLoop"
set_directive_pipeline -II 1 "resultNeuron/resultNeuronLoop"
set_directive_latency -min 2 -max 10 "TOPANN/resultNeuronLoop1"
set_directive_latency -min 2 -max 10 "TOPANN/resultNeuronLoop2"
set_directive_array_partition -type complete -dim 3 "TOPANN" layerWeigth
set_directive_array_partition -type complete -dim 1 "TOPANN" Ainputs
set_directive_array_partition -type complete -dim 2 "TOPANN" outputLayerWeigth
set_directive_array_partition -type complete -dim 2 "TOPANN" layerWeigth
set_directive_array_partition -type complete -dim 2 "TOPANN" bias
set_directive_unroll -factor 3 "TOPANN/resultNeuronLoop2"
set_directive_unroll -factor 3 "TOPANN/resultNeuronLoop1"
set_directive_pipeline "TOPANN/neuronLoop"
set_directive_dataflow "TOPANN"
