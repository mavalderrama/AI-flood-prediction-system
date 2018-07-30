set C_TypeInfoList {{ 
"TOPANN" : [[], { "return": [[], "void"]} , [{"ExternC" : 0}], [ {"inputs": [[],{ "pointer": "0"}] }, {"layerWeigth": [[], {"array": [ {"array": ["1", [3,3]]}, [1]]}] }, {"bias": [[], {"array": [ {"array": ["1", [3]]}, [1]]}] }, {"outputLayerWeigth": [[], {"array": [ {"array": ["1", [3]]}, [1]]}] }, {"outputLayerBias": [[], {"array": ["1", [1]]}] }, {"result": [[],{ "pointer": "0"}] }],[],""], 
"0": [ "fix", {"typedef": [[[],"2"],""]}], 
"1": [ "fix", {"typedef": [[[],"2"],""]}], 
"2": [ "ap_fixed<32, 8, 4, 3, 0>", {"hls_type": {"ap_fixed": [[[[], {"scalar": { "int": 32}}],[[], {"scalar": { "int": 8}}],[[], {"scalar": { "3": 4}}],[[], {"scalar": { "4": 3}}],[[], {"scalar": { "int": 0}}]],""]}}], 
"4": [ "sc_o_mode", {"enum": [[],[],[{"SC_SAT":  {"scalar": "__integer__"}},{"SC_SAT_ZERO":  {"scalar": "__integer__"}},{"SC_SAT_SYM":  {"scalar": "__integer__"}},{"SC_WRAP":  {"scalar": "__integer__"}},{"SC_WRAP_SM":  {"scalar": "__integer__"}}],""]}], 
"3": [ "sc_q_mode", {"enum": [[],[],[{"SC_RND":  {"scalar": "__integer__"}},{"SC_RND_ZERO":  {"scalar": "__integer__"}},{"SC_RND_MIN_INF":  {"scalar": "__integer__"}},{"SC_RND_INF":  {"scalar": "__integer__"}},{"SC_RND_CONV":  {"scalar": "__integer__"}},{"SC_TRN":  {"scalar": "__integer__"}},{"SC_TRN_ZERO":  {"scalar": "__integer__"}}],""]}]
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
	{ p3 int 32 regular {axi_master 0}  }
	{ OUTPUTS int 32 regular {axi_master 1}  }
	{ inputs_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_V int 32 regular {axi_slave 0}  }
	{ bias_V int 32 regular {axi_slave 0}  }
	{ outputLayerWeigth_V int 32 regular {axi_slave 0}  }
	{ outputLayerBias_V int 32 regular {axi_slave 0}  }
	{ result_V int 32 regular {axi_slave 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "p3", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "inputs.V","cData": "int32","bit_use": { "low": 0,"up": 31},"offset": { "type": "dynamic","port_name": "inputs_V","bundle": "AXILiteS"},"direction": "READONLY","cArray": [{"low" : 0,"up" : 2,"step" : 1}]}]}]} , 
 	{ "Name" : "OUTPUTS", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "result.V","cData": "int32","bit_use": { "low": 0,"up": 31},"offset": { "type": "dynamic","port_name": "result_V","bundle": "AXILiteS"},"direction": "WRITEONLY","cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}]} , 
 	{ "Name" : "inputs_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":23}} , 
 	{ "Name" : "layerWeigth_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 2,"step" : 1},{"low" : 0,"up" : 2,"step" : 1}]}]}], "offset" : {"in":64}, "offset_end" : {"in":127}} , 
 	{ "Name" : "bias_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "bias.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 2,"step" : 1}]}]}], "offset" : {"in":128}, "offset_end" : {"in":143}} , 
 	{ "Name" : "outputLayerWeigth_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "outputLayerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 2,"step" : 1}]}]}], "offset" : {"in":144}, "offset_end" : {"in":159}} , 
 	{ "Name" : "outputLayerBias_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "outputLayerBias.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}], "offset" : {"in":160}, "offset_end" : {"in":167}} , 
 	{ "Name" : "result_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "offset" : {"in":168}, "offset_end" : {"in":175}} ]}
# RTL Port declarations: 
set portNum 110
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
	{ m_axi_p3_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_p3_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_p3_AWADDR sc_out sc_lv 32 signal 0 } 
	{ m_axi_p3_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_p3_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_p3_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_p3_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_p3_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_p3_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_p3_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_p3_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_p3_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_p3_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_p3_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_p3_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_p3_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_p3_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_p3_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_p3_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_p3_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_p3_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_p3_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_p3_ARADDR sc_out sc_lv 32 signal 0 } 
	{ m_axi_p3_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_p3_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_p3_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_p3_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_p3_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_p3_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_p3_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_p3_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_p3_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_p3_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_p3_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_p3_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_p3_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_p3_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_p3_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_p3_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_p3_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_p3_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_p3_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_p3_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_p3_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_p3_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_OUTPUTS_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_AWADDR sc_out sc_lv 32 signal 1 } 
	{ m_axi_OUTPUTS_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_OUTPUTS_AWLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_OUTPUTS_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_OUTPUTS_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_OUTPUTS_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_OUTPUTS_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_OUTPUTS_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_OUTPUTS_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_OUTPUTS_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_OUTPUTS_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_OUTPUTS_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_OUTPUTS_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_OUTPUTS_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_OUTPUTS_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_OUTPUTS_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_ARADDR sc_out sc_lv 32 signal 1 } 
	{ m_axi_OUTPUTS_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_OUTPUTS_ARLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_OUTPUTS_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_OUTPUTS_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_OUTPUTS_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_OUTPUTS_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_OUTPUTS_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_OUTPUTS_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_OUTPUTS_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_OUTPUTS_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_OUTPUTS_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_OUTPUTS_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_OUTPUTS_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_OUTPUTS_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_OUTPUTS_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_OUTPUTS_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_OUTPUTS_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_OUTPUTS_BUSER sc_in sc_lv 1 signal 1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_AXILiteS_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWADDR" },"address":[{"name":"TOPANN","role":"start","value":"0","valid_bit":"0"},{"name":"TOPANN","role":"continue","value":"0","valid_bit":"4"},{"name":"TOPANN","role":"auto_start","value":"0","valid_bit":"7"},{"name":"inputs_V","role":"data","value":"16"},{"name":"layerWeigth_V","role":"data","value":"64"},{"name":"bias_V","role":"data","value":"128"},{"name":"outputLayerWeigth_V","role":"data","value":"144"},{"name":"outputLayerBias_V","role":"data","value":"160"},{"name":"result_V","role":"data","value":"168"}] },
	{ "name": "s_axi_AXILiteS_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWVALID" } },
	{ "name": "s_axi_AXILiteS_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWREADY" } },
	{ "name": "s_axi_AXILiteS_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WVALID" } },
	{ "name": "s_axi_AXILiteS_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WREADY" } },
	{ "name": "s_axi_AXILiteS_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WDATA" } },
	{ "name": "s_axi_AXILiteS_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WSTRB" } },
	{ "name": "s_axi_AXILiteS_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "AXILiteS", "role": "ARADDR" },"address":[{"name":"TOPANN","role":"start","value":"0","valid_bit":"0"},{"name":"TOPANN","role":"done","value":"0","valid_bit":"1"},{"name":"TOPANN","role":"idle","value":"0","valid_bit":"2"},{"name":"TOPANN","role":"ready","value":"0","valid_bit":"3"},{"name":"TOPANN","role":"auto_start","value":"0","valid_bit":"7"}] },
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
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "m_axi_p3_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "AWVALID" }} , 
 	{ "name": "m_axi_p3_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "AWREADY" }} , 
 	{ "name": "m_axi_p3_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p3", "role": "AWADDR" }} , 
 	{ "name": "m_axi_p3_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "AWID" }} , 
 	{ "name": "m_axi_p3_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p3", "role": "AWLEN" }} , 
 	{ "name": "m_axi_p3_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "p3", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_p3_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p3", "role": "AWBURST" }} , 
 	{ "name": "m_axi_p3_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p3", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_p3_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p3", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_p3_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "p3", "role": "AWPROT" }} , 
 	{ "name": "m_axi_p3_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p3", "role": "AWQOS" }} , 
 	{ "name": "m_axi_p3_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p3", "role": "AWREGION" }} , 
 	{ "name": "m_axi_p3_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "AWUSER" }} , 
 	{ "name": "m_axi_p3_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "WVALID" }} , 
 	{ "name": "m_axi_p3_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "WREADY" }} , 
 	{ "name": "m_axi_p3_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p3", "role": "WDATA" }} , 
 	{ "name": "m_axi_p3_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p3", "role": "WSTRB" }} , 
 	{ "name": "m_axi_p3_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "WLAST" }} , 
 	{ "name": "m_axi_p3_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "WID" }} , 
 	{ "name": "m_axi_p3_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "WUSER" }} , 
 	{ "name": "m_axi_p3_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "ARVALID" }} , 
 	{ "name": "m_axi_p3_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "ARREADY" }} , 
 	{ "name": "m_axi_p3_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p3", "role": "ARADDR" }} , 
 	{ "name": "m_axi_p3_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "ARID" }} , 
 	{ "name": "m_axi_p3_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p3", "role": "ARLEN" }} , 
 	{ "name": "m_axi_p3_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "p3", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_p3_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p3", "role": "ARBURST" }} , 
 	{ "name": "m_axi_p3_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p3", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_p3_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p3", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_p3_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "p3", "role": "ARPROT" }} , 
 	{ "name": "m_axi_p3_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p3", "role": "ARQOS" }} , 
 	{ "name": "m_axi_p3_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p3", "role": "ARREGION" }} , 
 	{ "name": "m_axi_p3_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "ARUSER" }} , 
 	{ "name": "m_axi_p3_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "RVALID" }} , 
 	{ "name": "m_axi_p3_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "RREADY" }} , 
 	{ "name": "m_axi_p3_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p3", "role": "RDATA" }} , 
 	{ "name": "m_axi_p3_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "RLAST" }} , 
 	{ "name": "m_axi_p3_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "RID" }} , 
 	{ "name": "m_axi_p3_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "RUSER" }} , 
 	{ "name": "m_axi_p3_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p3", "role": "RRESP" }} , 
 	{ "name": "m_axi_p3_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "BVALID" }} , 
 	{ "name": "m_axi_p3_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "BREADY" }} , 
 	{ "name": "m_axi_p3_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p3", "role": "BRESP" }} , 
 	{ "name": "m_axi_p3_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "BID" }} , 
 	{ "name": "m_axi_p3_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p3", "role": "BUSER" }} , 
 	{ "name": "m_axi_OUTPUTS_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWVALID" }} , 
 	{ "name": "m_axi_OUTPUTS_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWREADY" }} , 
 	{ "name": "m_axi_OUTPUTS_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWADDR" }} , 
 	{ "name": "m_axi_OUTPUTS_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWID" }} , 
 	{ "name": "m_axi_OUTPUTS_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWLEN" }} , 
 	{ "name": "m_axi_OUTPUTS_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_OUTPUTS_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWBURST" }} , 
 	{ "name": "m_axi_OUTPUTS_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_OUTPUTS_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_OUTPUTS_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWPROT" }} , 
 	{ "name": "m_axi_OUTPUTS_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWQOS" }} , 
 	{ "name": "m_axi_OUTPUTS_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWREGION" }} , 
 	{ "name": "m_axi_OUTPUTS_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "AWUSER" }} , 
 	{ "name": "m_axi_OUTPUTS_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "WVALID" }} , 
 	{ "name": "m_axi_OUTPUTS_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "WREADY" }} , 
 	{ "name": "m_axi_OUTPUTS_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "WDATA" }} , 
 	{ "name": "m_axi_OUTPUTS_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "WSTRB" }} , 
 	{ "name": "m_axi_OUTPUTS_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "WLAST" }} , 
 	{ "name": "m_axi_OUTPUTS_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "WID" }} , 
 	{ "name": "m_axi_OUTPUTS_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "WUSER" }} , 
 	{ "name": "m_axi_OUTPUTS_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARVALID" }} , 
 	{ "name": "m_axi_OUTPUTS_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARREADY" }} , 
 	{ "name": "m_axi_OUTPUTS_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARADDR" }} , 
 	{ "name": "m_axi_OUTPUTS_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARID" }} , 
 	{ "name": "m_axi_OUTPUTS_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARLEN" }} , 
 	{ "name": "m_axi_OUTPUTS_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_OUTPUTS_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARBURST" }} , 
 	{ "name": "m_axi_OUTPUTS_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_OUTPUTS_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_OUTPUTS_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARPROT" }} , 
 	{ "name": "m_axi_OUTPUTS_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARQOS" }} , 
 	{ "name": "m_axi_OUTPUTS_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARREGION" }} , 
 	{ "name": "m_axi_OUTPUTS_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "ARUSER" }} , 
 	{ "name": "m_axi_OUTPUTS_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "RVALID" }} , 
 	{ "name": "m_axi_OUTPUTS_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "RREADY" }} , 
 	{ "name": "m_axi_OUTPUTS_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "RDATA" }} , 
 	{ "name": "m_axi_OUTPUTS_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "RLAST" }} , 
 	{ "name": "m_axi_OUTPUTS_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "RID" }} , 
 	{ "name": "m_axi_OUTPUTS_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "RUSER" }} , 
 	{ "name": "m_axi_OUTPUTS_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "RRESP" }} , 
 	{ "name": "m_axi_OUTPUTS_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "BVALID" }} , 
 	{ "name": "m_axi_OUTPUTS_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "BREADY" }} , 
 	{ "name": "m_axi_OUTPUTS_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "BRESP" }} , 
 	{ "name": "m_axi_OUTPUTS_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "BID" }} , 
 	{ "name": "m_axi_OUTPUTS_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUTPUTS", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "9"],
		"CDFG" : "TOPANN",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1",
		"FunctionPipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"VariableLatency" : "1",
		"InputProcess" : [
			{"ID" : "5", "Name" : "Loop_memcpy_Ainputs_8_U0", "ReadyCount" : "Loop_memcpy_Ainputs_8_U0_ap_ready_count"},
			{"ID" : "6", "Name" : "Loop_neuronLoop_proc_U0", "ReadyCount" : "Loop_neuronLoop_proc_U0_ap_ready_count"}],
		"OutputProcess" : [
			{"ID" : "6", "Name" : "Loop_neuronLoop_proc_U0"}],
		"Port" : [
			{"Name" : "p3", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_memcpy_Ainputs_8_U0", "Port" : "inputs_V"}]},
			{"Name" : "OUTPUTS", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "result_V"}]},
			{"Name" : "inputs_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "layerWeigth_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "layerWeigth_V"}]},
			{"Name" : "bias_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "bias_V"}]},
			{"Name" : "outputLayerWeigth_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "outputLayerWeigth_V"}]},
			{"Name" : "outputLayerBias_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "outputLayerBias_V"}]},
			{"Name" : "result_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "coeTanSig_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "coeTanSig_V"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.TOPANN_AXILiteS_s_axi_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.TOPANN_p3_m_axi_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.TOPANN_OUTPUTS_m_axi_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Ainputs_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Loop_memcpy_Ainputs_8_U0", "Parent" : "0",
		"CDFG" : "Loop_memcpy_Ainputs_8",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1",
		"FunctionPipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"VariableLatency" : "1",
		"Port" : [
			{"Name" : "inputs_V", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "inputs_V_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "inputs_V_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "inputs_V_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "Ainputs", "Type" : "Memory", "Direction" : "O", "DependentProc" : "6", "DependentChan" : "4"},
			{"Name" : "result_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "result_V_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "6", "DependentChan" : "9",
				"BlockSignal" : [
					{"Name" : "result_V_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Loop_neuronLoop_proc_U0", "Parent" : "0", "Child" : ["7", "8"],
		"CDFG" : "Loop_neuronLoop_proc",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1",
		"FunctionPipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"VariableLatency" : "1",
		"Port" : [
			{"Name" : "bias_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "layerWeigth_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "Ainputs", "Type" : "Memory", "Direction" : "I", "DependentProc" : "5", "DependentChan" : "4"},
			{"Name" : "outputLayerWeigth_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "outputLayerBias_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "result_V", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "result_V_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "result_V_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "result_V_blk_n_B", "Type" : "RtlSignal"}]},
			{"Name" : "result_V_offset", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "5", "DependentChan" : "9",
				"BlockSignal" : [
					{"Name" : "result_V_offset_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "coeTanSig_V", "Type" : "Memory", "Direction" : "I"}]},
	{"ID" : "7", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_neuronLoop_proc_U0.coeTanSig_V_U", "Parent" : "6"},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_neuronLoop_proc_U0.layerResult_V_U", "Parent" : "6"},
	{"ID" : "9", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.result_V_c_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	TOPANN {
		p3 {Type I LastRead 8 FirstWrite -1}
		OUTPUTS {Type O LastRead 8 FirstWrite 7}
		inputs_V {Type I LastRead 0 FirstWrite -1}
		layerWeigth_V {Type I LastRead 2 FirstWrite -1}
		bias_V {Type I LastRead 2 FirstWrite -1}
		outputLayerWeigth_V {Type I LastRead 2 FirstWrite -1}
		outputLayerBias_V {Type I LastRead 2 FirstWrite -1}
		result_V {Type I LastRead 0 FirstWrite -1}
		coeTanSig_V {Type I LastRead -1 FirstWrite -1}}
	Loop_memcpy_Ainputs_8 {
		inputs_V {Type I LastRead 8 FirstWrite -1}
		inputs_V_offset {Type I LastRead 0 FirstWrite -1}
		Ainputs {Type O LastRead -1 FirstWrite 9}
		result_V {Type I LastRead 6 FirstWrite -1}
		result_V_out {Type O LastRead -1 FirstWrite 6}}
	Loop_neuronLoop_proc {
		bias_V {Type I LastRead 2 FirstWrite -1}
		layerWeigth_V {Type I LastRead 2 FirstWrite -1}
		Ainputs {Type I LastRead 2 FirstWrite -1}
		outputLayerWeigth_V {Type I LastRead 2 FirstWrite -1}
		outputLayerBias_V {Type I LastRead 2 FirstWrite -1}
		result_V {Type O LastRead 8 FirstWrite 7}
		result_V_offset {Type I LastRead 0 FirstWrite -1}
		coeTanSig_V {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "83", "Max" : "91"}
	, {"Name" : "Interval", "Min" : "71", "Max" : "79"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	p3 { m_axi {  { m_axi_p3_AWVALID VALID 1 1 }  { m_axi_p3_AWREADY READY 0 1 }  { m_axi_p3_AWADDR ADDR 1 32 }  { m_axi_p3_AWID ID 1 1 }  { m_axi_p3_AWLEN LEN 1 8 }  { m_axi_p3_AWSIZE SIZE 1 3 }  { m_axi_p3_AWBURST BURST 1 2 }  { m_axi_p3_AWLOCK LOCK 1 2 }  { m_axi_p3_AWCACHE CACHE 1 4 }  { m_axi_p3_AWPROT PROT 1 3 }  { m_axi_p3_AWQOS QOS 1 4 }  { m_axi_p3_AWREGION REGION 1 4 }  { m_axi_p3_AWUSER USER 1 1 }  { m_axi_p3_WVALID VALID 1 1 }  { m_axi_p3_WREADY READY 0 1 }  { m_axi_p3_WDATA DATA 1 32 }  { m_axi_p3_WSTRB STRB 1 4 }  { m_axi_p3_WLAST LAST 1 1 }  { m_axi_p3_WID ID 1 1 }  { m_axi_p3_WUSER USER 1 1 }  { m_axi_p3_ARVALID VALID 1 1 }  { m_axi_p3_ARREADY READY 0 1 }  { m_axi_p3_ARADDR ADDR 1 32 }  { m_axi_p3_ARID ID 1 1 }  { m_axi_p3_ARLEN LEN 1 8 }  { m_axi_p3_ARSIZE SIZE 1 3 }  { m_axi_p3_ARBURST BURST 1 2 }  { m_axi_p3_ARLOCK LOCK 1 2 }  { m_axi_p3_ARCACHE CACHE 1 4 }  { m_axi_p3_ARPROT PROT 1 3 }  { m_axi_p3_ARQOS QOS 1 4 }  { m_axi_p3_ARREGION REGION 1 4 }  { m_axi_p3_ARUSER USER 1 1 }  { m_axi_p3_RVALID VALID 0 1 }  { m_axi_p3_RREADY READY 1 1 }  { m_axi_p3_RDATA DATA 0 32 }  { m_axi_p3_RLAST LAST 0 1 }  { m_axi_p3_RID ID 0 1 }  { m_axi_p3_RUSER USER 0 1 }  { m_axi_p3_RRESP RESP 0 2 }  { m_axi_p3_BVALID VALID 0 1 }  { m_axi_p3_BREADY READY 1 1 }  { m_axi_p3_BRESP RESP 0 2 }  { m_axi_p3_BID ID 0 1 }  { m_axi_p3_BUSER USER 0 1 } } }
	OUTPUTS { m_axi {  { m_axi_OUTPUTS_AWVALID VALID 1 1 }  { m_axi_OUTPUTS_AWREADY READY 0 1 }  { m_axi_OUTPUTS_AWADDR ADDR 1 32 }  { m_axi_OUTPUTS_AWID ID 1 1 }  { m_axi_OUTPUTS_AWLEN LEN 1 8 }  { m_axi_OUTPUTS_AWSIZE SIZE 1 3 }  { m_axi_OUTPUTS_AWBURST BURST 1 2 }  { m_axi_OUTPUTS_AWLOCK LOCK 1 2 }  { m_axi_OUTPUTS_AWCACHE CACHE 1 4 }  { m_axi_OUTPUTS_AWPROT PROT 1 3 }  { m_axi_OUTPUTS_AWQOS QOS 1 4 }  { m_axi_OUTPUTS_AWREGION REGION 1 4 }  { m_axi_OUTPUTS_AWUSER USER 1 1 }  { m_axi_OUTPUTS_WVALID VALID 1 1 }  { m_axi_OUTPUTS_WREADY READY 0 1 }  { m_axi_OUTPUTS_WDATA DATA 1 32 }  { m_axi_OUTPUTS_WSTRB STRB 1 4 }  { m_axi_OUTPUTS_WLAST LAST 1 1 }  { m_axi_OUTPUTS_WID ID 1 1 }  { m_axi_OUTPUTS_WUSER USER 1 1 }  { m_axi_OUTPUTS_ARVALID VALID 1 1 }  { m_axi_OUTPUTS_ARREADY READY 0 1 }  { m_axi_OUTPUTS_ARADDR ADDR 1 32 }  { m_axi_OUTPUTS_ARID ID 1 1 }  { m_axi_OUTPUTS_ARLEN LEN 1 8 }  { m_axi_OUTPUTS_ARSIZE SIZE 1 3 }  { m_axi_OUTPUTS_ARBURST BURST 1 2 }  { m_axi_OUTPUTS_ARLOCK LOCK 1 2 }  { m_axi_OUTPUTS_ARCACHE CACHE 1 4 }  { m_axi_OUTPUTS_ARPROT PROT 1 3 }  { m_axi_OUTPUTS_ARQOS QOS 1 4 }  { m_axi_OUTPUTS_ARREGION REGION 1 4 }  { m_axi_OUTPUTS_ARUSER USER 1 1 }  { m_axi_OUTPUTS_RVALID VALID 0 1 }  { m_axi_OUTPUTS_RREADY READY 1 1 }  { m_axi_OUTPUTS_RDATA DATA 0 32 }  { m_axi_OUTPUTS_RLAST LAST 0 1 }  { m_axi_OUTPUTS_RID ID 0 1 }  { m_axi_OUTPUTS_RUSER USER 0 1 }  { m_axi_OUTPUTS_RRESP RESP 0 2 }  { m_axi_OUTPUTS_BVALID VALID 0 1 }  { m_axi_OUTPUTS_BREADY READY 1 1 }  { m_axi_OUTPUTS_BRESP RESP 0 2 }  { m_axi_OUTPUTS_BID ID 0 1 }  { m_axi_OUTPUTS_BUSER USER 0 1 } } }
}

set busDeadlockParameterList { 
	{ p3 { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 } } \
	{ OUTPUTS { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 } } \
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ p3 1 }
	{ OUTPUTS 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ p3 1 }
	{ OUTPUTS 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
