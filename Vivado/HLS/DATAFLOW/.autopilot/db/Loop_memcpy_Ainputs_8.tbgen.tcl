set moduleName Loop_memcpy_Ainputs_8
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set C_modelName {Loop_memcpy.Ainputs.8}
set C_modelType { void 0 }
set C_modelArgList {
	{ inputs_V int 32 regular {axi_master 0}  }
	{ inputs_V_offset int 32 regular  }
	{ Ainputs int 32 regular {array 3 { 0 3 } 0 1 }  }
	{ result_V int 32 regular  }
	{ result_V_out int 32 regular {fifo 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "inputs_V", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "inputs_V_offset", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "Ainputs", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "result_V", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "result_V_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 61
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ m_axi_inputs_V_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_AWADDR sc_out sc_lv 32 signal 0 } 
	{ m_axi_inputs_V_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_inputs_V_AWLEN sc_out sc_lv 32 signal 0 } 
	{ m_axi_inputs_V_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_inputs_V_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_inputs_V_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_inputs_V_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_inputs_V_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_inputs_V_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_inputs_V_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_inputs_V_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_inputs_V_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_inputs_V_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_inputs_V_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_inputs_V_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_inputs_V_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_ARADDR sc_out sc_lv 32 signal 0 } 
	{ m_axi_inputs_V_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_inputs_V_ARLEN sc_out sc_lv 32 signal 0 } 
	{ m_axi_inputs_V_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_inputs_V_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_inputs_V_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_inputs_V_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_inputs_V_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_inputs_V_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_inputs_V_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_inputs_V_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_inputs_V_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_inputs_V_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_inputs_V_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_inputs_V_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_inputs_V_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_inputs_V_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_inputs_V_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_inputs_V_BUSER sc_in sc_lv 1 signal 0 } 
	{ inputs_V_offset sc_in sc_lv 32 signal 1 } 
	{ Ainputs_address0 sc_out sc_lv 2 signal 2 } 
	{ Ainputs_ce0 sc_out sc_logic 1 signal 2 } 
	{ Ainputs_we0 sc_out sc_logic 1 signal 2 } 
	{ Ainputs_d0 sc_out sc_lv 32 signal 2 } 
	{ result_V sc_in sc_lv 32 signal 3 } 
	{ result_V_out_din sc_out sc_lv 32 signal 4 } 
	{ result_V_out_full_n sc_in sc_logic 1 signal 4 } 
	{ result_V_out_write sc_out sc_logic 1 signal 4 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "m_axi_inputs_V_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWVALID" }} , 
 	{ "name": "m_axi_inputs_V_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWREADY" }} , 
 	{ "name": "m_axi_inputs_V_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWADDR" }} , 
 	{ "name": "m_axi_inputs_V_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWID" }} , 
 	{ "name": "m_axi_inputs_V_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWLEN" }} , 
 	{ "name": "m_axi_inputs_V_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_inputs_V_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWBURST" }} , 
 	{ "name": "m_axi_inputs_V_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_inputs_V_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_inputs_V_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWPROT" }} , 
 	{ "name": "m_axi_inputs_V_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWQOS" }} , 
 	{ "name": "m_axi_inputs_V_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWREGION" }} , 
 	{ "name": "m_axi_inputs_V_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "AWUSER" }} , 
 	{ "name": "m_axi_inputs_V_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "WVALID" }} , 
 	{ "name": "m_axi_inputs_V_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "WREADY" }} , 
 	{ "name": "m_axi_inputs_V_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputs_V", "role": "WDATA" }} , 
 	{ "name": "m_axi_inputs_V_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "inputs_V", "role": "WSTRB" }} , 
 	{ "name": "m_axi_inputs_V_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "WLAST" }} , 
 	{ "name": "m_axi_inputs_V_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "WID" }} , 
 	{ "name": "m_axi_inputs_V_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "WUSER" }} , 
 	{ "name": "m_axi_inputs_V_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARVALID" }} , 
 	{ "name": "m_axi_inputs_V_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARREADY" }} , 
 	{ "name": "m_axi_inputs_V_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARADDR" }} , 
 	{ "name": "m_axi_inputs_V_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARID" }} , 
 	{ "name": "m_axi_inputs_V_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARLEN" }} , 
 	{ "name": "m_axi_inputs_V_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_inputs_V_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARBURST" }} , 
 	{ "name": "m_axi_inputs_V_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_inputs_V_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_inputs_V_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARPROT" }} , 
 	{ "name": "m_axi_inputs_V_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARQOS" }} , 
 	{ "name": "m_axi_inputs_V_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARREGION" }} , 
 	{ "name": "m_axi_inputs_V_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "ARUSER" }} , 
 	{ "name": "m_axi_inputs_V_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "RVALID" }} , 
 	{ "name": "m_axi_inputs_V_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "RREADY" }} , 
 	{ "name": "m_axi_inputs_V_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputs_V", "role": "RDATA" }} , 
 	{ "name": "m_axi_inputs_V_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "RLAST" }} , 
 	{ "name": "m_axi_inputs_V_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "RID" }} , 
 	{ "name": "m_axi_inputs_V_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "RUSER" }} , 
 	{ "name": "m_axi_inputs_V_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "inputs_V", "role": "RRESP" }} , 
 	{ "name": "m_axi_inputs_V_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "BVALID" }} , 
 	{ "name": "m_axi_inputs_V_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "BREADY" }} , 
 	{ "name": "m_axi_inputs_V_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "inputs_V", "role": "BRESP" }} , 
 	{ "name": "m_axi_inputs_V_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "BID" }} , 
 	{ "name": "m_axi_inputs_V_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs_V", "role": "BUSER" }} , 
 	{ "name": "inputs_V_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputs_V_offset", "role": "default" }} , 
 	{ "name": "Ainputs_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "Ainputs", "role": "address0" }} , 
 	{ "name": "Ainputs_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Ainputs", "role": "ce0" }} , 
 	{ "name": "Ainputs_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "Ainputs", "role": "we0" }} , 
 	{ "name": "Ainputs_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "Ainputs", "role": "d0" }} , 
 	{ "name": "result_V", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "result_V", "role": "default" }} , 
 	{ "name": "result_V_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "result_V_out", "role": "din" }} , 
 	{ "name": "result_V_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "result_V_out", "role": "full_n" }} , 
 	{ "name": "result_V_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "result_V_out", "role": "write" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
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
			{"Name" : "Ainputs", "Type" : "Memory", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0"},
			{"Name" : "result_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "result_V_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0",
				"BlockSignal" : [
					{"Name" : "result_V_out_blk_n", "Type" : "RtlSignal"}]}]}]}


set ArgLastReadFirstWriteLatency {
	Loop_memcpy_Ainputs_8 {
		inputs_V {Type I LastRead 8 FirstWrite -1}
		inputs_V_offset {Type I LastRead 0 FirstWrite -1}
		Ainputs {Type O LastRead -1 FirstWrite 9}
		result_V {Type I LastRead 6 FirstWrite -1}
		result_V_out {Type O LastRead -1 FirstWrite 6}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "12", "Max" : "12"}
	, {"Name" : "Interval", "Min" : "12", "Max" : "12"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	inputs_V { m_axi {  { m_axi_inputs_V_AWVALID VALID 1 1 }  { m_axi_inputs_V_AWREADY READY 0 1 }  { m_axi_inputs_V_AWADDR ADDR 1 32 }  { m_axi_inputs_V_AWID ID 1 1 }  { m_axi_inputs_V_AWLEN LEN 1 32 }  { m_axi_inputs_V_AWSIZE SIZE 1 3 }  { m_axi_inputs_V_AWBURST BURST 1 2 }  { m_axi_inputs_V_AWLOCK LOCK 1 2 }  { m_axi_inputs_V_AWCACHE CACHE 1 4 }  { m_axi_inputs_V_AWPROT PROT 1 3 }  { m_axi_inputs_V_AWQOS QOS 1 4 }  { m_axi_inputs_V_AWREGION REGION 1 4 }  { m_axi_inputs_V_AWUSER USER 1 1 }  { m_axi_inputs_V_WVALID VALID 1 1 }  { m_axi_inputs_V_WREADY READY 0 1 }  { m_axi_inputs_V_WDATA DATA 1 32 }  { m_axi_inputs_V_WSTRB STRB 1 4 }  { m_axi_inputs_V_WLAST LAST 1 1 }  { m_axi_inputs_V_WID ID 1 1 }  { m_axi_inputs_V_WUSER USER 1 1 }  { m_axi_inputs_V_ARVALID VALID 1 1 }  { m_axi_inputs_V_ARREADY READY 0 1 }  { m_axi_inputs_V_ARADDR ADDR 1 32 }  { m_axi_inputs_V_ARID ID 1 1 }  { m_axi_inputs_V_ARLEN LEN 1 32 }  { m_axi_inputs_V_ARSIZE SIZE 1 3 }  { m_axi_inputs_V_ARBURST BURST 1 2 }  { m_axi_inputs_V_ARLOCK LOCK 1 2 }  { m_axi_inputs_V_ARCACHE CACHE 1 4 }  { m_axi_inputs_V_ARPROT PROT 1 3 }  { m_axi_inputs_V_ARQOS QOS 1 4 }  { m_axi_inputs_V_ARREGION REGION 1 4 }  { m_axi_inputs_V_ARUSER USER 1 1 }  { m_axi_inputs_V_RVALID VALID 0 1 }  { m_axi_inputs_V_RREADY READY 1 1 }  { m_axi_inputs_V_RDATA DATA 0 32 }  { m_axi_inputs_V_RLAST LAST 0 1 }  { m_axi_inputs_V_RID ID 0 1 }  { m_axi_inputs_V_RUSER USER 0 1 }  { m_axi_inputs_V_RRESP RESP 0 2 }  { m_axi_inputs_V_BVALID VALID 0 1 }  { m_axi_inputs_V_BREADY READY 1 1 }  { m_axi_inputs_V_BRESP RESP 0 2 }  { m_axi_inputs_V_BID ID 0 1 }  { m_axi_inputs_V_BUSER USER 0 1 } } }
	inputs_V_offset { ap_none {  { inputs_V_offset in_data 0 32 } } }
	Ainputs { ap_memory {  { Ainputs_address0 mem_address 1 2 }  { Ainputs_ce0 mem_ce 1 1 }  { Ainputs_we0 mem_we 1 1 }  { Ainputs_d0 mem_din 1 32 } } }
	result_V { ap_none {  { result_V in_data 0 32 } } }
	result_V_out { ap_fifo {  { result_V_out_din fifo_data 1 32 }  { result_V_out_full_n fifo_status 0 1 }  { result_V_out_write fifo_update 1 1 } } }
}
