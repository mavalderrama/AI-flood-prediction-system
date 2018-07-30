set moduleName Block_proc19
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set C_modelName {Block__proc19}
set C_modelType { void 0 }
set C_modelArgList {
	{ inputs_V int 32 regular {array 3 { 1 } 1 1 }  }
	{ layerWeigth_V int 32 regular {array 9 { 1 } 1 1 }  }
	{ bias_V int 32 regular {array 3 { 1 } 1 1 }  }
	{ outputLayerWeigth_V int 32 regular {array 3 { 1 } 1 1 }  }
	{ outputLayerBias_V int 32 regular {array 1 { 1 } 1 1 }  }
	{ result_V int 32 regular {array 2 { 0 } 0 1 }  }
}
set C_modelArgMapList {[ 
	{ "Name" : "inputs_V", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "layerWeigth_V", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "bias_V", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "outputLayerWeigth_V", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "outputLayerBias_V", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "result_V", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 26
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ inputs_V_address0 sc_out sc_lv 2 signal 0 } 
	{ inputs_V_ce0 sc_out sc_logic 1 signal 0 } 
	{ inputs_V_q0 sc_in sc_lv 32 signal 0 } 
	{ layerWeigth_V_address0 sc_out sc_lv 4 signal 1 } 
	{ layerWeigth_V_ce0 sc_out sc_logic 1 signal 1 } 
	{ layerWeigth_V_q0 sc_in sc_lv 32 signal 1 } 
	{ bias_V_address0 sc_out sc_lv 2 signal 2 } 
	{ bias_V_ce0 sc_out sc_logic 1 signal 2 } 
	{ bias_V_q0 sc_in sc_lv 32 signal 2 } 
	{ outputLayerWeigth_V_address0 sc_out sc_lv 2 signal 3 } 
	{ outputLayerWeigth_V_ce0 sc_out sc_logic 1 signal 3 } 
	{ outputLayerWeigth_V_q0 sc_in sc_lv 32 signal 3 } 
	{ outputLayerBias_V_address0 sc_out sc_lv 1 signal 4 } 
	{ outputLayerBias_V_ce0 sc_out sc_logic 1 signal 4 } 
	{ outputLayerBias_V_q0 sc_in sc_lv 32 signal 4 } 
	{ result_V_address0 sc_out sc_lv 1 signal 5 } 
	{ result_V_ce0 sc_out sc_logic 1 signal 5 } 
	{ result_V_we0 sc_out sc_logic 1 signal 5 } 
	{ result_V_d0 sc_out sc_lv 32 signal 5 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "inputs_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "inputs_V", "role": "address0" }} , 
 	{ "name": "inputs_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "ce0" }} , 
 	{ "name": "inputs_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputs_V", "role": "q0" }} , 
 	{ "name": "layerWeigth_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "layerWeigth_V", "role": "address0" }} , 
 	{ "name": "layerWeigth_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerWeigth_V", "role": "ce0" }} , 
 	{ "name": "layerWeigth_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerWeigth_V", "role": "q0" }} , 
 	{ "name": "bias_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "bias_V", "role": "address0" }} , 
 	{ "name": "bias_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bias_V", "role": "ce0" }} , 
 	{ "name": "bias_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bias_V", "role": "q0" }} , 
 	{ "name": "outputLayerWeigth_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "outputLayerWeigth_V", "role": "address0" }} , 
 	{ "name": "outputLayerWeigth_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outputLayerWeigth_V", "role": "ce0" }} , 
 	{ "name": "outputLayerWeigth_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "outputLayerWeigth_V", "role": "q0" }} , 
 	{ "name": "outputLayerBias_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "outputLayerBias_V", "role": "address0" }} , 
 	{ "name": "outputLayerBias_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outputLayerBias_V", "role": "ce0" }} , 
 	{ "name": "outputLayerBias_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "outputLayerBias_V", "role": "q0" }} , 
 	{ "name": "result_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "result_V", "role": "address0" }} , 
 	{ "name": "result_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "result_V", "role": "ce0" }} , 
 	{ "name": "result_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "result_V", "role": "we0" }} , 
 	{ "name": "result_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "result_V", "role": "d0" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2"],
		"CDFG" : "Block_proc19",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1",
		"FunctionPipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"VariableLatency" : "1",
		"WaitState" : [
			{"State" : "ap_ST_fsm_state2", "FSM" : "ap_CS_fsm", "SubInstance" : "grp_ANN_fu_45"}],
		"Port" : [
			{"Name" : "inputs_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_ANN_fu_45", "Port" : "inputs_V"}]},
			{"Name" : "layerWeigth_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_ANN_fu_45", "Port" : "layerWeigth_V"}]},
			{"Name" : "bias_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_ANN_fu_45", "Port" : "bias_V"}]},
			{"Name" : "outputLayerWeigth_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_ANN_fu_45", "Port" : "outputLayerWeigth_V"}]},
			{"Name" : "outputLayerBias_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_ANN_fu_45", "Port" : "outputLayerBias_V"}]},
			{"Name" : "result_V", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "coeTanSig_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_ANN_fu_45", "Port" : "coeTanSig_V"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.layerResult_01_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_ANN_fu_45", "Parent" : "0", "Child" : ["3", "4", "5", "6", "7", "8", "9", "10"],
		"CDFG" : "ANN",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1",
		"FunctionPipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"VariableLatency" : "1",
		"Port" : [
			{"Name" : "inputs_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "layerWeigth_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "bias_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "outputLayerWeigth_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "outputLayerBias_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "layerResult_0_V", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "coeTanSig_V", "Type" : "Memory", "Direction" : "I"}]},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_ANN_fu_45.coeTanSig_V_U", "Parent" : "2"},
	{"ID" : "4", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_ANN_fu_45.TOPANN_dcmp_64ns_bkb_U1", "Parent" : "2"},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_ANN_fu_45.TOPANN_dcmp_64ns_bkb_U2", "Parent" : "2"},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_ANN_fu_45.TOPANN_sitodp_32ncud_U3", "Parent" : "2"},
	{"ID" : "7", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_ANN_fu_45.TOPANN_mul_32s_32dEe_U4", "Parent" : "2"},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_ANN_fu_45.TOPANN_mul_10ns_3eOg_U5", "Parent" : "2"},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_ANN_fu_45.TOPANN_mul_32s_26fYi_U6", "Parent" : "2"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_ANN_fu_45.TOPANN_mul_10ns_3eOg_U7", "Parent" : "2"}]}


