//------------------------------------------------------------------------------
// File       : gig_ethernet_pcs_pma_0_resets.v
// Author     : Xilinx Inc.
//------------------------------------------------------------------------------
// (c) Copyright 2011 Xilinx, Inc. All rights reserved.
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
// 
//------------------------------------------------------------------------------
// Description: This module holds the resets for the PCS/PMA core


`timescale 1 ps/1 ps


//------------------------------------------------------------------------------
// The module declaration for the example design
//------------------------------------------------------------------------------

module gig_ethernet_pcs_pma_0_resets
   (
    input        reset,                    // Asynchronous reset for entire core.
    input        independent_clock_bufg,   // System clock

    input        mmcm_locked,
    output       mmcm_reset,               // MMCM Reset
    output       pma_reset                 // Synchronous transcevier PMA reset
   );

   (* ASYNC_REG = "TRUE" *)
   reg   [3:0]  pma_reset_pipe;           // flip-flop pipeline for reset duration stretch
   wire         reset_mmcm_locked; 

   assign mmcm_reset = reset;
   

   //---------------------------------------------------------------------------
   // Transceiver PMA reset circuitry
   //---------------------------------------------------------------------------

   assign reset_mmcm_locked = reset || !mmcm_locked;
   always@(posedge independent_clock_bufg or posedge reset_mmcm_locked)
      if (reset_mmcm_locked == 1'b1)
         pma_reset_pipe <= 4'b1111;
      else
         pma_reset_pipe <= {pma_reset_pipe[2:0], reset};

   assign pma_reset = pma_reset_pipe[3] ;

endmodule // gig_ethernet_pcs_pma_0_resets
