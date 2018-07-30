set C_TypeInfoList {{ 
"TOPANN" : [[], { "return": [[], "void"]} , [{"ExternC" : 0}], [ {"inputs": [[],{ "pointer": "0"}] }, {"layerWeigth": [[], {"array": [ {"array": ["1", [3,3]]}, [1]]}] }, {"bias": [[], {"array": [ {"array": ["1", [3]]}, [1]]}] }, {"outputLayerWeigth": [[], {"array": [ {"array": ["1", [3]]}, [1]]}] }, {"outputLayerBias": [[], {"array": ["1", [1]]}] }, {"result": [[],{ "pointer": "0"}] }],[],""], 
"0": [ "fix", {"typedef": [[[],"2"],""]}], 
"2": [ "ap_fixed<32, 8, 4, 3, 0>", {"hls_type": {"ap_fixed": [[[[], {"scalar": { "int": 32}}],[[], {"scalar": { "int": 8}}],[[], {"scalar": { "3": 4}}],[[], {"scalar": { "4": 3}}],[[], {"scalar": { "int": 0}}]],""]}}], 
"1": [ "fix", {"typedef": [[[],"2"],""]}], 
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
	{ Inputs int 32 regular {axi_master 0}  }
	{ Output_r int 32 regular {axi_master 1}  }
	{ inputs_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_0_0_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_0_1_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_0_2_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_1_0_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_1_1_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_1_2_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_2_0_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_2_1_V int 32 regular {axi_slave 0}  }
	{ layerWeigth_2_2_V int 32 regular {axi_slave 0}  }
	{ bias_0_V int 32 regular {axi_slave 0}  }
	{ bias_1_V int 32 regular {axi_slave 0}  }
	{ bias_2_V int 32 regular {axi_slave 0}  }
	{ outputLayerWeigth_0_V int 32 regular {axi_slave 0}  }
	{ outputLayerWeigth_1_V int 32 regular {axi_slave 0}  }
	{ outputLayerWeigth_2_V int 32 regular {axi_slave 0}  }
	{ outputLayerBias_V int 32 regular {axi_slave 0}  }
	{ result_V int 32 regular {axi_slave 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "Inputs", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "inputs.V","cData": "int32","bit_use": { "low": 0,"up": 31},"offset": { "type": "dynamic","port_name": "inputs_V","bundle": "AXILiteS"},"direction": "READONLY","cArray": [{"low" : 0,"up" : 2,"step" : 1}]}]}]} , 
 	{ "Name" : "Output_r", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "result.V","cData": "int32","bit_use": { "low": 0,"up": 31},"offset": { "type": "dynamic","port_name": "result_V","bundle": "AXILiteS"},"direction": "WRITEONLY","cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}]} , 
 	{ "Name" : "inputs_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":23}} , 
 	{ "Name" : "layerWeigth_0_0_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 0,"step" : 2},{"low" : 0,"up" : 0,"step" : 2}]}]}], "offset" : {"in":24}, "offset_end" : {"in":31}} , 
 	{ "Name" : "layerWeigth_0_1_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 0,"step" : 2},{"low" : 1,"up" : 1,"step" : 2}]}]}], "offset" : {"in":32}, "offset_end" : {"in":39}} , 
 	{ "Name" : "layerWeigth_0_2_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 0,"step" : 2},{"low" : 2,"up" : 2,"step" : 2}]}]}], "offset" : {"in":40}, "offset_end" : {"in":47}} , 
 	{ "Name" : "layerWeigth_1_0_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 1,"up" : 1,"step" : 2},{"low" : 0,"up" : 0,"step" : 2}]}]}], "offset" : {"in":48}, "offset_end" : {"in":55}} , 
 	{ "Name" : "layerWeigth_1_1_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 1,"up" : 1,"step" : 2},{"low" : 1,"up" : 1,"step" : 2}]}]}], "offset" : {"in":56}, "offset_end" : {"in":63}} , 
 	{ "Name" : "layerWeigth_1_2_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 1,"up" : 1,"step" : 2},{"low" : 2,"up" : 2,"step" : 2}]}]}], "offset" : {"in":64}, "offset_end" : {"in":71}} , 
 	{ "Name" : "layerWeigth_2_0_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 2,"up" : 2,"step" : 2},{"low" : 0,"up" : 0,"step" : 2}]}]}], "offset" : {"in":72}, "offset_end" : {"in":79}} , 
 	{ "Name" : "layerWeigth_2_1_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 2,"up" : 2,"step" : 2},{"low" : 1,"up" : 1,"step" : 2}]}]}], "offset" : {"in":80}, "offset_end" : {"in":87}} , 
 	{ "Name" : "layerWeigth_2_2_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "layerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 2,"up" : 2,"step" : 2},{"low" : 2,"up" : 2,"step" : 2}]}]}], "offset" : {"in":88}, "offset_end" : {"in":95}} , 
 	{ "Name" : "bias_0_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "bias.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 0,"step" : 2}]}]}], "offset" : {"in":96}, "offset_end" : {"in":103}} , 
 	{ "Name" : "bias_1_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "bias.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 1,"up" : 1,"step" : 2}]}]}], "offset" : {"in":104}, "offset_end" : {"in":111}} , 
 	{ "Name" : "bias_2_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "bias.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 2,"up" : 2,"step" : 2}]}]}], "offset" : {"in":112}, "offset_end" : {"in":119}} , 
 	{ "Name" : "outputLayerWeigth_0_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "outputLayerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 0,"up" : 0,"step" : 2}]}]}], "offset" : {"in":120}, "offset_end" : {"in":127}} , 
 	{ "Name" : "outputLayerWeigth_1_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "outputLayerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 1,"up" : 1,"step" : 2}]}]}], "offset" : {"in":128}, "offset_end" : {"in":135}} , 
 	{ "Name" : "outputLayerWeigth_2_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "outputLayerWeigth.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1},{"low" : 2,"up" : 2,"step" : 2}]}]}], "offset" : {"in":136}, "offset_end" : {"in":143}} , 
 	{ "Name" : "outputLayerBias_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_memory","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "outputLayerBias.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}], "offset" : {"in":144}, "offset_end" : {"in":151}} , 
 	{ "Name" : "result_V", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "offset" : {"in":152}, "offset_end" : {"in":159}} ]}
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
	{ m_axi_Inputs_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_Inputs_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_Inputs_AWADDR sc_out sc_lv 32 signal 0 } 
	{ m_axi_Inputs_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_Inputs_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_Inputs_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_Inputs_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_Inputs_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_Inputs_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_Inputs_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_Inputs_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_Inputs_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_Inputs_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_Inputs_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_Inputs_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_Inputs_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_Inputs_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_Inputs_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_Inputs_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_Inputs_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_Inputs_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_Inputs_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_Inputs_ARADDR sc_out sc_lv 32 signal 0 } 
	{ m_axi_Inputs_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_Inputs_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_Inputs_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_Inputs_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_Inputs_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_Inputs_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_Inputs_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_Inputs_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_Inputs_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_Inputs_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_Inputs_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_Inputs_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_Inputs_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_Inputs_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_Inputs_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_Inputs_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_Inputs_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_Inputs_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_Inputs_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_Inputs_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_Inputs_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_Inputs_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_Output_r_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_Output_r_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_Output_r_AWADDR sc_out sc_lv 32 signal 1 } 
	{ m_axi_Output_r_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_Output_r_AWLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_Output_r_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_Output_r_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_Output_r_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_Output_r_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_Output_r_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_Output_r_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_Output_r_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_Output_r_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_Output_r_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_Output_r_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_Output_r_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_Output_r_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_Output_r_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_Output_r_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_Output_r_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_Output_r_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_Output_r_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_Output_r_ARADDR sc_out sc_lv 32 signal 1 } 
	{ m_axi_Output_r_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_Output_r_ARLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_Output_r_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_Output_r_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_Output_r_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_Output_r_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_Output_r_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_Output_r_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_Output_r_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_Output_r_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_Output_r_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_Output_r_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_Output_r_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_Output_r_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_Output_r_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_Output_r_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_Output_r_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_Output_r_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_Output_r_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_Output_r_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_Output_r_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_Output_r_BUSER sc_in sc_lv 1 signal 1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_AXILiteS_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWADDR" },"address":[{"name":"TOPANN","role":"start","value":"0","valid_bit":"0"},{"name":"TOPANN","role":"continue","value":"0","valid_bit":"4"},{"name":"TOPANN","role":"auto_start","value":"0","valid_bit":"7"},{"name":"inputs_V","role":"data","value":"16"},{"name":"layerWeigth_0_0_V","role":"data","value":"24"},{"name":"layerWeigth_0_1_V","role":"data","value":"32"},{"name":"layerWeigth_0_2_V","role":"data","value":"40"},{"name":"layerWeigth_1_0_V","role":"data","value":"48"},{"name":"layerWeigth_1_1_V","role":"data","value":"56"},{"name":"layerWeigth_1_2_V","role":"data","value":"64"},{"name":"layerWeigth_2_0_V","role":"data","value":"72"},{"name":"layerWeigth_2_1_V","role":"data","value":"80"},{"name":"layerWeigth_2_2_V","role":"data","value":"88"},{"name":"bias_0_V","role":"data","value":"96"},{"name":"bias_1_V","role":"data","value":"104"},{"name":"bias_2_V","role":"data","value":"112"},{"name":"outputLayerWeigth_0_V","role":"data","value":"120"},{"name":"outputLayerWeigth_1_V","role":"data","value":"128"},{"name":"outputLayerWeigth_2_V","role":"data","value":"136"},{"name":"outputLayerBias_V","role":"data","value":"144"},{"name":"result_V","role":"data","value":"152"}] },
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
 	{ "name": "m_axi_Inputs_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "AWVALID" }} , 
 	{ "name": "m_axi_Inputs_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "AWREADY" }} , 
 	{ "name": "m_axi_Inputs_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "Inputs", "role": "AWADDR" }} , 
 	{ "name": "m_axi_Inputs_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "AWID" }} , 
 	{ "name": "m_axi_Inputs_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "Inputs", "role": "AWLEN" }} , 
 	{ "name": "m_axi_Inputs_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "Inputs", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_Inputs_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Inputs", "role": "AWBURST" }} , 
 	{ "name": "m_axi_Inputs_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Inputs", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_Inputs_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Inputs", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_Inputs_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "Inputs", "role": "AWPROT" }} , 
 	{ "name": "m_axi_Inputs_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Inputs", "role": "AWQOS" }} , 
 	{ "name": "m_axi_Inputs_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Inputs", "role": "AWREGION" }} , 
 	{ "name": "m_axi_Inputs_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "AWUSER" }} , 
 	{ "name": "m_axi_Inputs_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "WVALID" }} , 
 	{ "name": "m_axi_Inputs_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "WREADY" }} , 
 	{ "name": "m_axi_Inputs_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "Inputs", "role": "WDATA" }} , 
 	{ "name": "m_axi_Inputs_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Inputs", "role": "WSTRB" }} , 
 	{ "name": "m_axi_Inputs_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "WLAST" }} , 
 	{ "name": "m_axi_Inputs_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "WID" }} , 
 	{ "name": "m_axi_Inputs_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "WUSER" }} , 
 	{ "name": "m_axi_Inputs_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "ARVALID" }} , 
 	{ "name": "m_axi_Inputs_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "ARREADY" }} , 
 	{ "name": "m_axi_Inputs_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "Inputs", "role": "ARADDR" }} , 
 	{ "name": "m_axi_Inputs_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "ARID" }} , 
 	{ "name": "m_axi_Inputs_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "Inputs", "role": "ARLEN" }} , 
 	{ "name": "m_axi_Inputs_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "Inputs", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_Inputs_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Inputs", "role": "ARBURST" }} , 
 	{ "name": "m_axi_Inputs_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Inputs", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_Inputs_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Inputs", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_Inputs_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "Inputs", "role": "ARPROT" }} , 
 	{ "name": "m_axi_Inputs_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Inputs", "role": "ARQOS" }} , 
 	{ "name": "m_axi_Inputs_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Inputs", "role": "ARREGION" }} , 
 	{ "name": "m_axi_Inputs_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "ARUSER" }} , 
 	{ "name": "m_axi_Inputs_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "RVALID" }} , 
 	{ "name": "m_axi_Inputs_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "RREADY" }} , 
 	{ "name": "m_axi_Inputs_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "Inputs", "role": "RDATA" }} , 
 	{ "name": "m_axi_Inputs_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "RLAST" }} , 
 	{ "name": "m_axi_Inputs_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "RID" }} , 
 	{ "name": "m_axi_Inputs_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "RUSER" }} , 
 	{ "name": "m_axi_Inputs_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Inputs", "role": "RRESP" }} , 
 	{ "name": "m_axi_Inputs_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "BVALID" }} , 
 	{ "name": "m_axi_Inputs_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "BREADY" }} , 
 	{ "name": "m_axi_Inputs_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Inputs", "role": "BRESP" }} , 
 	{ "name": "m_axi_Inputs_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "BID" }} , 
 	{ "name": "m_axi_Inputs_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Inputs", "role": "BUSER" }} , 
 	{ "name": "m_axi_Output_r_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "AWVALID" }} , 
 	{ "name": "m_axi_Output_r_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "AWREADY" }} , 
 	{ "name": "m_axi_Output_r_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "Output_r", "role": "AWADDR" }} , 
 	{ "name": "m_axi_Output_r_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "AWID" }} , 
 	{ "name": "m_axi_Output_r_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "Output_r", "role": "AWLEN" }} , 
 	{ "name": "m_axi_Output_r_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "Output_r", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_Output_r_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Output_r", "role": "AWBURST" }} , 
 	{ "name": "m_axi_Output_r_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Output_r", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_Output_r_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Output_r", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_Output_r_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "Output_r", "role": "AWPROT" }} , 
 	{ "name": "m_axi_Output_r_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Output_r", "role": "AWQOS" }} , 
 	{ "name": "m_axi_Output_r_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Output_r", "role": "AWREGION" }} , 
 	{ "name": "m_axi_Output_r_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "AWUSER" }} , 
 	{ "name": "m_axi_Output_r_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "WVALID" }} , 
 	{ "name": "m_axi_Output_r_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "WREADY" }} , 
 	{ "name": "m_axi_Output_r_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "Output_r", "role": "WDATA" }} , 
 	{ "name": "m_axi_Output_r_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Output_r", "role": "WSTRB" }} , 
 	{ "name": "m_axi_Output_r_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "WLAST" }} , 
 	{ "name": "m_axi_Output_r_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "WID" }} , 
 	{ "name": "m_axi_Output_r_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "WUSER" }} , 
 	{ "name": "m_axi_Output_r_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "ARVALID" }} , 
 	{ "name": "m_axi_Output_r_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "ARREADY" }} , 
 	{ "name": "m_axi_Output_r_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "Output_r", "role": "ARADDR" }} , 
 	{ "name": "m_axi_Output_r_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "ARID" }} , 
 	{ "name": "m_axi_Output_r_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "Output_r", "role": "ARLEN" }} , 
 	{ "name": "m_axi_Output_r_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "Output_r", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_Output_r_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Output_r", "role": "ARBURST" }} , 
 	{ "name": "m_axi_Output_r_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Output_r", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_Output_r_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Output_r", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_Output_r_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "Output_r", "role": "ARPROT" }} , 
 	{ "name": "m_axi_Output_r_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Output_r", "role": "ARQOS" }} , 
 	{ "name": "m_axi_Output_r_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "Output_r", "role": "ARREGION" }} , 
 	{ "name": "m_axi_Output_r_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "ARUSER" }} , 
 	{ "name": "m_axi_Output_r_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "RVALID" }} , 
 	{ "name": "m_axi_Output_r_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "RREADY" }} , 
 	{ "name": "m_axi_Output_r_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "Output_r", "role": "RDATA" }} , 
 	{ "name": "m_axi_Output_r_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "RLAST" }} , 
 	{ "name": "m_axi_Output_r_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "RID" }} , 
 	{ "name": "m_axi_Output_r_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "RUSER" }} , 
 	{ "name": "m_axi_Output_r_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Output_r", "role": "RRESP" }} , 
 	{ "name": "m_axi_Output_r_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "BVALID" }} , 
 	{ "name": "m_axi_Output_r_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "BREADY" }} , 
 	{ "name": "m_axi_Output_r_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Output_r", "role": "BRESP" }} , 
 	{ "name": "m_axi_Output_r_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "BID" }} , 
 	{ "name": "m_axi_Output_r_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "Output_r", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "12", "13", "14", "15"],
		"CDFG" : "TOPANN",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1",
		"FunctionPipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"VariableLatency" : "1",
		"InputProcess" : [
			{"ID" : "4", "Name" : "Loop_memcpy_Ainputs_7_U0", "ReadyCount" : "Loop_memcpy_Ainputs_7_U0_ap_ready_count"},
			{"ID" : "5", "Name" : "Loop_neuronLoop_proc_U0", "ReadyCount" : "Loop_neuronLoop_proc_U0_ap_ready_count"}],
		"OutputProcess" : [
			{"ID" : "5", "Name" : "Loop_neuronLoop_proc_U0"}],
		"Port" : [
			{"Name" : "Inputs", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "Loop_memcpy_Ainputs_7_U0", "Port" : "inputs_V"}]},
			{"Name" : "Output_r", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "result_V"}]},
			{"Name" : "inputs_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "layerWeigth_0_0_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "layerWeigth_0_0_V"}]},
			{"Name" : "layerWeigth_0_1_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "layerWeigth_0_1_V"}]},
			{"Name" : "layerWeigth_0_2_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "layerWeigth_0_2_V"}]},
			{"Name" : "layerWeigth_1_0_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "layerWeigth_1_0_V"}]},
			{"Name" : "layerWeigth_1_1_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "layerWeigth_1_1_V"}]},
			{"Name" : "layerWeigth_1_2_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "layerWeigth_1_2_V"}]},
			{"Name" : "layerWeigth_2_0_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "layerWeigth_2_0_V"}]},
			{"Name" : "layerWeigth_2_1_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "layerWeigth_2_1_V"}]},
			{"Name" : "layerWeigth_2_2_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "layerWeigth_2_2_V"}]},
			{"Name" : "bias_0_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "bias_0_V"}]},
			{"Name" : "bias_1_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "bias_1_V"}]},
			{"Name" : "bias_2_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "bias_2_V"}]},
			{"Name" : "outputLayerWeigth_0_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "outputLayerWeigth_0_V"}]},
			{"Name" : "outputLayerWeigth_1_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "outputLayerWeigth_1_V"}]},
			{"Name" : "outputLayerWeigth_2_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "outputLayerWeigth_2_V"}]},
			{"Name" : "outputLayerBias_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "outputLayerBias_V"}]},
			{"Name" : "result_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "coeTanSig_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "Loop_neuronLoop_proc_U0", "Port" : "coeTanSig_V"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.TOPANN_AXILiteS_s_axi_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.TOPANN_Inputs_m_axi_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.TOPANN_Output_r_m_axi_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Loop_memcpy_Ainputs_7_U0", "Parent" : "0",
		"CDFG" : "Loop_memcpy_Ainputs_7",
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
			{"Name" : "result_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "result_V_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "5", "DependentChan" : "12",
				"BlockSignal" : [
					{"Name" : "result_V_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Loop_neuronLoop_proc_U0", "Parent" : "0", "Child" : ["6", "7", "8", "9", "10", "11"],
		"CDFG" : "Loop_neuronLoop_proc",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1",
		"FunctionPipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"VariableLatency" : "1",
		"Port" : [
			{"Name" : "layerWeigth_0_0_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "layerWeigth_1_0_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "layerWeigth_2_0_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "p_read", "Type" : "None", "Direction" : "I", "DependentProc" : "4", "DependentChan" : "15"},
			{"Name" : "layerWeigth_0_1_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "layerWeigth_1_1_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "layerWeigth_2_1_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "p_read1", "Type" : "None", "Direction" : "I", "DependentProc" : "4", "DependentChan" : "14"},
			{"Name" : "layerWeigth_0_2_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "layerWeigth_1_2_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "layerWeigth_2_2_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "p_read2", "Type" : "None", "Direction" : "I", "DependentProc" : "4", "DependentChan" : "13"},
			{"Name" : "bias_0_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "bias_1_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "bias_2_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "outputLayerWeigth_0_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "outputLayerWeigth_1_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "outputLayerWeigth_2_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "outputLayerBias_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "result_V", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "result_V_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "result_V_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "result_V_blk_n_B", "Type" : "RtlSignal"}]},
			{"Name" : "result_V_offset", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "4", "DependentChan" : "12",
				"BlockSignal" : [
					{"Name" : "result_V_offset_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "coeTanSig_V", "Type" : "Memory", "Direction" : "I"}]},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_neuronLoop_proc_U0.coeTanSig_V_U", "Parent" : "5"},
	{"ID" : "7", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_neuronLoop_proc_U0.layerResult_V_U", "Parent" : "5"},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_neuronLoop_proc_U0.TOPANN_mux_32_32_dEe_U5", "Parent" : "5"},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_neuronLoop_proc_U0.TOPANN_mux_32_32_dEe_U6", "Parent" : "5"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_neuronLoop_proc_U0.TOPANN_mux_32_32_dEe_U7", "Parent" : "5"},
	{"ID" : "11", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_neuronLoop_proc_U0.TOPANN_mux_32_32_dEe_U8", "Parent" : "5"},
	{"ID" : "12", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.result_V_c_U", "Parent" : "0"},
	{"ID" : "13", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Ainputs_2_loc_chann_U", "Parent" : "0"},
	{"ID" : "14", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Ainputs_1_loc_chann_U", "Parent" : "0"},
	{"ID" : "15", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Ainputs_0_loc_chann_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	TOPANN {
		Inputs {Type I LastRead 8 FirstWrite -1}
		Output_r {Type O LastRead 12 FirstWrite 11}
		inputs_V {Type I LastRead 0 FirstWrite -1}
		layerWeigth_0_0_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_0_1_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_0_2_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_1_0_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_1_1_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_1_2_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_2_0_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_2_1_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_2_2_V {Type I LastRead 1 FirstWrite -1}
		bias_0_V {Type I LastRead 3 FirstWrite -1}
		bias_1_V {Type I LastRead 3 FirstWrite -1}
		bias_2_V {Type I LastRead 3 FirstWrite -1}
		outputLayerWeigth_0_V {Type I LastRead 3 FirstWrite -1}
		outputLayerWeigth_1_V {Type I LastRead 3 FirstWrite -1}
		outputLayerWeigth_2_V {Type I LastRead 3 FirstWrite -1}
		outputLayerBias_V {Type I LastRead 5 FirstWrite -1}
		result_V {Type I LastRead 0 FirstWrite -1}
		coeTanSig_V {Type I LastRead -1 FirstWrite -1}}
	Loop_memcpy_Ainputs_7 {
		inputs_V {Type I LastRead 8 FirstWrite -1}
		inputs_V_offset {Type I LastRead 0 FirstWrite -1}
		result_V {Type I LastRead 6 FirstWrite -1}
		result_V_out {Type O LastRead -1 FirstWrite 6}}
	Loop_neuronLoop_proc {
		layerWeigth_0_0_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_1_0_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_2_0_V {Type I LastRead 1 FirstWrite -1}
		p_read {Type I LastRead 0 FirstWrite -1}
		layerWeigth_0_1_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_1_1_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_2_1_V {Type I LastRead 1 FirstWrite -1}
		p_read1 {Type I LastRead 0 FirstWrite -1}
		layerWeigth_0_2_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_1_2_V {Type I LastRead 1 FirstWrite -1}
		layerWeigth_2_2_V {Type I LastRead 1 FirstWrite -1}
		p_read2 {Type I LastRead 0 FirstWrite -1}
		bias_0_V {Type I LastRead 3 FirstWrite -1}
		bias_1_V {Type I LastRead 3 FirstWrite -1}
		bias_2_V {Type I LastRead 3 FirstWrite -1}
		outputLayerWeigth_0_V {Type I LastRead 3 FirstWrite -1}
		outputLayerWeigth_1_V {Type I LastRead 3 FirstWrite -1}
		outputLayerWeigth_2_V {Type I LastRead 3 FirstWrite -1}
		outputLayerBias_V {Type I LastRead 5 FirstWrite -1}
		result_V {Type O LastRead 12 FirstWrite 11}
		result_V_offset {Type I LastRead 0 FirstWrite -1}
		coeTanSig_V {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "36", "Max" : "38"}
	, {"Name" : "Interval", "Min" : "24", "Max" : "26"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	Inputs { m_axi {  { m_axi_Inputs_AWVALID VALID 1 1 }  { m_axi_Inputs_AWREADY READY 0 1 }  { m_axi_Inputs_AWADDR ADDR 1 32 }  { m_axi_Inputs_AWID ID 1 1 }  { m_axi_Inputs_AWLEN LEN 1 8 }  { m_axi_Inputs_AWSIZE SIZE 1 3 }  { m_axi_Inputs_AWBURST BURST 1 2 }  { m_axi_Inputs_AWLOCK LOCK 1 2 }  { m_axi_Inputs_AWCACHE CACHE 1 4 }  { m_axi_Inputs_AWPROT PROT 1 3 }  { m_axi_Inputs_AWQOS QOS 1 4 }  { m_axi_Inputs_AWREGION REGION 1 4 }  { m_axi_Inputs_AWUSER USER 1 1 }  { m_axi_Inputs_WVALID VALID 1 1 }  { m_axi_Inputs_WREADY READY 0 1 }  { m_axi_Inputs_WDATA DATA 1 32 }  { m_axi_Inputs_WSTRB STRB 1 4 }  { m_axi_Inputs_WLAST LAST 1 1 }  { m_axi_Inputs_WID ID 1 1 }  { m_axi_Inputs_WUSER USER 1 1 }  { m_axi_Inputs_ARVALID VALID 1 1 }  { m_axi_Inputs_ARREADY READY 0 1 }  { m_axi_Inputs_ARADDR ADDR 1 32 }  { m_axi_Inputs_ARID ID 1 1 }  { m_axi_Inputs_ARLEN LEN 1 8 }  { m_axi_Inputs_ARSIZE SIZE 1 3 }  { m_axi_Inputs_ARBURST BURST 1 2 }  { m_axi_Inputs_ARLOCK LOCK 1 2 }  { m_axi_Inputs_ARCACHE CACHE 1 4 }  { m_axi_Inputs_ARPROT PROT 1 3 }  { m_axi_Inputs_ARQOS QOS 1 4 }  { m_axi_Inputs_ARREGION REGION 1 4 }  { m_axi_Inputs_ARUSER USER 1 1 }  { m_axi_Inputs_RVALID VALID 0 1 }  { m_axi_Inputs_RREADY READY 1 1 }  { m_axi_Inputs_RDATA DATA 0 32 }  { m_axi_Inputs_RLAST LAST 0 1 }  { m_axi_Inputs_RID ID 0 1 }  { m_axi_Inputs_RUSER USER 0 1 }  { m_axi_Inputs_RRESP RESP 0 2 }  { m_axi_Inputs_BVALID VALID 0 1 }  { m_axi_Inputs_BREADY READY 1 1 }  { m_axi_Inputs_BRESP RESP 0 2 }  { m_axi_Inputs_BID ID 0 1 }  { m_axi_Inputs_BUSER USER 0 1 } } }
	Output_r { m_axi {  { m_axi_Output_r_AWVALID VALID 1 1 }  { m_axi_Output_r_AWREADY READY 0 1 }  { m_axi_Output_r_AWADDR ADDR 1 32 }  { m_axi_Output_r_AWID ID 1 1 }  { m_axi_Output_r_AWLEN LEN 1 8 }  { m_axi_Output_r_AWSIZE SIZE 1 3 }  { m_axi_Output_r_AWBURST BURST 1 2 }  { m_axi_Output_r_AWLOCK LOCK 1 2 }  { m_axi_Output_r_AWCACHE CACHE 1 4 }  { m_axi_Output_r_AWPROT PROT 1 3 }  { m_axi_Output_r_AWQOS QOS 1 4 }  { m_axi_Output_r_AWREGION REGION 1 4 }  { m_axi_Output_r_AWUSER USER 1 1 }  { m_axi_Output_r_WVALID VALID 1 1 }  { m_axi_Output_r_WREADY READY 0 1 }  { m_axi_Output_r_WDATA DATA 1 32 }  { m_axi_Output_r_WSTRB STRB 1 4 }  { m_axi_Output_r_WLAST LAST 1 1 }  { m_axi_Output_r_WID ID 1 1 }  { m_axi_Output_r_WUSER USER 1 1 }  { m_axi_Output_r_ARVALID VALID 1 1 }  { m_axi_Output_r_ARREADY READY 0 1 }  { m_axi_Output_r_ARADDR ADDR 1 32 }  { m_axi_Output_r_ARID ID 1 1 }  { m_axi_Output_r_ARLEN LEN 1 8 }  { m_axi_Output_r_ARSIZE SIZE 1 3 }  { m_axi_Output_r_ARBURST BURST 1 2 }  { m_axi_Output_r_ARLOCK LOCK 1 2 }  { m_axi_Output_r_ARCACHE CACHE 1 4 }  { m_axi_Output_r_ARPROT PROT 1 3 }  { m_axi_Output_r_ARQOS QOS 1 4 }  { m_axi_Output_r_ARREGION REGION 1 4 }  { m_axi_Output_r_ARUSER USER 1 1 }  { m_axi_Output_r_RVALID VALID 0 1 }  { m_axi_Output_r_RREADY READY 1 1 }  { m_axi_Output_r_RDATA DATA 0 32 }  { m_axi_Output_r_RLAST LAST 0 1 }  { m_axi_Output_r_RID ID 0 1 }  { m_axi_Output_r_RUSER USER 0 1 }  { m_axi_Output_r_RRESP RESP 0 2 }  { m_axi_Output_r_BVALID VALID 0 1 }  { m_axi_Output_r_BREADY READY 1 1 }  { m_axi_Output_r_BRESP RESP 0 2 }  { m_axi_Output_r_BID ID 0 1 }  { m_axi_Output_r_BUSER USER 0 1 } } }
}

set busDeadlockParameterList { 
	{ Inputs { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 } } \
	{ Output_r { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 } } \
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ Inputs 1 }
	{ Output_r 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ Inputs 1 }
	{ Output_r 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