set ArgLastReadFirstWriteLatency {
	Block_proc19 {
		inputs_V {Type I LastRead 2 FirstWrite -1}
		layerWeigth_V {Type I LastRead 2 FirstWrite -1}
		bias_V {Type I LastRead 7 FirstWrite -1}
		outputLayerWeigth_V {Type I LastRead 4 FirstWrite -1}
		outputLayerBias_V {Type I LastRead 2 FirstWrite -1}
		result_V {Type O LastRead -1 FirstWrite 2}
		coeTanSig_V {Type I LastRead -1 FirstWrite -1}}
	ANN {
		inputs_V {Type I LastRead 2 FirstWrite -1}
		layerWeigth_V {Type I LastRead 2 FirstWrite -1}
		bias_V {Type I LastRead 7 FirstWrite -1}
		outputLayerWeigth_V {Type I LastRead 4 FirstWrite -1}
		outputLayerBias_V {Type I LastRead 2 FirstWrite -1}
		layerResult_0_V {Type IO LastRead 4 FirstWrite 21}
		coeTanSig_V {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "67", "Max" : "67"}
	, {"Name" : "Interval", "Min" : "67", "Max" : "67"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	inputs_V { ap_memory {  { inputs_V_address0 mem_address 1 2 }  { inputs_V_ce0 mem_ce 1 1 }  { inputs_V_q0 mem_dout 0 32 } } }
	layerWeigth_V { ap_memory {  { layerWeigth_V_address0 mem_address 1 4 }  { layerWeigth_V_ce0 mem_ce 1 1 }  { layerWeigth_V_q0 mem_dout 0 32 } } }
	bias_V { ap_memory {  { bias_V_address0 mem_address 1 2 }  { bias_V_ce0 mem_ce 1 1 }  { bias_V_q0 mem_dout 0 32 } } }
	outputLayerWeigth_V { ap_memory {  { outputLayerWeigth_V_address0 mem_address 1 2 }  { outputLayerWeigth_V_ce0 mem_ce 1 1 }  { outputLayerWeigth_V_q0 mem_dout 0 32 } } }
	outputLayerBias_V { ap_memory {  { outputLayerBias_V_address0 mem_address 1 1 }  { outputLayerBias_V_ce0 mem_ce 1 1 }  { outputLayerBias_V_q0 mem_dout 0 32 } } }
	result_V { ap_memory {  { result_V_address0 mem_address 1 1 }  { result_V_ce0 mem_ce 1 1 }  { result_V_we0 mem_we 1 1 }  { result_V_d0 mem_din 1 32 } } }
}
