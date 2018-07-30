// (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:TOPANN:1.4
// IP Revision: 1805122009

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module ZYBO_TOPANN_0_2 (
  s_axi_AXILiteS_AWADDR,
  s_axi_AXILiteS_AWVALID,
  s_axi_AXILiteS_AWREADY,
  s_axi_AXILiteS_WDATA,
  s_axi_AXILiteS_WSTRB,
  s_axi_AXILiteS_WVALID,
  s_axi_AXILiteS_WREADY,
  s_axi_AXILiteS_BRESP,
  s_axi_AXILiteS_BVALID,
  s_axi_AXILiteS_BREADY,
  s_axi_AXILiteS_ARADDR,
  s_axi_AXILiteS_ARVALID,
  s_axi_AXILiteS_ARREADY,
  s_axi_AXILiteS_RDATA,
  s_axi_AXILiteS_RRESP,
  s_axi_AXILiteS_RVALID,
  s_axi_AXILiteS_RREADY,
  ap_clk,
  ap_rst_n,
  interrupt,
  m_axi_INPUTS_AWADDR,
  m_axi_INPUTS_AWLEN,
  m_axi_INPUTS_AWSIZE,
  m_axi_INPUTS_AWBURST,
  m_axi_INPUTS_AWLOCK,
  m_axi_INPUTS_AWREGION,
  m_axi_INPUTS_AWCACHE,
  m_axi_INPUTS_AWPROT,
  m_axi_INPUTS_AWQOS,
  m_axi_INPUTS_AWVALID,
  m_axi_INPUTS_AWREADY,
  m_axi_INPUTS_WDATA,
  m_axi_INPUTS_WSTRB,
  m_axi_INPUTS_WLAST,
  m_axi_INPUTS_WVALID,
  m_axi_INPUTS_WREADY,
  m_axi_INPUTS_BRESP,
  m_axi_INPUTS_BVALID,
  m_axi_INPUTS_BREADY,
  m_axi_INPUTS_ARADDR,
  m_axi_INPUTS_ARLEN,
  m_axi_INPUTS_ARSIZE,
  m_axi_INPUTS_ARBURST,
  m_axi_INPUTS_ARLOCK,
  m_axi_INPUTS_ARREGION,
  m_axi_INPUTS_ARCACHE,
  m_axi_INPUTS_ARPROT,
  m_axi_INPUTS_ARQOS,
  m_axi_INPUTS_ARVALID,
  m_axi_INPUTS_ARREADY,
  m_axi_INPUTS_RDATA,
  m_axi_INPUTS_RRESP,
  m_axi_INPUTS_RLAST,
  m_axi_INPUTS_RVALID,
  m_axi_INPUTS_RREADY,
  m_axi_OUTPUTS_AWADDR,
  m_axi_OUTPUTS_AWLEN,
  m_axi_OUTPUTS_AWSIZE,
  m_axi_OUTPUTS_AWBURST,
  m_axi_OUTPUTS_AWLOCK,
  m_axi_OUTPUTS_AWREGION,
  m_axi_OUTPUTS_AWCACHE,
  m_axi_OUTPUTS_AWPROT,
  m_axi_OUTPUTS_AWQOS,
  m_axi_OUTPUTS_AWVALID,
  m_axi_OUTPUTS_AWREADY,
  m_axi_OUTPUTS_WDATA,
  m_axi_OUTPUTS_WSTRB,
  m_axi_OUTPUTS_WLAST,
  m_axi_OUTPUTS_WVALID,
  m_axi_OUTPUTS_WREADY,
  m_axi_OUTPUTS_BRESP,
  m_axi_OUTPUTS_BVALID,
  m_axi_OUTPUTS_BREADY,
  m_axi_OUTPUTS_ARADDR,
  m_axi_OUTPUTS_ARLEN,
  m_axi_OUTPUTS_ARSIZE,
  m_axi_OUTPUTS_ARBURST,
  m_axi_OUTPUTS_ARLOCK,
  m_axi_OUTPUTS_ARREGION,
  m_axi_OUTPUTS_ARCACHE,
  m_axi_OUTPUTS_ARPROT,
  m_axi_OUTPUTS_ARQOS,
  m_axi_OUTPUTS_ARVALID,
  m_axi_OUTPUTS_ARREADY,
  m_axi_OUTPUTS_RDATA,
  m_axi_OUTPUTS_RRESP,
  m_axi_OUTPUTS_RLAST,
  m_axi_OUTPUTS_RVALID,
  m_axi_OUTPUTS_RREADY
);

