///////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2008 Xilinx, Inc. All rights reserved.
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
///////////////////////////////////////////////////////////////////////////////
//
//  IDLE_AND_VER_GEN
//
//
//  Description: the IDLE_AND_VER_GEN module generates idle sequences and
//               verification sequences for the Aurora channel.  The idle sequences
//               are constantly generated by a pseudorandom generator and a counter
//               to make the sequence Aurora compliant.  If the gen_ver signal is high,
//               verification symbols are added to the mix at appropriate intervals
//
//               This module supports 1 2-byte lane designs
//

`timescale 1 ns / 1 ps

module aurora_8b10b_0_IDLE_AND_VER_GEN
(
    //Channel Init SM Interface
    GEN_VER,

    DID_VER,


    //Aurora Lane Interface
    GEN_A,
    GEN_K,
    GEN_R,
    GEN_V,


    //System Interface
    RESET,
    USER_CLK
);

`define DLY #1


//***********************************Port Declarations*******************************


    //Channel Init SM Interface
    input              GEN_VER;

    output             DID_VER;


    //Aurora Lane Interface
output             GEN_A;
    output  [0:1]      GEN_K;
    output  [0:1]      GEN_R;
    output  [0:1]      GEN_V;


    //System Interface
    input              RESET;
    input              USER_CLK;


//********************************Internal Register Declarations**********************
    reg     [0:3]      lfsr_shift_register_r;
    reg     [0:3]      downcounter_r;
    reg                gen_ver_word_2_r;
    reg                prev_cycle_gen_ver_r;

//*********************************Wire Declarations**********************************
    wire               lfsr_last_flop_r;
    wire               lfsr_taps_c;
    wire               lfsr_taps_r;
    wire    [0:2]      lfsr_r;
    wire    [0:1]      gen_k_r;
    wire    [0:1]      gen_r_r;
    wire    [0:1]      ver_counter_r;
    wire               gen_ver_word_1_r;
    wire    [0:1]      gen_k_flop_c;
    wire    [0:1]      gen_r_flop_c;
    wire    [0:1]      gen_v_flop_c;
    wire               gen_a_flop_c;
    wire               downcounter_done_c;
    wire               gen_ver_edge_c;
    wire               recycle_gen_ver_c;
    wire               insert_ver_c;

