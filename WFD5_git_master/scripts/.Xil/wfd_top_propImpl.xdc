set_property SRC_FILE_INFO {cfile:C:/USER_LOCAL/crs/Gminus2/Xilinx/WFD5_git_master/constraints/timing.xdc rfile:../../../../../../../USER_LOCAL/crs/Gminus2/Xilinx/WFD5_git_master/constraints/timing.xdc id:1} [current_design]
set_property SRC_FILE_INFO {cfile:C:/USER_LOCAL/crs/Gminus2/Xilinx/WFD5_git_master/constraints/ios.xdc rfile:../../../../../../../USER_LOCAL/crs/Gminus2/Xilinx/WFD5_git_master/constraints/ios.xdc id:2} [current_design]
set_property src_info {type:XDC file:1 line:36 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_clocks clk50] -to [get_clocks user_clk_chan0] -datapath_only 8.0	 
set_property src_info {type:XDC file:1 line:37 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_clocks clk50] -to [get_clocks user_clk_chan1] -datapath_only 8.0	 
set_property src_info {type:XDC file:1 line:38 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_clocks clk50] -to [get_clocks user_clk_chan2] -datapath_only 8.0	 
set_property src_info {type:XDC file:1 line:39 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_clocks clk50] -to [get_clocks user_clk_chan3] -datapath_only 8.0	 
set_property src_info {type:XDC file:1 line:40 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_clocks clk50] -to [get_clocks user_clk_chan4] -datapath_only 8.0	 
set_property src_info {type:XDC file:1 line:48 export:INPUT save:INPUT read:READ} [current_design]
set_clock_groups -name async_clk50_gige_clk -asynchronous -group [get_clocks -include_generated_clocks clk50] -group [get_clocks -include_generated_clocks clk125] -group [get_clocks -include_generated_clocks clk200] -group [get_clocks -include_generated_clocks gige_clk] -group [get_clocks -include_generated_clocks ipb/eth/phy/U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/*/gtwizard_i/gt0_GTWIZARD_i/gtxe2_i/TXOUTCLK] -group [get_clocks -include_generated_clocks DAQ_usrclk] -group [get_clocks -include_generated_clocks user_clk_chan0] -group [get_clocks -include_generated_clocks user_clk_chan1] -group [get_clocks -include_generated_clocks user_clk_chan2] -group [get_clocks -include_generated_clocks user_clk_chan3]  -group [get_clocks -include_generated_clocks user_clk_chan4]
set_property src_info {type:XDC file:2 line:159 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R4 [get_ports gige_rx]
set_property src_info {type:XDC file:2 line:160 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R3 [get_ports gige_rx_N]
set_property src_info {type:XDC file:2 line:162 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P2 [get_ports gige_tx]
set_property src_info {type:XDC file:2 line:163 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P1 [get_ports gige_tx_N]
set_property src_info {type:XDC file:2 line:165 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N4 [get_ports daq_rx]
set_property src_info {type:XDC file:2 line:166 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N3 [get_ports daq_rx_N]
set_property src_info {type:XDC file:2 line:168 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M2 [get_ports daq_tx]
set_property src_info {type:XDC file:2 line:169 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M1 [get_ports daq_tx_N]
set_property src_info {type:XDC file:2 line:171 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN H6 [get_ports gtx_clk0]
set_property src_info {type:XDC file:2 line:172 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN H5 [get_ports gtx_clk0_N]
set_property src_info {type:XDC file:2 line:174 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN D6 [get_ports gtx_clk1]
set_property src_info {type:XDC file:2 line:175 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN D5 [get_ports gtx_clk1_N]
set_property src_info {type:XDC file:2 line:177 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A4 [get_ports c0_tx]
set_property src_info {type:XDC file:2 line:178 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A3 [get_ports c0_tx_N]
set_property src_info {type:XDC file:2 line:179 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B6 [get_ports c0_rx]
set_property src_info {type:XDC file:2 line:180 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B5 [get_ports c0_rx_N]
set_property src_info {type:XDC file:2 line:182 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B2 [get_ports c1_tx]
set_property src_info {type:XDC file:2 line:183 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B1 [get_ports c1_tx_N]
set_property src_info {type:XDC file:2 line:184 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN C4 [get_ports c1_rx]
set_property src_info {type:XDC file:2 line:185 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN C3 [get_ports c1_rx_N]
set_property src_info {type:XDC file:2 line:187 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN D2 [get_ports c2_tx]
set_property src_info {type:XDC file:2 line:188 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN D1 [get_ports c2_tx_N]
set_property src_info {type:XDC file:2 line:189 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN E4 [get_ports c2_rx]
set_property src_info {type:XDC file:2 line:190 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN E3 [get_ports c2_rx_N]
set_property src_info {type:XDC file:2 line:192 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F2 [get_ports c3_tx]
set_property src_info {type:XDC file:2 line:193 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F1 [get_ports c3_tx_N]
set_property src_info {type:XDC file:2 line:194 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN G4 [get_ports c3_rx]
set_property src_info {type:XDC file:2 line:195 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN G3 [get_ports c3_rx_N]
set_property src_info {type:XDC file:2 line:197 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN H2 [get_ports c4_tx]
set_property src_info {type:XDC file:2 line:198 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN H1 [get_ports c4_tx_N]
set_property src_info {type:XDC file:2 line:199 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN J4 [get_ports c4_rx]
set_property src_info {type:XDC file:2 line:200 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN J3 [get_ports c4_rx_N]
set_property src_info {type:XDC file:2 line:202 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P25 [get_ports {mmc_io[3]}]
set_property src_info {type:XDC file:2 line:203 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N26 [get_ports {mmc_io[2]}]
set_property src_info {type:XDC file:2 line:204 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T25 [get_ports {mmc_io[1]}]
set_property src_info {type:XDC file:2 line:205 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U25 [get_ports {mmc_io[0]}]
set_property src_info {type:XDC file:2 line:207 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B14 [get_ports bbus_scl]
set_property src_info {type:XDC file:2 line:208 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A14 [get_ports bbus_sda]
set_property src_info {type:XDC file:2 line:210 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN E18 [get_ports ext_trig]
set_property src_info {type:XDC file:2 line:212 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN H26 [get_ports {acq_trigs[4]}]
set_property src_info {type:XDC file:2 line:213 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AE21 [get_ports {acq_trigs[3]}]
set_property src_info {type:XDC file:2 line:214 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AD26 [get_ports {acq_trigs[2]}]
set_property src_info {type:XDC file:2 line:215 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A24 [get_ports {acq_trigs[1]}]
set_property src_info {type:XDC file:2 line:216 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B9 [get_ports {acq_trigs[0]}]
set_property src_info {type:XDC file:2 line:218 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN G25 [get_ports {acq_dones[4]}]
set_property src_info {type:XDC file:2 line:219 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AE22 [get_ports {acq_dones[3]}]
set_property src_info {type:XDC file:2 line:220 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AA25 [get_ports {acq_dones[2]}]
set_property src_info {type:XDC file:2 line:221 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B22 [get_ports {acq_dones[1]}]
set_property src_info {type:XDC file:2 line:222 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A10 [get_ports {acq_dones[0]}]
set_property src_info {type:XDC file:2 line:224 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F8 [get_ports {debug[7]}]
set_property src_info {type:XDC file:2 line:225 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F9 [get_ports {debug[6]}]
set_property src_info {type:XDC file:2 line:226 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F10 [get_ports {debug[5]}]
set_property src_info {type:XDC file:2 line:227 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F12 [get_ports {debug[4]}]
set_property src_info {type:XDC file:2 line:228 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F13 [get_ports {debug[3]}]
set_property src_info {type:XDC file:2 line:229 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F14 [get_ports {debug[2]}]
set_property src_info {type:XDC file:2 line:230 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F15 [get_ports {debug[1]}]
set_property src_info {type:XDC file:2 line:231 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F17 [get_ports {debug[0]}]
set_property src_info {type:XDC file:2 line:233 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U26 [get_ports led0]
set_property src_info {type:XDC file:2 line:234 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN V26 [get_ports led1]
set_property src_info {type:XDC file:2 line:236 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN G26 [get_ports {c4_io[3]}]
set_property src_info {type:XDC file:2 line:237 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F25 [get_ports {c4_io[2]}]
set_property src_info {type:XDC file:2 line:238 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN E25 [get_ports {c4_io[1]}]
set_property src_info {type:XDC file:2 line:239 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN E26 [get_ports {c4_io[0]}]
set_property src_info {type:XDC file:2 line:241 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AF23 [get_ports {c3_io[3]}]
set_property src_info {type:XDC file:2 line:242 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AF24 [get_ports {c3_io[2]}]
set_property src_info {type:XDC file:2 line:243 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AE25 [get_ports {c3_io[1]}]
set_property src_info {type:XDC file:2 line:244 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AF25 [get_ports {c3_io[0]}]
set_property src_info {type:XDC file:2 line:246 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AB26 [get_ports {c2_io[3]}]
set_property src_info {type:XDC file:2 line:247 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AB25 [get_ports {c2_io[2]}]
set_property src_info {type:XDC file:2 line:248 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AD25 [get_ports {c2_io[1]}]
set_property src_info {type:XDC file:2 line:249 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AE26 [get_ports {c2_io[0]}]
set_property src_info {type:XDC file:2 line:251 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A22 [get_ports {c1_io[3]}]
set_property src_info {type:XDC file:2 line:252 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B21 [get_ports {c1_io[2]}]
set_property src_info {type:XDC file:2 line:253 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B20 [get_ports {c1_io[1]}]
set_property src_info {type:XDC file:2 line:254 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A20 [get_ports {c1_io[0]}]
set_property src_info {type:XDC file:2 line:256 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A13 [get_ports {c0_io[3]}]
set_property src_info {type:XDC file:2 line:257 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B12 [get_ports {c0_io[2]}]
set_property src_info {type:XDC file:2 line:258 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B10 [get_ports {c0_io[1]}]
set_property src_info {type:XDC file:2 line:259 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A12 [get_ports {c0_io[0]}]
set_property src_info {type:XDC file:2 line:261 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN V24 [get_ports {mezzb[5]}]
set_property src_info {type:XDC file:2 line:262 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN W24 [get_ports {mezzb[4]}]
set_property src_info {type:XDC file:2 line:263 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AA24 [get_ports {mezzb[3]}]
set_property src_info {type:XDC file:2 line:264 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AB24 [get_ports {mezzb[2]}]
set_property src_info {type:XDC file:2 line:265 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AC24 [get_ports {mezzb[1]}]
set_property src_info {type:XDC file:2 line:266 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AD24 [get_ports {mezzb[0]}]
set_property src_info {type:XDC file:2 line:269 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN C22 [get_ports adcclk_ld]
set_property src_info {type:XDC file:2 line:270 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN D23 [get_ports adcclk_goe]
set_property src_info {type:XDC file:2 line:271 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN E23 [get_ports adcclk_sync]
set_property src_info {type:XDC file:2 line:272 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F23 [get_ports adcclk_los0]
set_property src_info {type:XDC file:2 line:273 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN G24 [get_ports adcclk_los1]
set_property src_info {type:XDC file:2 line:274 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN H24 [get_ports adcclk_dlen]
set_property src_info {type:XDC file:2 line:275 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN J25 [get_ports adcclk_ddat]
set_property src_info {type:XDC file:2 line:276 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K25 [get_ports adcclk_dclk]
set_property src_info {type:XDC file:2 line:278 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R25 [get_ports mmc_reset_m]
set_property src_info {type:XDC file:2 line:280 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K23 [get_ports daq_clk_sel]
set_property src_info {type:XDC file:2 line:281 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K26 [get_ports daq_clk_en]
set_property src_info {type:XDC file:2 line:283 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AA4 [get_ports ttc_clkp]
set_property src_info {type:XDC file:2 line:284 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AB4 [get_ports ttc_clkn]
set_property src_info {type:XDC file:2 line:285 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN V2 [get_ports ttc_rxp]
set_property src_info {type:XDC file:2 line:286 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN V1 [get_ports ttc_rxn]
set_property src_info {type:XDC file:2 line:287 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN Y3 [get_ports ttc_txp]
set_property src_info {type:XDC file:2 line:288 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN Y2 [get_ports ttc_txn]
set_property src_info {type:XDC file:2 line:290 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN C12 [get_ports clkin]
set_property src_info {type:XDC file:2 line:292 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T24 [get_ports {wfdps[1]}]
set_property src_info {type:XDC file:2 line:293 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U24 [get_ports {wfdps[0]}]
set_property src_info {type:XDC file:2 line:295 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN D26 [get_ports c_clk]
set_property src_info {type:XDC file:2 line:296 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN D25 [get_ports c_din]
set_property src_info {type:XDC file:2 line:297 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN C26 [get_ports c_progb]
set_property src_info {type:XDC file:2 line:298 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN D24 [get_ports test]
set_property src_info {type:XDC file:2 line:300 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K17 [get_ports {prog_done[4]}]
set_property src_info {type:XDC file:2 line:301 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AE23 [get_ports {prog_done[3]}]
set_property src_info {type:XDC file:2 line:302 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN Y26 [get_ports {prog_done[2]}]
set_property src_info {type:XDC file:2 line:303 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A23 [get_ports {prog_done[1]}]
set_property src_info {type:XDC file:2 line:304 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A8 [get_ports {prog_done[0]}]
set_property src_info {type:XDC file:2 line:306 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN J26 [get_ports {initb[4]}]
set_property src_info {type:XDC file:2 line:307 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AF22 [get_ports {initb[3]}]
set_property src_info {type:XDC file:2 line:308 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AC26 [get_ports {initb[2]}]
set_property src_info {type:XDC file:2 line:309 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN C24 [get_ports {initb[1]}]
set_property src_info {type:XDC file:2 line:310 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A9 [get_ports {initb[0]}]
