set C_TypeInfoList {{ 
"TOPANN" : [[], { "return": [[], "void"]} , [{"ExternC" : 0}], [ {"inputs": [[], {"array": ["0", [3]]}] }, {"layerWeigth": [[], {"array": [ {"array": ["0", [3,3]]}, [1]]}] }, {"bias": [[], {"array": [ {"array": ["0", [3]]}, [1]]}] }, {"outputLayerWeigth": [[], {"array": [ {"array": ["0", [3]]}, [1]]}] }, {"outputLayerBias": [[], {"array": ["0", [1]]}] }, {"result": [[], {"array": ["0", [2]]}] }],[],""], 
"0": [ "fix", {"typedef": [[[],"1"],""]}], 
"1": [ "ap_fixed<32, 8, 4, 3, 0>", {"hls_type": {"ap_fixed": [[[[], {"scalar": { "int": 32}}],[[], {"scalar": { "int": 8}}],[[], {"scalar": { "2": 4}}],[[], {"scalar": { "3": 3}}],[[], {"scalar": { "int": 0}}]],""]}}], 
"3": [ "sc_o_mode", {"enum": [[],[],[{"SC_SAT":  {"scalar": "__integer__"}},{"SC_SAT_ZERO":  {"scalar": "__integer__"}},{"SC_SAT_SYM":  {"scalar": "__integer__"}},{"SC_WRAP":  {"scalar": "__integer__"}},{"SC_WRAP_SM":  {"scalar": "__integer__"}}],""]}], 
"2": [ "sc_q_mode", {"enum": [[],[],[{"SC_RND":  {"scalar": "__integer__"}},{"SC_RND_ZERO":  {"scalar": "__integer__"}},{"SC_RND_MIN_INF":  {"scalar": "__integer__"}},{"SC_RND_INF":  {"scalar": "__integer__"}},{"SC_RND_CONV":  {"scalar": "__integer__"}},{"SC_TRN":  {"scalar": "__integer__"}},{"SC_TRN_ZERO":  {"scalar": "__integer__"}}],""]}]
}}
set moduleName TOPANN
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type dataflow
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set C_modelName {TOPANN}
set C_modelType { void 0 }
set C_modelArgList {
	{ inputs_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_V int 32 regular {axi_slave 0}  }
	{ bias_V int 32 regular {axi_slave 0}  }
	{ outputLayerWeigth_V int 32 regular {axi_slave 0}  }
	{ outputLayerBias_V int 32 regular {axi_slave 0}  }
	{ result_V int 32 regular {axi_slave 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "inputs_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "inputs.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 2,"step" : 1}]}]}], "offset" : {"in":16}, "offset_end" : {"in":31}} , 
 	{ "Name" : "layerWeigth_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 2,"step" : 1},{"low" : 0,"up" : 2,"step" : 1}]}]}], "offset" : {"in":64}, "offset_end" : {"in":127}} , 
 	{ "Name" : "bias_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "bias.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 2,"step" : 1}]}]}], "offset" : {"in":128}, "offset_end" : {"in":143}} , 
 	{ "Name" : "outputLayerWeigth_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "outputLayerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 2,"step" : 1}]}]}], "offset" : {"in":144}, "offset_end" : {"in":159}} , 
 	{ "Name" : "outputLayerBias_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "outputLayerBias.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}], "offset" : {"in":160}, "offset_end" : {"in":167}} , 
 	{ "Name" : "result_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "result.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 1,"step" : 1}]}]}], "offset" : {"out":168}, "offset_end" : {"out":175}} ]}
