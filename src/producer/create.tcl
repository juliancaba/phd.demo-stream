#pext Set the reference directory to where the script is
set SRCfolder src
set SRCfiles [list FIFO_top_DOUBLE1_CTRL_bufferIN_DOUBLE1_CTRL_V.vhd    top_DOUBLE1_CTRL_inputBuffer_DOUBLE1_CTRL.vhd FIFO_top_DOUBLE1_CTRL_bufferOUT_DOUBLE1_CTRL_V.vhd   top_DOUBLE1_CTRL_manager_DOUBLE1_CTRL.vhd FIFO_top_DOUBLE1_CTRL_bufferRESP_DOUBLE1_CTRL_V.vhd  top_DOUBLE1_CTRL_manager_DOUBLE1_CTRL_words32.vhd top_DOUBLE1.vhd                                        top_DOUBLE1_CTRL_outputBuffer_DOUBLE1_CTRL.vhd top_DOUBLE1_CTRL.vhd                                  top_DOUBLE1_CALL_MON.vhd top_DOUBLE1_CTRL_buildResponse_DOUBLE1_CTRL.vhd top_DOUBLE1_stream.vhd top_DOUBLE1_REPLAST_histIN.vhd]

set SIMfolder src
set SIMfiles [list ]
set part xc7z020clg484-1


set origin_dir [file dirname [info script]]
set prj_name tmp

#set fpo_ver 7.1


# Create project
create_project $prj_name $origin_dir/$prj_name -part $part -force


# Set project properties
set obj [get_projects $prj_name]
#set_property "board_part" "xilinx.com:zc702:part0:0.9" $obj
set_property "board_part" "xilinx.com:zc702:1.1" $obj
set_property "default_lib" "xil_defaultlib" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj
set_property SOURCE_SET sources_1 [get_filesets sim_1]


# Add source files
foreach it $SRCfiles {
    add_files -norecurse $origin_dir/$SRCfolder/$it
}


# Add sim files
foreach it $SIMfiles {
    add_files -fileset sim_1 -norecurse $origin_dir/$SIMfolder/$it
}

create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name internal_fifo32
set_property -dict [list CONFIG.INTERFACE_TYPE {Native} CONFIG.Performance_Options {First_Word_Fall_Through} CONFIG.Input_Data_Width {32} CONFIG.TDATA_NUM_BYTES {4} CONFIG.FIFO_Implementation_axis {Common_Clock_Distributed_RAM} CONFIG.Output_Data_Width {32} CONFIG.Reset_Type {Synchronous_Reset} CONFIG.Full_Flags_Reset_Value {0} CONFIG.Use_Extra_Logic {true} CONFIG.Data_Count_Width {11} CONFIG.Write_Data_Count_Width {11} CONFIG.Read_Data_Count_Width {11} CONFIG.Full_Threshold_Assert_Value {1023} CONFIG.Full_Threshold_Negate_Value {1022} CONFIG.Empty_Threshold_Assert_Value {4} CONFIG.Empty_Threshold_Negate_Value {5} CONFIG.TSTRB_WIDTH {4} CONFIG.TKEEP_WIDTH {4} CONFIG.FIFO_Application_Type_axis {Data_FIFO}] [get_ips internal_fifo32]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1


launch_run  synth_1
wait_on_run synth_1

