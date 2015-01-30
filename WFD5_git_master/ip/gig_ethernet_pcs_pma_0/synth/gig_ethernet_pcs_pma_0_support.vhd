--------------------------------------------------------------------------------
-- File       : gig_ethernet_pcs_pma_0_support.vhd
-- Author     : Xilinx Inc.
--------------------------------------------------------------------------------
-- (c) Copyright 2011 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES. 
-- 
-- 
--------------------------------------------------------------------------------
-- Description: This module holds the support level for the pcs/pma core
--              This can be used as-is in a single core design, or adapted
--              for use with multi-core implementations
--
--
--
library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


--------------------------------------------------------------------------------
-- The Entity declaration for the Core Block wrapper.
--------------------------------------------------------------------------------

entity gig_ethernet_pcs_pma_0_support is
   port (

      gtrefclk_p               : in  std_logic;                           -- 125 MHz differential clock
      gtrefclk_n               : in  std_logic;                           -- 125 MHz differential clock


      gtrefclk_out             : out std_logic;                           -- Very high quality 125MHz clock for GT transceiver.
      txp                  : out std_logic;                    -- Differential +ve of serial transmission from PMA to PMD.
      txn                  : out std_logic;                    -- Differential -ve of serial transmission from PMA to PMD.
      rxp                  : in std_logic;                     -- Differential +ve for serial reception from PMD to PMA.
      rxn                  : in std_logic;                     -- Differential -ve for serial reception from PMD to PMA.
      userclk_out              : out std_logic;                           -- 125MHz global clock.
      userclk2_out             : out std_logic;                           -- 125MHz global clock.
      rxuserclk_out              : out std_logic;                           -- 125MHz global clock.
      rxuserclk2_out             : out std_logic;                           -- 125MHz global clock.
      pma_reset_out            : out std_logic;                           -- transceiver PMA reset signal
      mmcm_locked_out          : out std_logic;                           -- MMCM Locked
      resetdone                : out std_logic;

      independent_clock_bufg : in std_logic;                   -- 200MHz independent cloc,

      -- GMII Interface
      -----------------
      gmii_txd             : in std_logic_vector(7 downto 0);  -- Transmit data from client MAC.
      gmii_tx_en           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_tx_er           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_rxd             : out std_logic_vector(7 downto 0); -- Received Data to client MAC.
      gmii_rx_dv           : out std_logic;                    -- Received control signal to client MAC.
      gmii_rx_er           : out std_logic;                    -- Received control signal to client MAC.
      gmii_isolate         : out std_logic;                    -- Tristate control to electrically isolate GMII.

      -- Management: Alternative to MDIO Interface
      --------------------------------------------

      configuration_vector : in std_logic_vector(4 downto 0);  -- Alternative to MDIO interface.

      -- General IO's
      ---------------
      status_vector        : out std_logic_vector(15 downto 0); -- Core status.
      reset                : in std_logic;                     -- Asynchronous reset for entire core.

      gt0_drpaddr_in            : in   std_logic_vector(8 downto 0);
      gt0_drpclk_in             : in   std_logic;
      gt0_drpdi_in              : in   std_logic_vector(15 downto 0);
      gt0_drpdo_out             : out  std_logic_vector(15 downto 0);
      gt0_drpen_in              : in   std_logic;
      gt0_drprdy_out            : out  std_logic;
      gt0_drpwe_in              : in   std_logic;
      gt0_txpmareset_in         : in  std_logic;
      gt0_txpcsreset_in         : in  std_logic;
      gt0_rxpmareset_in         : in  std_logic;
      gt0_rxpcsreset_in         : in  std_logic;
      gt0_rxbufreset_in         : in  std_logic;
      gt0_rxpmaresetdone_out    : out std_logic;
      gt0_rxbufstatus_out       : out std_logic_vector(2 downto 0);
      gt0_txbufstatus_out       : out std_logic_vector(1 downto 0);
      gt0_dmonitorout_out       : out std_logic_vector(16 downto 0);
      gt0_rxchariscomma_out     : out std_logic_vector(1 downto 0);
      gt0_rxcharisk_out         : out std_logic_vector(1 downto 0);
      gt0_rxbyteisaligned_out   : out std_logic;
      gt0_rxbyterealign_out     : out std_logic;
      gt0_rxcommadet_out        : out std_logic;
      gt0_txpolarity_in         : in  std_logic;
      gt0_txdiffctrl_in         : in  std_logic_vector(3 downto 0);
      gt0_txpostcursor_in       : in  std_logic_vector(4 downto 0);
      gt0_txprecursor_in        : in  std_logic_vector(4 downto 0);
      gt0_rxpolarity_in         : in  std_logic;
      gt0_rxdfelpmreset_in      : in  std_logic;
      gt0_rxlpmen_in            : in  std_logic;
      gt0_txprbssel_in          : in  std_logic_vector(2 downto 0);
      gt0_txprbsforceerr_in     : in  std_logic;
      gt0_rxprbscntreset_in     : in  std_logic;
      gt0_rxprbserr_out         : out std_logic;
      gt0_rxprbssel_in          : in  std_logic_vector(2 downto 0);
      gt0_loopback_in           : in  std_logic_vector(2 downto 0);
      gt0_txresetdone_out       : out std_logic;
      gt0_rxresetdone_out       : out std_logic;
      gt0_rxdisperr_out         : out std_logic_vector(1 downto 0);
      gt0_rxnotintable_out      : out std_logic_vector(1 downto 0);
      gt0_eyescanreset_in       : in  std_logic;
      gt0_eyescandataerror_out  : out std_logic;
      gt0_eyescantrigger_in     : in  std_logic;
      gt0_rxcdrhold_in          : in  std_logic;
      gt0_rxdfeagcovrden_in     : in  std_logic;
      gt0_rxmonitorout_out      : out std_logic_vector(6 downto 0);
      gt0_rxmonitorsel_in       : in  std_logic_vector(1 downto 0);
      
      
      
      signal_detect        : in std_logic;                      -- Input from PMD to indicate presence of optical input.
      gt0_qplloutclk_out     : out std_logic;
      gt0_qplloutrefclk_out  : out std_logic

   );