//*********************************Main Body of Code**********************************


    //____________________________Random Pattern Generation_________________________


    // Use an LFSR to create pseudorandom patterns.  This is a 6 bit LFSR based
    // on XAPP210.  Taps on bits 5 and 6 are XNORed to make the input of the
    // register.  The lfsr must never be initialized to 1.  The entire structure
    // should cost a maximum of 2 LUTS and 2 Flops.  The output of the input
    // register and each of the tap registers is passed to the rest of the logic
    // as the LFSR output.

    initial lfsr_shift_register_r = 4'h0;

    always @(posedge USER_CLK)
        lfsr_shift_register_r   <=  `DLY    {lfsr_taps_r,lfsr_shift_register_r[0:2]};


    FDR #(.INIT(1'b0)) lfsr_last_flop_i
    (
        .Q (lfsr_last_flop_r),
        .C (USER_CLK),
        .D (lfsr_shift_register_r[3]),
        .R (RESET)
    );

    assign lfsr_taps_c = !(lfsr_shift_register_r[3] ^ lfsr_last_flop_r);

    FDR #(.INIT(1'b0)) lfsr_taps_i
    (
        .Q (lfsr_taps_r),
        .C (USER_CLK),
        .D (lfsr_taps_c),
        .R (RESET)
    );

    assign lfsr_r = {lfsr_taps_r,lfsr_shift_register_r[3],lfsr_last_flop_r};


    // Use a downcounter to determine when A's should be added to the idle pattern.
    // Load the 3 least significant bits with the output of the lfsr whenever the
    // counter reaches 0.

    initial
        downcounter_r = 4'h1;

    always @ (posedge USER_CLK)
        if(RESET)                       downcounter_r   <= `DLY   4'h0;
        else if (downcounter_done_c)    downcounter_r   <= `DLY   {1'b1,lfsr_r};
        else                            downcounter_r   <= `DLY   downcounter_r - 4'd1;

    assign downcounter_done_c = (downcounter_r == 4'd0);


    // The LFSR's pseudoRandom patterns are also used to generate the sequence of
    // K and R characters that make up the rest of the idle sequence.  Note that
    // R characters are used whenever a K character is not used.

    assign gen_k_r =  lfsr_r[0:1];
    assign gen_r_r = ~lfsr_r[0:1];

    //_____________________Verification Sequence Generation________________________

    // Use a counter to generate the verification sequence every 64 bytes
    // (32 clocks), starting from when verification is enabled.

    always @(posedge USER_CLK)
        prev_cycle_gen_ver_r <= `DLY GEN_VER;


    // Detect the positive edge of the GEN_VER signal.

    assign gen_ver_edge_c = GEN_VER & !prev_cycle_gen_ver_r;


    // If GEN_VER is still high after generating a verification sequence,
    // indicate that the gen_ver signal can be generated again.

    assign recycle_gen_ver_c = gen_ver_word_2_r & GEN_VER;


    // Prime the verification counter SRL16 with a 1.  When this 1 reaches the end
    // of the register, it will become the gen_ver_word signal.  Prime the counter
    // only if there was a positive edge on GEN_VER to start the sequence, or if
    // the sequence has just ended and another must be generated.

    assign insert_ver_c = gen_ver_edge_c | recycle_gen_ver_c;


    // Main Body of the verification counter.  It is implemented as a shift register
    // made from 2 SRL16s.  The register is 31 cycles long, and operates by
    // taking the 1 from the insert ver signal and passing it though its stages.

    SRL16 #(.INIT(16'h0000)) ver_counter_0_i
    (
        .Q(ver_counter_r[0]),
        .A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CLK(USER_CLK),
        .D(insert_ver_c)
    );

    SRL16 #(.INIT(16'h0000)) ver_counter_1_i
    (
        .Q(ver_counter_r[1]),
        .A0(1'b0),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CLK(USER_CLK),
        .D(ver_counter_r[0])
    );


    // Generate the first 2 bytes of the verification sequence when the verification
    // counter reaches '31'.

    assign gen_ver_word_1_r = ver_counter_r[1];


    // Generate the second 2 bytes of the verification sequence on the cycle after
    // the first verification sequence.

    always @(posedge USER_CLK)
        gen_ver_word_2_r <= `DLY gen_ver_word_1_r;

    //_________________________________Output Signals_____________________________

    // Signal that the verification sequence has been generated.  Signaling off of
    // the second byte allows the counter to be primed for one count too many, but
    // is neccessary to allow GEN_V to be used as a qualifier for the output.  The
    // extra gen_ver_word_1_r and gen_ver_word_2_r assertion is ok, because GEN_VER
    // will be low when they are asserted.

    assign  DID_VER   =   gen_ver_word_2_r;

    // Assert GEN_V in the MSByte of each lane when gen_ver_word_2_r is asserted.
    // Assert GEN_V in the LSByte of each lane if either gen_ver_word signal is
    // asserted.  We use a seperate register for each output to provide enough slack
    // to allow the Global logic to communicate with all lanes without causing
    // timing problems.

    assign  gen_v_flop_c[0]    =   GEN_VER & gen_ver_word_2_r;

    FD #(.INIT(1'b0)) gen_v_flop_0_i
    (
        .D(gen_v_flop_c[0]),
        .C(USER_CLK),
        .Q(GEN_V[0])
    );


    assign  gen_v_flop_c[1]    =   GEN_VER & (gen_ver_word_1_r |gen_ver_word_2_r);

    FD #(.INIT(1'b0)) gen_v_flop_1_i
    (
        .D(gen_v_flop_c[1]),
        .C(USER_CLK),
        .Q(GEN_V[1])
    );


    // Assert GEN_A in the MSByte of each lane when the GEN_A downcounter reaches 0.
    // Note that the signal has a register for each lane for the same reason as the
    // GEN_V signal.  GEN_A is ignored when it collides with other non-idle
    // generation requests at the Aurora Lane, but we qualify the signal with
    // the gen_ver_word_1_r signal so it does not overwrite the K used in the
    // MSByte of the first word of the Verification sequence.

    assign  gen_a_flop_c    =   downcounter_done_c & !gen_ver_word_1_r;

    FD #(.INIT(1'b0)) gen_a_flop_0_i
    (
        .D(gen_a_flop_c),
        .C(USER_CLK),
        .Q(GEN_A)
    );


    // Assert GEN_K in the MSByte when the lfsr dictates. Turn off the assertion if an
    // A symbol is being generated on the byte.  Assert the signal without qualifications
    // if gen_ver_word_1_r is asserted.  Assert GEN_K in the LSByte when the lfsr dictates.
    // There are no qualifications because only the GEN_R signal can collide with it, and
    // this is prevented by the way the gen_k_r signal is generated.  All other GEN signals
    // will override this signal at the AURORA_LANE.

    assign  gen_k_flop_c[0]    =  (gen_k_r[0] & !downcounter_done_c)|gen_ver_word_1_r;

    FD #(.INIT(1'b0)) gen_k_flop_0_i
    (
        .D(gen_k_flop_c[0]),
        .C(USER_CLK),
        .Q(GEN_K[0])
    );

    assign  gen_k_flop_c[1]    =  gen_k_r[1];

    FD #(.INIT(1'b0)) gen_k_flop_1_i
    (
        .D(gen_k_flop_c[1]),
        .C(USER_CLK),
        .Q(GEN_K[1])
    );


    // Assert GEN_R in the MSByte when the lfsr dictates.  Turn off the assertion if an
    // A symbol, or the first verification word is being generated.  Assert GEN_R in the
    // LSByte when the lfsr dictates, with no qualifications (same reason as the GEN_K LSByte).

    assign  gen_r_flop_c[0]    =   gen_r_r[0] & !downcounter_done_c & !gen_ver_word_1_r;

    FD #(.INIT(1'b0)) gen_r_flop_0_i
    (
        .D(gen_r_flop_c[0]),
        .C(USER_CLK),
        .Q(GEN_R[0])
    );

    assign  gen_r_flop_c[1]    =   gen_r_r[1];

    FD #(.INIT(1'b0)) gen_r_flop_1_i
    (
        .D(gen_r_flop_c[1]),
        .C(USER_CLK),
        .Q(GEN_R[1])
    );

endmodule
