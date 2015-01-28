//  (c) Copyright 2011-2013 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES. 
//-----------------------------------------------------------------------------
//
// Verilog-standard:  Verilog 2001
//--------------------------------------------------------------------------
//
// Structure:
//   axis_switch
//
//--------------------------------------------------------------------------

`timescale 1ps/1ps
`default_nettype none

(* DowngradeIPIdentifiedWarnings="yes" *)
module axis_switch_v1_1_axis_switch #
(
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
   parameter         C_FAMILY            = "virtex7",
   // C_NUM_SI_SLOTS: Number of slave interfaces (input channels)
   parameter integer C_NUM_SI_SLOTS      = 1,
   // C_LOG_SI_SLOTS: MAX(clog2(C_NUM_SI_SLOTS), 1)
   parameter integer C_LOG_SI_SLOTS      = 1,
   // C_NUM_MI_SLOTS: Number of master interfaces (output channels)
   parameter integer C_NUM_MI_SLOTS      = 2,
   parameter integer C_AXIS_TDATA_WIDTH  = 8,
   parameter integer C_AXIS_TID_WIDTH    = 1,
   parameter integer C_AXIS_TDEST_WIDTH  = 2,
   parameter integer C_AXIS_TUSER_WIDTH  = 1,
   // C_AXIS_SIGNAL_SET: each bit if enabled specifies which axis optional signals are present
   //   [0] => TREADY present
   //   [1] => TDATA present
   //   [2] => TSTRB present, TDATA must be present
   //   [3] => TKEEP present, TDATA must be present
   //   [4] => TLAST present
   //   [5] => TID present
   //   [6] => TDEST present
   //   [7] => TUSER present
   parameter [31:0]  C_AXIS_SIGNAL_SET   = 32'h43,
   // C_ARB_ON_MAX_XFERS: 
   //  0 => Ignore number of transfers to signal DONE
   //  1+ => Signal ARB_DONE after x TRANSFERS
   parameter integer C_ARB_ON_MAX_XFERS = 10,
   // C_ARB_ON_NUM_CYCLES: 
   //  0 => Ignore TIMEOUT parameter
   //  1+ => Signal ARB_DONE after x cylces of LOW TVALID
   parameter integer C_ARB_ON_NUM_CYCLES = 0,
   // C_ARB_ON_TLAST:
   //  0 => Ignore TLAST for signaling ARB_DONE 
   //  1 => Signal ARB_DONE on TLAST transfer
   parameter integer C_ARB_ON_TLAST = 0,
   // C_INCLUDE_ARBITER:
   //  0 => Enable external arbiter interface.
   //  1 => Enable built-in arbiter.
   parameter integer C_INCLUDE_ARBITER = 1,
   // C_ARBITER_ALGORITHM: Chooses arbiter algorithm
   // 0 = ROUND_ROBIN: Round-robin style arbiter
   // 1 = FIXED: Fixed priority arbiter (Port 0 highest priority, port 15 lowest
   // priority).
   parameter integer C_ARB_ALGORITHM = 0,
   // C_OUTPUT_REG: Enable output register slice
   parameter integer C_OUTPUT_REG        = 0,
   // C_DECODER_REG: Enable decoder (register slice + registered decoded
   // signals for registered arb_req output)
   parameter integer C_DECODER_REG       = 1,
   parameter [C_NUM_MI_SLOTS*C_NUM_SI_SLOTS-1:0] C_M_AXIS_CONNECTIVITY_ARRAY = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS{1'b1}},
   parameter [C_NUM_MI_SLOTS*C_AXIS_TDEST_WIDTH-1:0] C_M_AXIS_BASETDEST_ARRAY = {C_NUM_MI_SLOTS*C_AXIS_TDEST_WIDTH{1'b1}},
   parameter [C_NUM_MI_SLOTS*C_AXIS_TDEST_WIDTH-1:0] C_M_AXIS_HIGHTDEST_ARRAY = {C_NUM_MI_SLOTS*C_AXIS_TDEST_WIDTH{1'b0}}

 )
 ( 
///////////////////////////////////////////////////////////////////////////////
// Port Declarations
///////////////////////////////////////////////////////////////////////////////

   // System Signals
   input wire aclk,
   input wire aresetn,
   input wire aclken,

   // Slave side
   input  wire [C_NUM_SI_SLOTS-1:0]                                   s_axis_tvalid,
   output wire [C_NUM_SI_SLOTS-1:0]                                   s_axis_tready,
   input  wire [C_NUM_SI_SLOTS*C_AXIS_TDATA_WIDTH-1:0]                s_axis_tdata,
   input  wire [C_NUM_SI_SLOTS*C_AXIS_TDATA_WIDTH/8-1:0]              s_axis_tstrb,
   input  wire [C_NUM_SI_SLOTS*C_AXIS_TDATA_WIDTH/8-1:0]              s_axis_tkeep,
   input  wire [C_NUM_SI_SLOTS-1:0]                                   s_axis_tlast,
   input  wire [C_NUM_SI_SLOTS*C_AXIS_TID_WIDTH-1:0]                  s_axis_tid,
   input  wire [C_NUM_SI_SLOTS*C_AXIS_TDEST_WIDTH-1:0]                s_axis_tdest,
   input  wire [C_NUM_SI_SLOTS*C_AXIS_TUSER_WIDTH-1:0]                s_axis_tuser,

   // Master side
   output wire [C_NUM_MI_SLOTS-1:0]                                   m_axis_tvalid,
   input  wire [C_NUM_MI_SLOTS-1:0]                                   m_axis_tready,
   output wire [C_NUM_MI_SLOTS*C_AXIS_TDATA_WIDTH-1:0]                m_axis_tdata,
   output wire [C_NUM_MI_SLOTS*C_AXIS_TDATA_WIDTH/8-1:0]              m_axis_tstrb,
   output wire [C_NUM_MI_SLOTS*C_AXIS_TDATA_WIDTH/8-1:0]              m_axis_tkeep,
   output wire [C_NUM_MI_SLOTS-1:0]                                   m_axis_tlast,
   output wire [C_NUM_MI_SLOTS*C_AXIS_TID_WIDTH-1:0]                  m_axis_tid,
   output wire [C_NUM_MI_SLOTS*C_AXIS_TDEST_WIDTH-1:0]                m_axis_tdest,
   output wire [C_NUM_MI_SLOTS*C_AXIS_TUSER_WIDTH-1:0]                m_axis_tuser ,
   
   // Arbiter interface
   output wire [C_NUM_MI_SLOTS*C_NUM_SI_SLOTS-1:0]                    arb_req,
   output wire [C_NUM_MI_SLOTS-1:0]                                   arb_done,
   input  wire [C_NUM_MI_SLOTS*C_NUM_SI_SLOTS-1:0]                    arb_gnt,
   input  wire [C_NUM_MI_SLOTS*C_LOG_SI_SLOTS-1:0]                    arb_sel,
   output wire [C_NUM_MI_SLOTS*C_NUM_SI_SLOTS-1:0]                    arb_last,
   output wire [C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TID_WIDTH-1:0]   arb_id,
   output wire [C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TDEST_WIDTH-1:0] arb_dest,
   output wire [C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TUSER_WIDTH-1:0] arb_user,
   input wire  [C_NUM_SI_SLOTS-1:0]                                   s_req_suppress,

   // Err output
   output wire [C_NUM_SI_SLOTS-1:0]                                   s_decode_err
   );

////////////////////////////////////////////////////////////////////////////////
// Functions
////////////////////////////////////////////////////////////////////////////////
function [C_NUM_MI_SLOTS*C_NUM_SI_SLOTS-1:0] f_transform_mxn_to_nxm (
  input integer                                    m_width,
  input integer                                    n_width,
  input [C_NUM_SI_SLOTS*C_NUM_MI_SLOTS-1:0] x
);
begin : main
  integer i;
  integer j;
  for (j = 0; j < n_width; j = j+1) begin
    for (i = 0; i < m_width; i = i+1) begin
      f_transform_mxn_to_nxm[j*m_width+i] = x[j+n_width*i];
    end
  end
end
endfunction

function [C_NUM_MI_SLOTS-1:0] f_calc_single_slave_connectivity_array (
  input integer                                    num_masters,
  input [C_NUM_SI_SLOTS*C_NUM_MI_SLOTS-1:0] x
);
begin : main
  integer i;
  integer j;
  for (j = 0; j < num_masters; j = j+1) begin
    f_calc_single_slave_connectivity_array[j] = (x[j*C_NUM_SI_SLOTS+:C_NUM_SI_SLOTS] & (x[j*C_NUM_SI_SLOTS+:C_NUM_SI_SLOTS]-1)) ? 1'b0 : 1'b1;
  end
end
endfunction

`include "axis_infrastructure_v1_1_axis_infrastructure.vh"


////////////////////////////////////////////////////////////////////////////////
// Local parameters
////////////////////////////////////////////////////////////////////////////////
localparam P_DECODER_CONNECTIVITY_ARRAY = f_transform_mxn_to_nxm(C_NUM_MI_SLOTS, C_NUM_SI_SLOTS,C_M_AXIS_CONNECTIVITY_ARRAY);
localparam P_TPAYLOAD_WIDTH = f_payload_width(C_AXIS_TDATA_WIDTH, C_AXIS_TID_WIDTH, C_AXIS_TDEST_WIDTH, 
                                              C_AXIS_TUSER_WIDTH, C_AXIS_SIGNAL_SET);
localparam [C_NUM_MI_SLOTS-1:0] P_SINGLE_SLAVE_CONNECTIVITY_ARRAY = f_calc_single_slave_connectivity_array(C_NUM_MI_SLOTS, C_M_AXIS_CONNECTIVITY_ARRAY);

////////////////////////////////////////////////////////////////////////////////
// Wires/Reg declarations
////////////////////////////////////////////////////////////////////////////////
reg areset_r;

wire [C_NUM_SI_SLOTS*P_TPAYLOAD_WIDTH-1:0]     s_axis_tpayload;

// Wires between arbiter/decoder/transfer_mux
wire [ C_NUM_SI_SLOTS*C_NUM_MI_SLOTS-1:0                    ] dec_tvalid;
wire [ C_NUM_SI_SLOTS*C_NUM_MI_SLOTS-1:0                    ] dec_tready;
wire [ C_NUM_SI_SLOTS*P_TPAYLOAD_WIDTH-1:0                  ] dec_tpayload;
wire [ C_NUM_SI_SLOTS*1-1:0                                 ] dec_tlast;
wire [ C_NUM_SI_SLOTS*C_AXIS_TID_WIDTH-1:0                  ] dec_tid;
wire [ C_NUM_SI_SLOTS*C_AXIS_TDEST_WIDTH-1:0                ] dec_tdest;
wire [ C_NUM_SI_SLOTS*C_AXIS_TUSER_WIDTH-1:0                ] dec_tuser;
wire [ C_NUM_SI_SLOTS*C_NUM_MI_SLOTS-1:0                    ] dec_arb_gnt;
wire [ C_NUM_SI_SLOTS*C_NUM_MI_SLOTS-1:0                    ] dec_arb_req;
wire [ C_NUM_SI_SLOTS*C_NUM_MI_SLOTS-1:0                    ] dec_arb_done;
wire [ C_NUM_SI_SLOTS*C_NUM_MI_SLOTS-1:0                    ] dec_arb_active;

wire [ C_NUM_MI_SLOTS*C_NUM_SI_SLOTS-1:0                    ] mux_tvalid;
wire [ C_NUM_MI_SLOTS*C_NUM_SI_SLOTS-1:0                    ] mux_tready;
wire [ C_NUM_MI_SLOTS*C_AXIS_TDATA_WIDTH-1:0                ] mux_tdata;
wire [ C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*P_TPAYLOAD_WIDTH-1:0   ] mux_tpayload;
wire [ C_NUM_MI_SLOTS*C_NUM_SI_SLOTS-1:0                    ] arb_req_i;
wire [ C_NUM_MI_SLOTS-1:0                                   ] arb_done_i;
wire [ C_NUM_MI_SLOTS*C_NUM_SI_SLOTS-1:0                    ] arb_gnt_i;
wire [ C_NUM_MI_SLOTS*C_LOG_SI_SLOTS-1:0                    ] arb_sel_i;
wire [ C_NUM_MI_SLOTS*C_NUM_SI_SLOTS-1:0                    ] arb_last_i;
wire [ C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TID_WIDTH-1:0   ] arb_id_i;
wire [ C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TDEST_WIDTH-1:0 ] arb_dest_i;
wire [ C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TUSER_WIDTH-1:0 ] arb_user_i;
wire [ C_NUM_MI_SLOTS*P_TPAYLOAD_WIDTH-1:0                  ] tmo_tpayload;
        

////////////////////////////////////////////////////////////////////////////////
// BEGIN RTL
////////////////////////////////////////////////////////////////////////////////
always @(posedge aclk) begin 
  areset_r <= ~aresetn;
end

generate
  genvar si;
  genvar mi;
  for (si = 0; si < C_NUM_SI_SLOTS; si = si + 1) begin : gen_decoder
    axis_infrastructure_v1_1_util_axis2vector #(
      .C_TDATA_WIDTH    ( C_AXIS_TDATA_WIDTH ) ,
      .C_TID_WIDTH      ( C_AXIS_TID_WIDTH   ) ,
      .C_TDEST_WIDTH    ( C_AXIS_TDEST_WIDTH ) ,
      .C_TUSER_WIDTH    ( C_AXIS_TUSER_WIDTH ) ,
      .C_TPAYLOAD_WIDTH ( P_TPAYLOAD_WIDTH   ) ,
      .C_SIGNAL_SET     ( C_AXIS_SIGNAL_SET  ) 
    )
    util_axis2vector_0 (
      .TDATA    ( s_axis_tdata    [ si*C_AXIS_TDATA_WIDTH   +: C_AXIS_TDATA_WIDTH   ] ) ,
      .TSTRB    ( s_axis_tstrb    [ si*C_AXIS_TDATA_WIDTH/8 +: C_AXIS_TDATA_WIDTH/8 ] ) ,
      .TKEEP    ( s_axis_tkeep    [ si*C_AXIS_TDATA_WIDTH/8 +: C_AXIS_TDATA_WIDTH/8 ] ) ,
      .TLAST    ( s_axis_tlast    [ si                      +: 1                    ] ) ,
      .TID      ( s_axis_tid      [ si*C_AXIS_TID_WIDTH     +: C_AXIS_TID_WIDTH     ] ) ,
      .TDEST    ( s_axis_tdest    [ si*C_AXIS_TDEST_WIDTH   +: C_AXIS_TDEST_WIDTH   ] ) ,
      .TUSER    ( s_axis_tuser    [ si*C_AXIS_TUSER_WIDTH   +: C_AXIS_TUSER_WIDTH   ] ) ,
      .TPAYLOAD ( s_axis_tpayload [ si*P_TPAYLOAD_WIDTH     +: P_TPAYLOAD_WIDTH     ] ) 
    );

    axis_switch_v1_1_axisc_decoder #(
      .C_FAMILY           ( C_FAMILY                                                        ) ,
      .C_AXIS_TDATA_WIDTH ( C_AXIS_TDATA_WIDTH                                              ) ,
      .C_AXIS_TID_WIDTH   ( C_AXIS_TID_WIDTH                                                ) ,
      .C_AXIS_TDEST_WIDTH ( C_AXIS_TDEST_WIDTH                                              ) ,
      .C_AXIS_TUSER_WIDTH ( C_AXIS_TUSER_WIDTH                                              ) ,
      .C_AXIS_SIGNAL_SET  ( C_AXIS_SIGNAL_SET                                               ) ,
      .C_TPAYLOAD_WIDTH   ( P_TPAYLOAD_WIDTH                                                ) ,
      .C_NUM_MI_SLOTS     ( C_NUM_MI_SLOTS                                                  ) ,
      .C_DECODER_REG      ( C_DECODER_REG                                                   ) ,
      .C_CONNECTIVITY     ( P_DECODER_CONNECTIVITY_ARRAY[si*C_NUM_MI_SLOTS+:C_NUM_MI_SLOTS] ) ,
      .C_BASETDEST        ( C_M_AXIS_BASETDEST_ARRAY[0+:C_NUM_MI_SLOTS*C_AXIS_TDEST_WIDTH]  ) ,
      .C_HIGHTDEST        ( C_M_AXIS_HIGHTDEST_ARRAY[0+:C_NUM_MI_SLOTS*C_AXIS_TDEST_WIDTH]  ) 
    )
    axisc_decoder_0
    (
      .ACLK            ( aclk                                                            ) ,
      .ACLKEN          ( aclken                                                          ) ,
      .ARESET          ( areset_r                                                        ) ,
      .S_AXIS_TVALID   ( s_axis_tvalid   [ si                    +: 1                  ] ) ,
      .S_AXIS_TREADY   ( s_axis_tready   [ si                    +: 1                  ] ) ,
      .S_AXIS_TPAYLOAD ( s_axis_tpayload [ si*P_TPAYLOAD_WIDTH   +: P_TPAYLOAD_WIDTH   ] ) ,
      .S_AXIS_TDEST    ( s_axis_tdest    [ si*C_AXIS_TDEST_WIDTH +: C_AXIS_TDEST_WIDTH ] ) ,
      .M_AXIS_TVALID   ( dec_tvalid      [ si*C_NUM_MI_SLOTS     +: C_NUM_MI_SLOTS     ] ) ,
      .M_AXIS_TREADY   ( dec_tready      [ si*C_NUM_MI_SLOTS     +: C_NUM_MI_SLOTS     ] ) ,
      .M_AXIS_TPAYLOAD ( dec_tpayload    [ si*P_TPAYLOAD_WIDTH   +: P_TPAYLOAD_WIDTH   ] ) ,
      .ARB_LAST        ( dec_tlast       [ si                    +: 1                  ] ) ,
      .ARB_ID          ( dec_tid         [ si*C_AXIS_TID_WIDTH   +: C_AXIS_TID_WIDTH   ] ) ,
      .ARB_DEST        ( dec_tdest       [ si*C_AXIS_TDEST_WIDTH +: C_AXIS_TDEST_WIDTH ] ) ,
      .ARB_USER        ( dec_tuser       [ si*C_AXIS_TUSER_WIDTH +: C_AXIS_TUSER_WIDTH ] ) ,
      .ARB_REQ         ( dec_arb_req     [ si*C_NUM_MI_SLOTS     +: C_NUM_MI_SLOTS     ] ) ,
      .ARB_GNT         ( dec_arb_gnt     [ si*C_NUM_MI_SLOTS     +: C_NUM_MI_SLOTS     ] ) ,
      .ARB_DONE        ( dec_arb_done    [ si*C_NUM_MI_SLOTS     +: C_NUM_MI_SLOTS     ] ) ,
      .ARB_ACTIVE      ( dec_arb_active  [ si*C_NUM_MI_SLOTS     +: C_NUM_MI_SLOTS     ] ) ,
      .DECODE_ERR      ( s_decode_err    [ si                    +: 1                  ] )
    );
  end
  // These loops transform the output of the SI Decoders signals to arrange them into ARB
  // interface order
  for (mi = 0; mi < C_NUM_MI_SLOTS; mi = mi + 1) begin : gen_si2mi_master_transform
    for (si = 0; si < C_NUM_SI_SLOTS; si = si + 1) begin : gen_si2mi_slave_transform
      // These signals map 1:N from 1 per SI to multiple MI
      assign mux_tvalid   [ (mi*C_NUM_SI_SLOTS+si)                                        ] = dec_tvalid   [ si*C_NUM_MI_SLOTS+mi                      ] ;
      assign mux_tpayload [ (mi*C_NUM_SI_SLOTS+si)*P_TPAYLOAD_WIDTH+:P_TPAYLOAD_WIDTH     ] = dec_tpayload [ si*P_TPAYLOAD_WIDTH+:P_TPAYLOAD_WIDTH     ] ;
      assign arb_last_i   [ (mi*C_NUM_SI_SLOTS+si)                                        ] = dec_tlast    [ si                                        ] ;
      assign arb_id_i     [ (mi*C_NUM_SI_SLOTS+si)*C_AXIS_TID_WIDTH+:C_AXIS_TID_WIDTH     ] = dec_tid      [ si*C_AXIS_TID_WIDTH+:C_AXIS_TID_WIDTH     ] ;
      assign arb_dest_i   [ (mi*C_NUM_SI_SLOTS+si)*C_AXIS_TDEST_WIDTH+:C_AXIS_TDEST_WIDTH ] = dec_tdest    [ si*C_AXIS_TDEST_WIDTH+:C_AXIS_TDEST_WIDTH ] ;
      assign arb_user_i   [ (mi*C_NUM_SI_SLOTS+si)*C_AXIS_TUSER_WIDTH+:C_AXIS_TUSER_WIDTH ] = dec_tuser    [ si*C_AXIS_TUSER_WIDTH+:C_AXIS_TUSER_WIDTH ] ;
      // These signals map 1:1 from multiple per SI to multiple per MI
      assign arb_req_i    [ (mi*C_NUM_SI_SLOTS+si)                                        ] = dec_arb_req  [ si*C_NUM_MI_SLOTS+mi                   ] & ~s_req_suppress[si];
    end
  end
  // These loops transform the input to the Decoders signals to arrange them into 
  // slave interface order
  for (si = 0; si < C_NUM_SI_SLOTS; si = si + 1) begin : gen_mi2si_slave_transform
    for (mi = 0; mi < C_NUM_MI_SLOTS; mi = mi + 1) begin : gen_mi2si_master_transform
      assign dec_tready [ si*C_NUM_MI_SLOTS+mi ] = mux_tready[ mi*C_NUM_SI_SLOTS+si ];
      assign dec_arb_gnt[ si*C_NUM_MI_SLOTS+mi ] = arb_gnt_i [ mi*C_NUM_SI_SLOTS+si ];
      assign dec_arb_done[si*C_NUM_MI_SLOTS+mi ] = arb_done_i [ mi ];
    end
  end
  for (mi = 0; mi < C_NUM_MI_SLOTS; mi = mi + 1) begin : gen_transfer_mux
    axis_switch_v1_1_axisc_transfer_mux #(
      .C_FAMILY           ( C_FAMILY                                                ) ,
      .C_TPAYLOAD_WIDTH   ( P_TPAYLOAD_WIDTH                                        ) ,
      .C_AXIS_TDATA_WIDTH ( C_AXIS_TDATA_WIDTH                                      ) ,
      .C_AXIS_TID_WIDTH   ( C_AXIS_TID_WIDTH                                        ) ,
      .C_AXIS_TDEST_WIDTH ( C_AXIS_TDEST_WIDTH                                      ) ,
      .C_AXIS_TUSER_WIDTH ( C_AXIS_TUSER_WIDTH                                      ) ,
      .C_AXIS_SIGNAL_SET  ( C_AXIS_SIGNAL_SET                                       ) ,
      .C_ARB_ON_TLAST     ( C_ARB_ON_TLAST                                          ) ,
      .C_ARB_ON_MAX_XFERS ( C_ARB_ON_MAX_XFERS                                      ) ,
      .C_ARB_ON_NUM_CYCLES( C_ARB_ON_NUM_CYCLES                                     ) ,
      .C_NUM_SI_SLOTS     ( C_NUM_SI_SLOTS                                          ) ,
      .C_LOG_SI_SLOTS     ( C_LOG_SI_SLOTS                                          ) ,
      .C_OUTPUT_REG       ( C_OUTPUT_REG                                            ) ,
      .C_CONNECTIVITY     ( C_M_AXIS_CONNECTIVITY_ARRAY[mi*C_NUM_SI_SLOTS+:C_NUM_SI_SLOTS] ) ,
      .C_SINGLE_SLAVE_CONNECTIVITY ( P_SINGLE_SLAVE_CONNECTIVITY_ARRAY[mi] )
    )
    axisc_transfer_mux_0
    (
      .ACLK            ( aclk                                                                               ) ,
      .ACLKEN          ( aclken                                                                             ) ,
      .ARESET          ( areset_r                                                                           ) ,
      .S_AXIS_TVALID   ( mux_tvalid   [mi*C_NUM_SI_SLOTS+:C_NUM_SI_SLOTS]                                   ) ,
      .S_AXIS_TREADY   ( mux_tready   [mi*C_NUM_SI_SLOTS+:C_NUM_SI_SLOTS]                                   ) ,
      .S_AXIS_TPAYLOAD ( mux_tpayload [mi*C_NUM_SI_SLOTS*P_TPAYLOAD_WIDTH+:C_NUM_SI_SLOTS*P_TPAYLOAD_WIDTH] ) ,
      .M_AXIS_TVALID   ( m_axis_tvalid[mi+:1]                                                               ) ,
      .M_AXIS_TREADY   ( m_axis_tready[mi+:1]                                                               ) ,
      .M_AXIS_TPAYLOAD ( tmo_tpayload [mi*P_TPAYLOAD_WIDTH+:P_TPAYLOAD_WIDTH]                               ) ,
      .ARB_GNT         ( arb_gnt_i    [mi*C_NUM_SI_SLOTS+:C_NUM_SI_SLOTS]                                   ) ,
      .ARB_DONE        ( arb_done_i   [mi+:1]                                                               ) ,
      .ARB_SEL         ( arb_sel_i    [mi*C_LOG_SI_SLOTS+:C_LOG_SI_SLOTS]                                   ) 
    );

    axis_infrastructure_v1_1_util_vector2axis #(
      .C_TDATA_WIDTH    ( C_AXIS_TDATA_WIDTH ) ,
      .C_TID_WIDTH      ( C_AXIS_TID_WIDTH   ) ,
      .C_TDEST_WIDTH    ( C_AXIS_TDEST_WIDTH ) ,
      .C_TUSER_WIDTH    ( C_AXIS_TUSER_WIDTH ) ,
      .C_TPAYLOAD_WIDTH ( P_TPAYLOAD_WIDTH   ) ,
      .C_SIGNAL_SET     ( C_AXIS_SIGNAL_SET  ) 
    )
    util_vector2axis_0 (
      .TPAYLOAD ( tmo_tpayload[mi*P_TPAYLOAD_WIDTH+:P_TPAYLOAD_WIDTH]         ) ,
      .TDATA    ( m_axis_tdata[mi*C_AXIS_TDATA_WIDTH+:C_AXIS_TDATA_WIDTH]     ) ,
      .TSTRB    ( m_axis_tstrb[mi*C_AXIS_TDATA_WIDTH/8+:C_AXIS_TDATA_WIDTH/8] ) ,
      .TKEEP    ( m_axis_tkeep[mi*C_AXIS_TDATA_WIDTH/8+:C_AXIS_TDATA_WIDTH/8] ) ,
      .TLAST    ( m_axis_tlast[mi+:1]                                         ) ,
      .TID      ( m_axis_tid  [mi*C_AXIS_TID_WIDTH+:C_AXIS_TID_WIDTH]         ) ,
      .TDEST    ( m_axis_tdest[mi*C_AXIS_TDEST_WIDTH+:C_AXIS_TDEST_WIDTH]     ) ,
      .TUSER    ( m_axis_tuser[mi*C_AXIS_TUSER_WIDTH+:C_AXIS_TUSER_WIDTH]     ) 
    );
  end
  if (C_INCLUDE_ARBITER) begin : gen_int_arbiter
    if (C_NUM_SI_SLOTS > 1) begin : gen_arbiter
      axis_switch_v1_1_axis_switch_arbiter #(
        .C_FAMILY        ( C_FAMILY            ) ,
        .C_NUM_SI_SLOTS  ( C_NUM_SI_SLOTS      ) ,
        .C_LOG_SI_SLOTS  ( C_LOG_SI_SLOTS      ) ,
        .C_NUM_MI_SLOTS  ( C_NUM_MI_SLOTS      ) ,
        .C_ARB_ALGORITHM ( C_ARB_ALGORITHM     ) ,
        .C_SINGLE_SLAVE_CONNECTIVITY_ARRAY ( P_SINGLE_SLAVE_CONNECTIVITY_ARRAY )
      )
      axis_switch_v1_1_axis_switch_arbiter (
        .ACLK     ( aclk       ) ,
        .ARESETN  ( aresetn    ) ,
        .ACLKEN   ( aclken     ) ,
        .ARB_REQ  ( arb_req_i  ) ,
        .ARB_DONE ( arb_done_i ) ,
        .ARB_SEL  ( arb_sel_i  ) ,
        .ARB_GNT  ( arb_gnt_i  ) 
      );
      assign arb_req  = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS{1'b0}};
      assign arb_done = {C_NUM_MI_SLOTS{1'b0}};
      assign arb_last = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS{1'b0}};
      assign arb_id   = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TID_WIDTH{1'b0}};
      assign arb_dest = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TDEST_WIDTH{1'b0}};
      assign arb_user = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TUSER_WIDTH{1'b0}};

    end else begin : gen_all_arb_tieoffs
      assign arb_gnt_i = arb_req_i;
      assign arb_sel_i = {C_NUM_MI_SLOTS{1'b0}};
      assign arb_req = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS{1'b0}};
      assign arb_done = {C_NUM_MI_SLOTS{1'b0}};
      assign arb_last = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS{1'b0}};
      assign arb_id   = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TID_WIDTH{1'b0}};
      assign arb_dest   = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TDEST_WIDTH{1'b0}};
      assign arb_user   = {C_NUM_MI_SLOTS*C_NUM_SI_SLOTS*C_AXIS_TUSER_WIDTH{1'b0}};
    end
  end else begin : gen_ext_arbiter
    assign arb_req   = arb_req_i;
    assign arb_gnt_i = arb_gnt;
    assign arb_sel_i = arb_sel;
    assign arb_done  = arb_done_i;
    assign arb_last  = arb_last_i;
    assign arb_id    = arb_id_i;
    assign arb_dest  = arb_dest_i;
    assign arb_user  = arb_user_i;
  end


endgenerate

endmodule // axis_switch

`default_nettype wire
