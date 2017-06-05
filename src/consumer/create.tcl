#pext Set the reference directory to where the script is
set SRCfolder src
set SRCfiles [list top_DOUBLE1_CALL_MON.vhd top_DOUBLE2_stream.vhd top_DOUBLE2_EXPECT_MON.vhd  top_DOUBLE2_EXPECT_MON_fcmp_32ns_32ns_1_1.vhd      top_REG_1.vhd]

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

create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name internal_fifo160
set_property -dict [list CONFIG.INTERFACE_TYPE {Native} CONFIG.Performance_Options {First_Word_Fall_Through} CONFIG.Input_Depth {32} CONFIG.Output_Depth {32} CONFIG.Input_Data_Width {160} CONFIG.TDATA_NUM_BYTES {4} CONFIG.FIFO_Implementation_axis {Common_Clock_Distributed_RAM} CONFIG.Output_Data_Width {160} CONFIG.Reset_Type {Synchronous_Reset} CONFIG.Full_Flags_Reset_Value {0} CONFIG.Use_Extra_Logic {true} CONFIG.Data_Count_Width {6} CONFIG.Write_Data_Count_Width {6} CONFIG.Read_Data_Count_Width {6} CONFIG.Full_Threshold_Assert_Value {31} CONFIG.Full_Threshold_Negate_Value {30} CONFIG.Empty_Threshold_Assert_Value {4} CONFIG.Empty_Threshold_Negate_Value {5} CONFIG.TSTRB_WIDTH {4} CONFIG.TKEEP_WIDTH {4} CONFIG.FIFO_Application_Type_axis {Data_FIFO}] [get_ips internal_fifo160]

set fpo_ver 7.1
create_ip -name floating_point -version $fpo_ver -vendor xilinx.com -library ip -module_name top_DOUBLE2_EXPECT_MON_ap_fcmp_0_no_dsp_32
# BEGIN Vivado Commands 
# BEGIN Vivado Parameters
set_property -dict [list CONFIG.a_precision_type Single \
                          CONFIG.a_tuser_width 1 \
                          CONFIG.add_sub_value Both \
                          CONFIG.b_tuser_width 1 \
                          CONFIG.c_a_exponent_width 8 \
                          CONFIG.c_a_fraction_width 24 \
                          CONFIG.c_compare_operation Programmable \
                          CONFIG.c_has_divide_by_zero false \
                          CONFIG.c_has_invalid_op false \
                          CONFIG.c_has_overflow false \
                          CONFIG.c_has_underflow false \
                          CONFIG.c_latency 0 \
                          CONFIG.c_mult_usage No_Usage \
                          CONFIG.c_optimization Speed_Optimized \
                          CONFIG.c_rate 1 \
                          CONFIG.c_result_exponent_width 1 \
                          CONFIG.c_result_fraction_width 0 \
                          CONFIG.component_name top_DOUBLE2_EXPECT_MON_ap_fcmp_0_no_dsp_32 \
                          CONFIG.flow_control NonBlocking \
                          CONFIG.has_a_tlast false \
                          CONFIG.has_a_tuser false \
                          CONFIG.has_aclken false \
                          CONFIG.has_aresetn false \
                          CONFIG.has_b_tlast false \
                          CONFIG.has_b_tuser false \
                          CONFIG.has_operation_tlast false \
                          CONFIG.has_operation_tuser false \
                          CONFIG.has_result_tready false \
                          CONFIG.maximum_latency false \
                          CONFIG.operation_tuser_width 1 \
                          CONFIG.operation_type Compare \
                          CONFIG.result_precision_type Custom \
                          CONFIG.result_tlast_behv Null] -objects [get_ips top_DOUBLE2_EXPECT_MON_ap_fcmp_0_no_dsp_32] -quiet

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1


launch_run  synth_1
wait_on_run synth_1