end gig_ethernet_pcs_pma_0_support;

architecture wrapper of gig_ethernet_pcs_pma_0_support is

   attribute DowngradeIPIdentifiedWarnings: string;
   attribute DowngradeIPIdentifiedWarnings of wrapper : architecture is "yes";

   component gig_ethernet_pcs_pma_0_block
   port (
      -- Transceiver Interface
      ---------------------

 
      gtrefclk             : in std_logic;                     -- Very high quality 125MHz clock for GT transceiver.
      txp                  : out std_logic;                    -- Differential +ve of serial transmission from PMA to PMD.
      txn                  : out std_logic;                    -- Differential -ve of serial transmission from PMA to PMD.
      rxp                  : in std_logic;                     -- Differential +ve for serial reception from PMD to PMA.
      rxn                  : in std_logic;                     -- Differential -ve for serial reception from PMD to PMA.

      txoutclk             : out std_logic;                    -- txoutclk from GT transceiver (62.5MHz)
      rxoutclk             : out std_logic;                    -- txoutclk from GT transceiver (62.5MHz)
      resetdone            : out std_logic;                    -- The GT transceiver has completed its reset cycle
      cplllock            : out std_logic;                    
      mmcm_locked          : in std_logic;                     -- Locked indication from MMCM
      userclk              : in std_logic;                     -- 62.5MHz global clock.
      userclk2             : in std_logic;                     -- 125MHz global clock.
      rxuserclk              : in std_logic;                     -- 62.5MHz global clock.
      rxuserclk2             : in std_logic;                     -- 125MHz global clock.
      independent_clock_bufg : in std_logic;                   -- 200MHz independent cloc,
      pma_reset            : in std_logic;                     -- transceiver PMA reset signal

      -- GMII Interface
      -----------------
      gmii_txd             : in std_logic_vector(7 downto 0);  -- Transmit data from client MAC.
      gmii_tx_en           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_tx_er           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_rxd             : out std_logic_vector(7 downto 0); -- Received Data to client MAC.
      gmii_rx_dv           : out std_logic;                    -- Received control signal to client MAC.
      gmii_rx_er           : out std_logic;                    -- Received control signal to client MAC.
      gmii_isolate         : out std_logic;                    -- Tristate control to electrically isolate GMII.

      -- Management: Alternative to MDIO Interface
      --------------------------------------------

      configuration_vector : in std_logic_vector(4 downto 0);  -- Alternative to MDIO interface.


      -- General IO's
      ---------------
      status_vector        : out std_logic_vector(15 downto 0); -- Core status.
      reset                : in std_logic;                     -- Asynchronous reset for entire core.
      gt0_drpaddr_in            : in   std_logic_vector(8 downto 0);
      gt0_drpclk_in             : in   std_logic;
      gt0_drpdi_in              : in   std_logic_vector(15 downto 0);
      gt0_drpdo_out             : out  std_logic_vector(15 downto 0);
      gt0_drpen_in              : in   std_logic;
      gt0_drprdy_out            : out  std_logic;
      gt0_drpwe_in              : in   std_logic;
      gt0_txpmareset_in         : in  std_logic;
      gt0_txpcsreset_in         : in  std_logic;
      gt0_rxpmareset_in         : in  std_logic;
      gt0_rxpcsreset_in         : in  std_logic;
      gt0_rxbufreset_in         : in  std_logic;
      gt0_rxpmaresetdone_out    : out std_logic;
      gt0_rxbufstatus_out       : out std_logic_vector(2 downto 0);
      gt0_txbufstatus_out       : out std_logic_vector(1 downto 0);
      gt0_dmonitorout_out       : out std_logic_vector(16 downto 0);
      gt0_rxchariscomma_out     : out std_logic_vector(1 downto 0);
      gt0_rxcharisk_out         : out std_logic_vector(1 downto 0);
      gt0_rxbyteisaligned_out   : out std_logic;
      gt0_rxbyterealign_out     : out std_logic;
      gt0_rxcommadet_out        : out std_logic;
      gt0_txpolarity_in         : in  std_logic;
      gt0_txdiffctrl_in         : in  std_logic_vector(3 downto 0);
      gt0_txpostcursor_in       : in  std_logic_vector(4 downto 0);
      gt0_txprecursor_in        : in  std_logic_vector(4 downto 0);
      gt0_rxpolarity_in         : in  std_logic;
      gt0_rxdfelpmreset_in      : in  std_logic;
      gt0_rxlpmen_in            : in  std_logic;
      gt0_txprbssel_in          : in  std_logic_vector(2 downto 0);
      gt0_txprbsforceerr_in     : in  std_logic;
      gt0_rxprbscntreset_in     : in  std_logic;
      gt0_rxprbserr_out         : out std_logic;
      gt0_rxprbssel_in          : in  std_logic_vector(2 downto 0);
      gt0_loopback_in           : in  std_logic_vector(2 downto 0);
      gt0_txresetdone_out       : out std_logic;
      gt0_rxresetdone_out       : out std_logic;
      gt0_rxdisperr_out         : out std_logic_vector(1 downto 0);
      gt0_rxnotintable_out      : out std_logic_vector(1 downto 0);
      gt0_eyescanreset_in       : in  std_logic;
      gt0_eyescandataerror_out  : out std_logic;
      gt0_eyescantrigger_in     : in  std_logic;
      gt0_rxcdrhold_in          : in  std_logic;
      gt0_rxdfeagcovrden_in     : in  std_logic;
      gt0_rxmonitorout_out      : out std_logic_vector(6 downto 0);
      gt0_rxmonitorsel_in       : in  std_logic_vector(1 downto 0);
      
      signal_detect        : in std_logic;                      -- Input from PMD to indicate presence of optical input.

    gt0_qplloutclk_in                          : in   std_logic;
    gt0_qplloutrefclk_in                       : in   std_logic
   );
