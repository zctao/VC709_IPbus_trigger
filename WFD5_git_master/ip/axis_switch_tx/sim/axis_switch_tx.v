// (c) Copyright 1995-2014 Xilinx, Inc. All rights reserved.
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


// IP VLNV: xilinx.com:ip:axis_switch:1.1
// IP Revision: 1

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module axis_switch_tx (
  aclk,
  aresetn,
  s_axis_tvalid,
  s_axis_tready,
  s_axis_tdata,
  s_axis_tlast,
  s_axis_tdest,
  m_axis_tvalid,
  m_axis_tready,
  m_axis_tdata,
  m_axis_tlast,
  m_axis_tdest,
  s_decode_err
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLKIF CLK" *)
input wire aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RSTIF RST" *)
input wire aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS tvalid" *)
input wire [0 : 0] s_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS tready" *)
output wire [0 : 0] s_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS tdata" *)
input wire [31 : 0] s_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS tlast" *)
input wire [0 : 0] s_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS tdest" *)
input wire [0 : 0] s_axis_tdest;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS tvalid [0:0] [0:0], xilinx.com:interface:axis:1.0 M01_AXIS tvalid [0:0] [1:1]" *)
output wire [1 : 0] m_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS tready [0:0] [0:0], xilinx.com:interface:axis:1.0 M01_AXIS tready [0:0] [1:1]" *)
input wire [1 : 0] m_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS tdata [31:0] [31:0], xilinx.com:interface:axis:1.0 M01_AXIS tdata [31:0] [63:32]" *)
output wire [63 : 0] m_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS tlast [0:0] [0:0], xilinx.com:interface:axis:1.0 M01_AXIS tlast [0:0] [1:1]" *)
output wire [1 : 0] m_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS tdest [0:0] [0:0], xilinx.com:interface:axis:1.0 M01_AXIS tdest [0:0] [1:1]" *)
output wire [1 : 0] m_axis_tdest;
output wire [0 : 0] s_decode_err;

  axis_switch_v1_1_axis_switch #(
    .C_FAMILY("kintex7"),
    .C_NUM_SI_SLOTS(1),
    .C_LOG_SI_SLOTS(1),
    .C_NUM_MI_SLOTS(2),
    .C_AXIS_TDATA_WIDTH(32),
    .C_AXIS_TID_WIDTH(1),
    .C_AXIS_TDEST_WIDTH(1),
    .C_AXIS_TUSER_WIDTH(1),
    .C_AXIS_SIGNAL_SET(32'B01010011),
    .C_ARB_ON_MAX_XFERS(1),
    .C_ARB_ON_NUM_CYCLES(0),
    .C_ARB_ON_TLAST(0),
    .C_INCLUDE_ARBITER(1),
    .C_ARB_ALGORITHM(0),
    .C_OUTPUT_REG(0),
    .C_DECODER_REG(1),
    .C_M_AXIS_CONNECTIVITY_ARRAY(2'B11),
    .C_M_AXIS_BASETDEST_ARRAY(2'B10),
    .C_M_AXIS_HIGHTDEST_ARRAY(2'B10)
  ) inst (
    .aclk(aclk),
    .aresetn(aresetn),
    .aclken(1'H1),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tready(s_axis_tready),
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tstrb(4'HF),
    .s_axis_tkeep(4'HF),
    .s_axis_tlast(s_axis_tlast),
    .s_axis_tid(1'H0),
    .s_axis_tdest(s_axis_tdest),
    .s_axis_tuser(1'H0),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tready(m_axis_tready),
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tstrb(),
    .m_axis_tkeep(),
    .m_axis_tlast(m_axis_tlast),
    .m_axis_tid(),
    .m_axis_tdest(m_axis_tdest),
    .m_axis_tuser(),
    .arb_req(),
    .arb_done(),
    .arb_gnt(2'H0),
    .arb_sel(2'H0),
    .arb_last(),
    .arb_id(),
    .arb_dest(),
    .arb_user(),
    .s_req_suppress(1'H0),
    .s_decode_err(s_decode_err)
  );
endmodule