# RTL Port declarations: 
set portNum 20
set portList { 
	{ s_axi_AXILiteS_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_AWADDR sc_in sc_lv 8 signal -1 } 
	{ s_axi_AXILiteS_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_AXILiteS_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_AXILiteS_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_ARADDR sc_in sc_lv 8 signal -1 } 
	{ s_axi_AXILiteS_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_AXILiteS_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_AXILiteS_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_BRESP sc_out sc_lv 2 signal -1 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_AXILiteS_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWADDR" },"address":[{"name":"TOPANN","role":"start","value":"0","valid_bit":"0"},{"name":"TOPANN","role":"continue","value":"0","valid_bit":"4"},{"name":"TOPANN","role":"auto_start","value":"0","valid_bit":"7"},{"name":"inputs_V","role":"data","value":"16"},{"name":"layerWeigth_V","role":"data","value":"64"},{"name":"bias_V","role":"data","value":"128"},{"name":"outputLayerWeigth_V","role":"data","value":"144"},{"name":"outputLayerBias_V","role":"data","value":"160"}] },
	{ "name": "s_axi_AXILiteS_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWVALID" } },
	{ "name": "s_axi_AXILiteS_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWREADY" } },
	{ "name": "s_axi_AXILiteS_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WVALID" } },
	{ "name": "s_axi_AXILiteS_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WREADY" } },
	{ "name": "s_axi_AXILiteS_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WDATA" } },
	{ "name": "s_axi_AXILiteS_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WSTRB" } },
	{ "name": "s_axi_AXILiteS_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "AXILiteS", "role": "ARADDR" },"address":[{"name":"TOPANN","role":"start","value":"0","valid_bit":"0"},{"name":"TOPANN","role":"done","value":"0","valid_bit":"1"},{"name":"TOPANN","role":"idle","value":"0","valid_bit":"2"},{"name":"TOPANN","role":"ready","value":"0","valid_bit":"3"},{"name":"TOPANN","role":"auto_start","value":"0","valid_bit":"7"},{"name":"result_V","role":"data","value":"168"}] },
	{ "name": "s_axi_AXILiteS_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "ARVALID" } },
	{ "name": "s_axi_AXILiteS_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "ARREADY" } },
	{ "name": "s_axi_AXILiteS_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RVALID" } },
	{ "name": "s_axi_AXILiteS_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RREADY" } },
	{ "name": "s_axi_AXILiteS_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RDATA" } },
	{ "name": "s_axi_AXILiteS_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RRESP" } },
	{ "name": "s_axi_AXILiteS_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "BVALID" } },
	{ "name": "s_axi_AXILiteS_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "BREADY" } },
	{ "name": "s_axi_AXILiteS_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "AXILiteS", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2"],
		"CDFG" : "TOPANN",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1",
		"FunctionPipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"VariableLatency" : "1",
		"InputProcess" : [
			{"ID" : "2", "Name" : "Block_proc19_U0"}],
		"OutputProcess" : [
			{"ID" : "2", "Name" : "Block_proc19_U0"}],
		"Port" : [
			{"Name" : "inputs_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "Block_proc19_U0", "Port" : "inputs_V"}]},
			{"Name" : "layerWeigth_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "Block_proc19_U0", "Port" : "layerWeigth_V"}]},
			{"Name" : "bias_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "Block_proc19_U0", "Port" : "bias_V"}]},
			{"Name" : "outputLayerWeigth_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "Block_proc19_U0", "Port" : "outputLayerWeigth_V"}]},
			{"Name" : "outputLayerBias_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "Block_proc19_U0", "Port" : "outputLayerBias_V"}]},
			{"Name" : "result_V", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "Block_proc19_U0", "Port" : "result_V"}]},
			{"Name" : "coeTanSig_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "Block_proc19_U0", "Port" : "coeTanSig_V"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.TOPANN_AXILiteS_s_axi_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0", "Parent" : "0", "Child" : ["3", "4"],
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
					{"ID" : "4", "SubInstance" : "grp_ANN_fu_45", "Port" : "inputs_V"}]},
			{"Name" : "layerWeigth_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "grp_ANN_fu_45", "Port" : "layerWeigth_V"}]},
			{"Name" : "bias_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "grp_ANN_fu_45", "Port" : "bias_V"}]},
			{"Name" : "outputLayerWeigth_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "grp_ANN_fu_45", "Port" : "outputLayerWeigth_V"}]},
			{"Name" : "outputLayerBias_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "grp_ANN_fu_45", "Port" : "outputLayerBias_V"}]},
			{"Name" : "result_V", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "coeTanSig_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "grp_ANN_fu_45", "Port" : "coeTanSig_V"}]}]},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0.layerResult_01_U", "Parent" : "2"},
	{"ID" : "4", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0.grp_ANN_fu_45", "Parent" : "2", "Child" : ["5", "6", "7", "8", "9", "10", "11", "12"],
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
	{"ID" : "5", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0.grp_ANN_fu_45.coeTanSig_V_U", "Parent" : "4"},
	{"ID" : "6", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0.grp_ANN_fu_45.TOPANN_dcmp_64ns_bkb_U1", "Parent" : "4"},
	{"ID" : "7", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0.grp_ANN_fu_45.TOPANN_dcmp_64ns_bkb_U2", "Parent" : "4"},
	{"ID" : "8", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0.grp_ANN_fu_45.TOPANN_sitodp_32ncud_U3", "Parent" : "4"},
	{"ID" : "9", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0.grp_ANN_fu_45.TOPANN_mul_32s_32dEe_U4", "Parent" : "4"},
	{"ID" : "10", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0.grp_ANN_fu_45.TOPANN_mul_10ns_3eOg_U5", "Parent" : "4"},
	{"ID" : "11", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0.grp_ANN_fu_45.TOPANN_mul_32s_26fYi_U6", "Parent" : "4"},
	{"ID" : "12", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.Block_proc19_U0.grp_ANN_fu_45.TOPANN_mul_10ns_3eOg_U7", "Parent" : "4"}]}


set ArgLastReadFirstWriteLatency {
	TOPANN {
		inputs_V {Type I LastRead 2 FirstWrite -1}
		layerWeigth_V {Type I LastRead 2 FirstWrite -1}
		bias_V {Type I LastRead 7 FirstWrite -1}
		outputLayerWeigth_V {Type I LastRead 4 FirstWrite -1}
		outputLayerBias_V {Type I LastRead 2 FirstWrite -1}
		result_V {Type O LastRead -1 FirstWrite 2}
		coeTanSig_V {Type I LastRead -1 FirstWrite -1}}
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
	, {"Name" : "Interval", "Min" : "68", "Max" : "68"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
}

set busDeadlockParameterList { 
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
