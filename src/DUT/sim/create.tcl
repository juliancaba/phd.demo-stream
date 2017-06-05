#pext Set the reference directory to where the script is
set SRCfolder src

## recipf
set SRCfiles [list FIFO_l2norm_histAUX_1_V.vhd    l2norm.vhd                               l2norm_frecip_32ns_32ns_32_10_full_dsp.vhd  l2norm_scale2.vhd FIFO_l2norm_scale_channel.vhd  l2norm_fadd_32ns_32ns_32_5_full_dsp.vhd  l2norm_fsqrt_32ns_32ns_32_12.vhd            l2norm_sum_hist_pow.vhd FIFO_l2norm_sum_channel.vhd    l2norm_fmul_32ns_32ns_32_4_max_dsp.vhd   l2norm_mult_hist_scale.vhd ]


set SIMfolder src
set SIMfiles [list l2norm_tb.vhd]
set part xc7z020clg484-1


set origin_dir [file dirname [info script]]
set prj_name tmp

set fpo_ver 7.1


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


create_ip -name floating_point -version $fpo_ver -vendor xilinx.com -library ip -module_name l2norm_ap_fadd_3_full_dsp_32
set_property -dict [list CONFIG.a_precision_type Single \
                          CONFIG.a_tuser_width 1 \
                          CONFIG.add_sub_value Add \
                          CONFIG.b_tuser_width 1 \
                          CONFIG.c_a_exponent_width 8 \
                          CONFIG.c_a_fraction_width 24 \
                          CONFIG.c_compare_operation Programmable \
                          CONFIG.c_has_divide_by_zero false \
                          CONFIG.c_has_invalid_op false \
                          CONFIG.c_has_overflow false \
                          CONFIG.c_has_underflow false \
                          CONFIG.c_latency 3 \
                          CONFIG.c_mult_usage Full_Usage \
                          CONFIG.c_optimization Speed_Optimized \
                          CONFIG.c_rate 1 \
                          CONFIG.c_result_exponent_width 8 \
                          CONFIG.c_result_fraction_width 24 \
                          CONFIG.component_name l2norm_ap_fadd_3_full_dsp_32 \
                          CONFIG.flow_control NonBlocking \
                          CONFIG.has_a_tlast false \
                          CONFIG.has_a_tuser false \
                          CONFIG.has_aclken true \
                          CONFIG.has_aresetn false \
                          CONFIG.has_b_tlast false \
                          CONFIG.has_b_tuser false \
                          CONFIG.has_operation_tlast false \
                          CONFIG.has_operation_tuser false \
                          CONFIG.has_result_tready false \
                          CONFIG.maximum_latency false \
                          CONFIG.operation_tuser_width 1 \
                          CONFIG.operation_type Add_Subtract \
                          CONFIG.result_precision_type Single \
                          CONFIG.result_tlast_behv Null] -objects [get_ips l2norm_ap_fadd_3_full_dsp_32] -quiet

create_ip -name floating_point -version $fpo_ver -vendor xilinx.com -library ip -module_name l2norm_ap_fmul_2_max_dsp_32
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
                          CONFIG.c_latency 2 \
                          CONFIG.c_mult_usage Max_Usage \
                          CONFIG.c_optimization Speed_Optimized \
                          CONFIG.c_rate 1 \
                          CONFIG.c_result_exponent_width 8 \
                          CONFIG.c_result_fraction_width 24 \
                          CONFIG.component_name l2norm_ap_fmul_2_max_dsp_32 \
                          CONFIG.flow_control NonBlocking \
                          CONFIG.has_a_tlast false \
                          CONFIG.has_a_tuser false \
                          CONFIG.has_aclken true \
                          CONFIG.has_aresetn false \
                          CONFIG.has_b_tlast false \
                          CONFIG.has_b_tuser false \
                          CONFIG.has_operation_tlast false \
                          CONFIG.has_operation_tuser false \
                          CONFIG.has_result_tready false \
                          CONFIG.maximum_latency false \
                          CONFIG.operation_tuser_width 1 \
                          CONFIG.operation_type Multiply \
                          CONFIG.result_precision_type Single \
                          CONFIG.result_tlast_behv Null] -objects [get_ips l2norm_ap_fmul_2_max_dsp_32] -quiet


create_ip -name floating_point -version $fpo_ver -vendor xilinx.com -library ip -module_name l2norm_ap_fsqrt_10_no_dsp_32
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
                          CONFIG.c_latency 10 \
                          CONFIG.c_mult_usage No_Usage \
                          CONFIG.c_optimization Speed_Optimized \
                          CONFIG.c_rate 1 \
                          CONFIG.c_result_exponent_width 8 \
                          CONFIG.c_result_fraction_width 24 \
                          CONFIG.component_name l2norm_ap_fsqrt_10_no_dsp_32 \
                          CONFIG.flow_control NonBlocking \
                          CONFIG.has_a_tlast false \
                          CONFIG.has_a_tuser false \
                          CONFIG.has_aclken true \
                          CONFIG.has_aresetn false \
                          CONFIG.has_b_tlast false \
                          CONFIG.has_b_tuser false \
                          CONFIG.has_operation_tlast false \
                          CONFIG.has_operation_tuser false \
                          CONFIG.has_result_tready false \
                          CONFIG.maximum_latency false \
                          CONFIG.operation_tuser_width 1 \
                          CONFIG.operation_type Square_Root \
                          CONFIG.result_precision_type Single \
                          CONFIG.result_tlast_behv Null] -objects [get_ips l2norm_ap_fsqrt_10_no_dsp_32] -quiet


## recipf
create_ip -name floating_point -version $fpo_ver -vendor xilinx.com -library ip -module_name l2norm_ap_frecip_8_full_dsp_32
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
                          CONFIG.c_latency 8 \
                          CONFIG.c_mult_usage Full_Usage \
                          CONFIG.c_optimization Speed_Optimized \
                          CONFIG.c_rate 1 \
                          CONFIG.c_result_exponent_width 8 \
                          CONFIG.c_result_fraction_width 24 \
                          CONFIG.component_name l2norm_ap_frecip_8_full_dsp_32 \
                          CONFIG.flow_control NonBlocking \
                          CONFIG.has_a_tlast false \
                          CONFIG.has_a_tuser false \
                          CONFIG.has_aclken true \
                          CONFIG.has_aresetn false \
                          CONFIG.has_b_tlast false \
                          CONFIG.has_b_tuser false \
                          CONFIG.has_operation_tlast false \
                          CONFIG.has_operation_tuser false \
                          CONFIG.has_result_tready false \
                          CONFIG.maximum_latency false \
                          CONFIG.operation_tuser_width 1 \
                          CONFIG.operation_type Reciprocal \
                          CONFIG.result_precision_type Single \
                          CONFIG.result_tlast_behv Null] -objects [get_ips l2norm_ap_frecip_8_full_dsp_32] -quiet


update_compile_order -fileset sources_1
update_compile_order -fileset sim_1


launch_run  synth_1
wait_on_run synth_1