end component;


component gig_ethernet_pcs_pma_0_clocking
   port (
      gtrefclk_p              : in  std_logic;                -- Differential +ve of reference clock for MGT: 125MHz, very high quality.
      gtrefclk_n              : in  std_logic;                -- Differential -ve of reference clock for MGT: 125MHz, very high quality.
      txoutclk                : in  std_logic;                -- txoutclk from GT transceiver.
      rxoutclk                : in  std_logic;                -- txoutclk from GT transceiver.
      mmcm_reset              : in  std_logic;                -- MMCM Reset

      gtrefclk                : out std_logic;                -- gtrefclk routed through an IBUFG.
      mmcm_locked             : out std_logic;                -- MMCM locked
      userclk                 : out std_logic;                -- for GT PMA reference clock
      userclk2                : out std_logic;                 -- 125MHz clock for core reference clock.
      rxuserclk                 : out std_logic;                -- for GT PMA reference clock
      rxuserclk2                : out std_logic                 -- 125MHz clock for core reference clock.
   );
end component;

component gig_ethernet_pcs_pma_0_resets
   port (
    reset                    : in  std_logic;                -- Asynchronous reset for entire core.
    independent_clock_bufg   : in  std_logic;                -- System clock 

    mmcm_locked              : in  std_logic;                -- MMCM Reset
    mmcm_reset               : out std_logic;                -- MMCM Reset
    pma_reset                : out std_logic                 -- Synchronous transcevier PMA reset
   );