(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS AWADDR" *)
input wire [7 : 0] s_axi_AXILiteS_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS AWVALID" *)
input wire s_axi_AXILiteS_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS AWREADY" *)
output wire s_axi_AXILiteS_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS WDATA" *)
input wire [31 : 0] s_axi_AXILiteS_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS WSTRB" *)
input wire [3 : 0] s_axi_AXILiteS_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS WVALID" *)
input wire s_axi_AXILiteS_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS WREADY" *)
output wire s_axi_AXILiteS_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS BRESP" *)
output wire [1 : 0] s_axi_AXILiteS_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS BVALID" *)
output wire s_axi_AXILiteS_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS BREADY" *)
input wire s_axi_AXILiteS_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS ARADDR" *)
input wire [7 : 0] s_axi_AXILiteS_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS ARVALID" *)
input wire s_axi_AXILiteS_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS ARREADY" *)
output wire s_axi_AXILiteS_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS RDATA" *)
output wire [31 : 0] s_axi_AXILiteS_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS RRESP" *)
output wire [1 : 0] s_axi_AXILiteS_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS RVALID" *)
output wire s_axi_AXILiteS_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_AXILiteS, ADDR_WIDTH 8, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN ZYBO_processing_system7_0_1_FCLK_CLK0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS RREADY" *)
input wire s_axi_AXILiteS_RREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_AXILiteS:m_axi_INPUTS:m_axi_OUTPUTS, ASSOCIATED_RESET ap_rst_n, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN ZYBO_processing_system7_0_1_FCLK_CLK0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {RST {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {INTERRUPT {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, PortWidth 1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *)
output wire interrupt;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWADDR" *)
output wire [31 : 0] m_axi_INPUTS_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWLEN" *)
output wire [7 : 0] m_axi_INPUTS_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWSIZE" *)
output wire [2 : 0] m_axi_INPUTS_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWBURST" *)
output wire [1 : 0] m_axi_INPUTS_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWLOCK" *)
output wire [1 : 0] m_axi_INPUTS_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWREGION" *)
output wire [3 : 0] m_axi_INPUTS_AWREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWCACHE" *)
output wire [3 : 0] m_axi_INPUTS_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWPROT" *)
output wire [2 : 0] m_axi_INPUTS_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWQOS" *)
output wire [3 : 0] m_axi_INPUTS_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWVALID" *)
output wire m_axi_INPUTS_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS AWREADY" *)
input wire m_axi_INPUTS_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS WDATA" *)
output wire [31 : 0] m_axi_INPUTS_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS WSTRB" *)
output wire [3 : 0] m_axi_INPUTS_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS WLAST" *)
output wire m_axi_INPUTS_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS WVALID" *)
output wire m_axi_INPUTS_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS WREADY" *)
input wire m_axi_INPUTS_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS BRESP" *)
input wire [1 : 0] m_axi_INPUTS_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS BVALID" *)
input wire m_axi_INPUTS_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS BREADY" *)
output wire m_axi_INPUTS_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARADDR" *)
output wire [31 : 0] m_axi_INPUTS_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARLEN" *)
output wire [7 : 0] m_axi_INPUTS_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARSIZE" *)
output wire [2 : 0] m_axi_INPUTS_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARBURST" *)
output wire [1 : 0] m_axi_INPUTS_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARLOCK" *)
output wire [1 : 0] m_axi_INPUTS_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARREGION" *)
output wire [3 : 0] m_axi_INPUTS_ARREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARCACHE" *)
output wire [3 : 0] m_axi_INPUTS_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARPROT" *)
output wire [2 : 0] m_axi_INPUTS_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARQOS" *)
output wire [3 : 0] m_axi_INPUTS_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARVALID" *)
output wire m_axi_INPUTS_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS ARREADY" *)
input wire m_axi_INPUTS_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS RDATA" *)
input wire [31 : 0] m_axi_INPUTS_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS RRESP" *)
input wire [1 : 0] m_axi_INPUTS_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS RLAST" *)
input wire m_axi_INPUTS_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS RVALID" *)
input wire m_axi_INPUTS_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_INPUTS, ADDR_WIDTH 32, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_DOMAIN ZYBO_processing_system7_0_1_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUTS RREADY" *)
output wire m_axi_INPUTS_RREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWADDR" *)
output wire [31 : 0] m_axi_OUTPUTS_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWLEN" *)
output wire [7 : 0] m_axi_OUTPUTS_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWSIZE" *)
output wire [2 : 0] m_axi_OUTPUTS_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWBURST" *)
output wire [1 : 0] m_axi_OUTPUTS_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWLOCK" *)
output wire [1 : 0] m_axi_OUTPUTS_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWREGION" *)
output wire [3 : 0] m_axi_OUTPUTS_AWREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWCACHE" *)
output wire [3 : 0] m_axi_OUTPUTS_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWPROT" *)
output wire [2 : 0] m_axi_OUTPUTS_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWQOS" *)
output wire [3 : 0] m_axi_OUTPUTS_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWVALID" *)
output wire m_axi_OUTPUTS_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS AWREADY" *)
input wire m_axi_OUTPUTS_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS WDATA" *)
output wire [31 : 0] m_axi_OUTPUTS_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS WSTRB" *)
output wire [3 : 0] m_axi_OUTPUTS_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS WLAST" *)
output wire m_axi_OUTPUTS_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS WVALID" *)
output wire m_axi_OUTPUTS_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS WREADY" *)
input wire m_axi_OUTPUTS_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS BRESP" *)
input wire [1 : 0] m_axi_OUTPUTS_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS BVALID" *)
input wire m_axi_OUTPUTS_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS BREADY" *)
output wire m_axi_OUTPUTS_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARADDR" *)
output wire [31 : 0] m_axi_OUTPUTS_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARLEN" *)
output wire [7 : 0] m_axi_OUTPUTS_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARSIZE" *)
output wire [2 : 0] m_axi_OUTPUTS_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARBURST" *)
output wire [1 : 0] m_axi_OUTPUTS_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARLOCK" *)
output wire [1 : 0] m_axi_OUTPUTS_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARREGION" *)
output wire [3 : 0] m_axi_OUTPUTS_ARREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARCACHE" *)
output wire [3 : 0] m_axi_OUTPUTS_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARPROT" *)
output wire [2 : 0] m_axi_OUTPUTS_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARQOS" *)
output wire [3 : 0] m_axi_OUTPUTS_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARVALID" *)
output wire m_axi_OUTPUTS_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS ARREADY" *)
input wire m_axi_OUTPUTS_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS RDATA" *)
input wire [31 : 0] m_axi_OUTPUTS_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS RRESP" *)
input wire [1 : 0] m_axi_OUTPUTS_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS RLAST" *)
input wire m_axi_OUTPUTS_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS RVALID" *)
input wire m_axi_OUTPUTS_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_OUTPUTS, ADDR_WIDTH 32, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_DOMAIN ZYBO_processing_system7_0_1_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUTS RREADY" *)
output wire m_axi_OUTPUTS_RREADY;

  TOPANN #(
    .C_S_AXI_AXILITES_ADDR_WIDTH(8),
    .C_S_AXI_AXILITES_DATA_WIDTH(32),
    .C_M_AXI_INPUTS_ID_WIDTH(1),
    .C_M_AXI_INPUTS_ADDR_WIDTH(32),
    .C_M_AXI_INPUTS_DATA_WIDTH(32),
    .C_M_AXI_INPUTS_AWUSER_WIDTH(1),
    .C_M_AXI_INPUTS_ARUSER_WIDTH(1),
    .C_M_AXI_INPUTS_WUSER_WIDTH(1),
    .C_M_AXI_INPUTS_RUSER_WIDTH(1),
    .C_M_AXI_INPUTS_BUSER_WIDTH(1),
    .C_M_AXI_INPUTS_USER_VALUE('H00000000),
    .C_M_AXI_INPUTS_PROT_VALUE('B000),
    .C_M_AXI_INPUTS_CACHE_VALUE('B0011),
    .C_M_AXI_OUTPUTS_ID_WIDTH(1),
    .C_M_AXI_OUTPUTS_ADDR_WIDTH(32),
    .C_M_AXI_OUTPUTS_DATA_WIDTH(32),
    .C_M_AXI_OUTPUTS_AWUSER_WIDTH(1),
    .C_M_AXI_OUTPUTS_ARUSER_WIDTH(1),
    .C_M_AXI_OUTPUTS_WUSER_WIDTH(1),
    .C_M_AXI_OUTPUTS_RUSER_WIDTH(1),
    .C_M_AXI_OUTPUTS_BUSER_WIDTH(1),
    .C_M_AXI_OUTPUTS_USER_VALUE('H00000000),
    .C_M_AXI_OUTPUTS_PROT_VALUE('B000),
    .C_M_AXI_OUTPUTS_CACHE_VALUE('B0011)
  ) inst (
    .s_axi_AXILiteS_AWADDR(s_axi_AXILiteS_AWADDR),
    .s_axi_AXILiteS_AWVALID(s_axi_AXILiteS_AWVALID),
    .s_axi_AXILiteS_AWREADY(s_axi_AXILiteS_AWREADY),
    .s_axi_AXILiteS_WDATA(s_axi_AXILiteS_WDATA),
    .s_axi_AXILiteS_WSTRB(s_axi_AXILiteS_WSTRB),
    .s_axi_AXILiteS_WVALID(s_axi_AXILiteS_WVALID),
    .s_axi_AXILiteS_WREADY(s_axi_AXILiteS_WREADY),
    .s_axi_AXILiteS_BRESP(s_axi_AXILiteS_BRESP),
    .s_axi_AXILiteS_BVALID(s_axi_AXILiteS_BVALID),
    .s_axi_AXILiteS_BREADY(s_axi_AXILiteS_BREADY),
    .s_axi_AXILiteS_ARADDR(s_axi_AXILiteS_ARADDR),
    .s_axi_AXILiteS_ARVALID(s_axi_AXILiteS_ARVALID),
    .s_axi_AXILiteS_ARREADY(s_axi_AXILiteS_ARREADY),
    .s_axi_AXILiteS_RDATA(s_axi_AXILiteS_RDATA),
    .s_axi_AXILiteS_RRESP(s_axi_AXILiteS_RRESP),
    .s_axi_AXILiteS_RVALID(s_axi_AXILiteS_RVALID),
    .s_axi_AXILiteS_RREADY(s_axi_AXILiteS_RREADY),
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .interrupt(interrupt),
    .m_axi_INPUTS_AWID(),
    .m_axi_INPUTS_AWADDR(m_axi_INPUTS_AWADDR),
    .m_axi_INPUTS_AWLEN(m_axi_INPUTS_AWLEN),
    .m_axi_INPUTS_AWSIZE(m_axi_INPUTS_AWSIZE),
    .m_axi_INPUTS_AWBURST(m_axi_INPUTS_AWBURST),
    .m_axi_INPUTS_AWLOCK(m_axi_INPUTS_AWLOCK),
    .m_axi_INPUTS_AWREGION(m_axi_INPUTS_AWREGION),
    .m_axi_INPUTS_AWCACHE(m_axi_INPUTS_AWCACHE),
    .m_axi_INPUTS_AWPROT(m_axi_INPUTS_AWPROT),
    .m_axi_INPUTS_AWQOS(m_axi_INPUTS_AWQOS),
    .m_axi_INPUTS_AWUSER(),
    .m_axi_INPUTS_AWVALID(m_axi_INPUTS_AWVALID),
    .m_axi_INPUTS_AWREADY(m_axi_INPUTS_AWREADY),
    .m_axi_INPUTS_WID(),
    .m_axi_INPUTS_WDATA(m_axi_INPUTS_WDATA),
    .m_axi_INPUTS_WSTRB(m_axi_INPUTS_WSTRB),
    .m_axi_INPUTS_WLAST(m_axi_INPUTS_WLAST),
    .m_axi_INPUTS_WUSER(),
    .m_axi_INPUTS_WVALID(m_axi_INPUTS_WVALID),
    .m_axi_INPUTS_WREADY(m_axi_INPUTS_WREADY),
    .m_axi_INPUTS_BID(1'B0),
    .m_axi_INPUTS_BRESP(m_axi_INPUTS_BRESP),
    .m_axi_INPUTS_BUSER(1'B0),
    .m_axi_INPUTS_BVALID(m_axi_INPUTS_BVALID),
    .m_axi_INPUTS_BREADY(m_axi_INPUTS_BREADY),
    .m_axi_INPUTS_ARID(),
    .m_axi_INPUTS_ARADDR(m_axi_INPUTS_ARADDR),
    .m_axi_INPUTS_ARLEN(m_axi_INPUTS_ARLEN),
    .m_axi_INPUTS_ARSIZE(m_axi_INPUTS_ARSIZE),
    .m_axi_INPUTS_ARBURST(m_axi_INPUTS_ARBURST),
    .m_axi_INPUTS_ARLOCK(m_axi_INPUTS_ARLOCK),
    .m_axi_INPUTS_ARREGION(m_axi_INPUTS_ARREGION),
    .m_axi_INPUTS_ARCACHE(m_axi_INPUTS_ARCACHE),
    .m_axi_INPUTS_ARPROT(m_axi_INPUTS_ARPROT),
    .m_axi_INPUTS_ARQOS(m_axi_INPUTS_ARQOS),
    .m_axi_INPUTS_ARUSER(),
    .m_axi_INPUTS_ARVALID(m_axi_INPUTS_ARVALID),
    .m_axi_INPUTS_ARREADY(m_axi_INPUTS_ARREADY),
    .m_axi_INPUTS_RID(1'B0),
    .m_axi_INPUTS_RDATA(m_axi_INPUTS_RDATA),
    .m_axi_INPUTS_RRESP(m_axi_INPUTS_RRESP),
    .m_axi_INPUTS_RLAST(m_axi_INPUTS_RLAST),
    .m_axi_INPUTS_RUSER(1'B0),
    .m_axi_INPUTS_RVALID(m_axi_INPUTS_RVALID),
    .m_axi_INPUTS_RREADY(m_axi_INPUTS_RREADY),
    .m_axi_OUTPUTS_AWID(),
    .m_axi_OUTPUTS_AWADDR(m_axi_OUTPUTS_AWADDR),
    .m_axi_OUTPUTS_AWLEN(m_axi_OUTPUTS_AWLEN),
    .m_axi_OUTPUTS_AWSIZE(m_axi_OUTPUTS_AWSIZE),
    .m_axi_OUTPUTS_AWBURST(m_axi_OUTPUTS_AWBURST),
    .m_axi_OUTPUTS_AWLOCK(m_axi_OUTPUTS_AWLOCK),
    .m_axi_OUTPUTS_AWREGION(m_axi_OUTPUTS_AWREGION),
    .m_axi_OUTPUTS_AWCACHE(m_axi_OUTPUTS_AWCACHE),
    .m_axi_OUTPUTS_AWPROT(m_axi_OUTPUTS_AWPROT),
    .m_axi_OUTPUTS_AWQOS(m_axi_OUTPUTS_AWQOS),
    .m_axi_OUTPUTS_AWUSER(),
    .m_axi_OUTPUTS_AWVALID(m_axi_OUTPUTS_AWVALID),
    .m_axi_OUTPUTS_AWREADY(m_axi_OUTPUTS_AWREADY),
    .m_axi_OUTPUTS_WID(),
    .m_axi_OUTPUTS_WDATA(m_axi_OUTPUTS_WDATA),
    .m_axi_OUTPUTS_WSTRB(m_axi_OUTPUTS_WSTRB),
    .m_axi_OUTPUTS_WLAST(m_axi_OUTPUTS_WLAST),
    .m_axi_OUTPUTS_WUSER(),
    .m_axi_OUTPUTS_WVALID(m_axi_OUTPUTS_WVALID),
    .m_axi_OUTPUTS_WREADY(m_axi_OUTPUTS_WREADY),
    .m_axi_OUTPUTS_BID(1'B0),
    .m_axi_OUTPUTS_BRESP(m_axi_OUTPUTS_BRESP),
    .m_axi_OUTPUTS_BUSER(1'B0),
    .m_axi_OUTPUTS_BVALID(m_axi_OUTPUTS_BVALID),
    .m_axi_OUTPUTS_BREADY(m_axi_OUTPUTS_BREADY),
    .m_axi_OUTPUTS_ARID(),
    .m_axi_OUTPUTS_ARADDR(m_axi_OUTPUTS_ARADDR),
    .m_axi_OUTPUTS_ARLEN(m_axi_OUTPUTS_ARLEN),
    .m_axi_OUTPUTS_ARSIZE(m_axi_OUTPUTS_ARSIZE),
    .m_axi_OUTPUTS_ARBURST(m_axi_OUTPUTS_ARBURST),
    .m_axi_OUTPUTS_ARLOCK(m_axi_OUTPUTS_ARLOCK),
    .m_axi_OUTPUTS_ARREGION(m_axi_OUTPUTS_ARREGION),
    .m_axi_OUTPUTS_ARCACHE(m_axi_OUTPUTS_ARCACHE),
    .m_axi_OUTPUTS_ARPROT(m_axi_OUTPUTS_ARPROT),
    .m_axi_OUTPUTS_ARQOS(m_axi_OUTPUTS_ARQOS),
    .m_axi_OUTPUTS_ARUSER(),
    .m_axi_OUTPUTS_ARVALID(m_axi_OUTPUTS_ARVALID),
    .m_axi_OUTPUTS_ARREADY(m_axi_OUTPUTS_ARREADY),
    .m_axi_OUTPUTS_RID(1'B0),
    .m_axi_OUTPUTS_RDATA(m_axi_OUTPUTS_RDATA),
    .m_axi_OUTPUTS_RRESP(m_axi_OUTPUTS_RRESP),
    .m_axi_OUTPUTS_RLAST(m_axi_OUTPUTS_RLAST),
    .m_axi_OUTPUTS_RUSER(1'B0),
    .m_axi_OUTPUTS_RVALID(m_axi_OUTPUTS_RVALID),
    .m_axi_OUTPUTS_RREADY(m_axi_OUTPUTS_RREADY)
  );
endmodule