end component;


component gig_ethernet_pcs_pma_0_gt_common
  port(
    gt0_gtrefclk0_common_in                 : in   std_logic;
    gt0_qplloutclk                              : out  std_logic;
    gt0_qplloutrefclk                           : out  std_logic;
    gt0_qplllock_out                        : out  std_logic;
    gt0_qplllockdetclk_in                   : in   std_logic;
    gt0_qpllrefclklost_out                  : out  std_logic;
    gt0_qpllreset_in                        : in   std_logic
  );
end component;


   -- GT Interface
   ----------------
   SIGNAL gt0_qplloutclk     : std_logic;
   SIGNAL gt0_qplloutrefclk  : std_logic;
   SIGNAL cplllock             : std_logic;
   SIGNAL mmcm_reset            : std_logic;
   SIGNAL txoutclk              : std_logic;
   SIGNAL rxoutclk              : std_logic;
   SIGNAL gtrefclk              : std_logic;
   SIGNAL mmcm_locked           : std_logic;
   SIGNAL userclk               : std_logic;
   SIGNAL userclk2              : std_logic;
   SIGNAL rxuserclk               : std_logic;
   SIGNAL rxuserclk2              : std_logic;
   SIGNAL pma_reset             : std_logic;

begin

   -----------------------------------------------------------------------------
   -- Component Instantiation for the SGMII adaptation module
   -----------------------------------------------------------------------------


   pcs_pma_block_i : gig_ethernet_pcs_pma_0_block
      port map(
      -- Transceiver Interface
      ---------------------

 
      gtrefclk        => gtrefclk,
      txp             => txp  ,           
      txn             => txn  ,           
      rxp             => rxp  ,           
      rxn             => rxn  ,           

      txoutclk            =>  txoutclk    ,        
      rxoutclk            =>  rxoutclk    ,        
      resetdone           =>  resetdone   ,        
      cplllock            =>  cplllock   ,        
      mmcm_locked         =>  mmcm_locked ,        
      userclk             =>  userclk     ,        
      userclk2            =>  userclk2    ,        
      rxuserclk             =>  rxuserclk     ,        
      rxuserclk2            =>  rxuserclk2    ,        
      independent_clock_bufg => independent_clock_bufg,
      pma_reset           =>    pma_reset,

      -- GMII Interface
      -----------------
      gmii_txd           =>  gmii_txd    ,       
      gmii_tx_en         =>  gmii_tx_en  ,       
      gmii_tx_er         =>  gmii_tx_er  ,       
      gmii_rxd           =>  gmii_rxd    ,       
      gmii_rx_dv         =>  gmii_rx_dv  ,       
      gmii_rx_er         =>  gmii_rx_er  ,       
      gmii_isolate       =>  gmii_isolate,       

      -- Management: Alternative to MDIO Interface
      --------------------------------------------

      configuration_vector => configuration_vector,


      -- General IO's
      ---------------
      status_vector    =>  status_vector   ,  
      reset            =>  reset           , 
      gt0_drpaddr_in            => gt0_drpaddr_in,
      gt0_drpclk_in             => gt0_drpclk_in,
      gt0_drpdi_in              => gt0_drpdi_in,
      gt0_drpdo_out             => gt0_drpdo_out,
      gt0_drpen_in              => gt0_drpen_in,
      gt0_drprdy_out            => gt0_drprdy_out,
      gt0_drpwe_in              => gt0_drpwe_in,
      gt0_txpmareset_in         => gt0_txpmareset_in,
      gt0_txpcsreset_in         => gt0_txpcsreset_in,
      gt0_rxpmareset_in         => gt0_rxpmareset_in,
      gt0_rxpcsreset_in         => gt0_rxpcsreset_in,
      gt0_rxbufreset_in         => gt0_rxbufreset_in,
      gt0_rxpmaresetdone_out    => gt0_rxpmaresetdone_out,
      gt0_rxbufstatus_out       => gt0_rxbufstatus_out   ,
      gt0_txbufstatus_out       => gt0_txbufstatus_out   ,
      gt0_dmonitorout_out       => gt0_dmonitorout_out   ,
      gt0_rxchariscomma_out     => gt0_rxchariscomma_out,
      gt0_rxcharisk_out         => gt0_rxcharisk_out,
      gt0_rxbyteisaligned_out   => gt0_rxbyteisaligned_out,
      gt0_rxbyterealign_out     => gt0_rxbyterealign_out,
      gt0_rxcommadet_out        => gt0_rxcommadet_out,
      gt0_txpolarity_in         => gt0_txpolarity_in,
      gt0_txdiffctrl_in         => gt0_txdiffctrl_in,
      gt0_txpostcursor_in       => gt0_txpostcursor_in,
      gt0_txprecursor_in        => gt0_txprecursor_in,
      gt0_rxpolarity_in         => gt0_rxpolarity_in,
      gt0_rxdfelpmreset_in      => gt0_rxdfelpmreset_in,
      gt0_rxlpmen_in            => gt0_rxlpmen_in,
      gt0_txprbssel_in          => gt0_txprbssel_in,
      gt0_txprbsforceerr_in     => gt0_txprbsforceerr_in,
      gt0_rxprbscntreset_in     => gt0_rxprbscntreset_in,
      gt0_rxprbserr_out         => gt0_rxprbserr_out,
      gt0_rxprbssel_in          => gt0_rxprbssel_in,
      gt0_loopback_in           => gt0_loopback_in,
      gt0_txresetdone_out       => gt0_txresetdone_out,
      gt0_rxresetdone_out       => gt0_rxresetdone_out,
      gt0_rxdisperr_out         => gt0_rxdisperr_out,
      gt0_rxnotintable_out      => gt0_rxnotintable_out,
      gt0_eyescanreset_in       => gt0_eyescanreset_in,
      gt0_eyescandataerror_out  => gt0_eyescandataerror_out,
      gt0_eyescantrigger_in     => gt0_eyescantrigger_in,
      gt0_rxcdrhold_in          => gt0_rxcdrhold_in,
      gt0_rxmonitorout_out      => gt0_rxmonitorout_out,
      gt0_rxmonitorsel_in       => gt0_rxmonitorsel_in,
      gt0_rxdfeagcovrden_in     => gt0_rxdfeagcovrden_in,
      
      signal_detect    =>  signal_detect   , 

    gt0_qplloutclk_in    => gt0_qplloutclk,
    gt0_qplloutrefclk_in => gt0_qplloutrefclk

   );


   core_clocking_i : gig_ethernet_pcs_pma_0_clocking
   port map(
      gtrefclk_p                => gtrefclk_p,
      gtrefclk_n                => gtrefclk_n,
      txoutclk                  => txoutclk,
      rxoutclk                  => rxoutclk,
      mmcm_reset                => mmcm_reset,

      gtrefclk                =>  gtrefclk,
      mmcm_locked             =>  mmcm_locked,
      userclk                 =>  userclk,
      userclk2                =>  userclk2,
      rxuserclk                 =>  rxuserclk,
      rxuserclk2                =>  rxuserclk2
   );

   gtrefclk_out   <= gtrefclk;
   userclk_out    <= userclk;
   userclk2_out   <= userclk2;

   rxuserclk_out    <= rxuserclk;
   rxuserclk2_out   <= rxuserclk2;
   pma_reset_out    <= pma_reset;
   
   core_resets_i : gig_ethernet_pcs_pma_0_resets
   port map (
      reset                     => reset, 
      independent_clock_bufg    => independent_clock_bufg,

      mmcm_locked               => mmcm_locked,
      mmcm_reset                => mmcm_reset,
      pma_reset                 => pma_reset
   );

  core_gt_common_i : gig_ethernet_pcs_pma_0_gt_common
  port map(
    gt0_gtrefclk0_common_in     =>   gtrefclk,
    gt0_qplloutclk                  => gt0_qplloutclk,
    gt0_qplloutrefclk               =>   gt0_qplloutrefclk,
    gt0_qplllock_out            =>   open,
    gt0_qplllockdetclk_in       =>   independent_clock_bufg,
    gt0_qpllrefclklost_out      =>   open,
    gt0_qpllreset_in            =>   pma_reset
  );

   gt0_qplloutclk_out        <=  gt0_qplloutclk;
   gt0_qplloutrefclk_out     <=  gt0_qplloutrefclk;
   mmcm_locked_out            <= mmcm_locked;

end wrapper;