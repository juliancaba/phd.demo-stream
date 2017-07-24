## topTesting directives
set_directive_interface -mode ap_ctrl_none "top_CTRL" 
set_directive_interface -mode ap_fifo -depth 32 "top_CTRL" din
set_directive_interface -mode ap_fifo -depth 32 "top_CTRL" dout
# set_directive_interface -mode ap_fifo -depth 32 "top_CTRL" buffer_histIN
# set_directive_interface -mode ap_fifo -depth 32 "top_CTRL" callTime_histIN
# set_directive_interface -mode ap_fifo -depth 32 "top_CTRL" expect_histOUT
# set_directive_interface -mode ap_fifo -depth 32 "top_CTRL" callTime_histOUT
# set_directive_interface -mode ap_fifo -depth 32 "top_CTRL" fail_histOUT

set_directive_dataflow "top_CTRL"
config_dataflow -default_channel fifo -fifo_depth 32


set_directive_inline "running_DOUBLE1_CTRL_return"
set_directive_inline "readParameters_DOUBLE1_CTRL_return"
set_directive_inline "running_DOUBLE1_CTRL_callCount"
set_directive_inline "running_DOUBLE1_CTRL_callTime"

set_directive_inline "running_DOUBLE2_CTRL_expected"
set_directive_inline "readParameters_DOUBLE2_CTRL_expected"
set_directive_inline "running_DOUBLE2_CTRL_callCount"
set_directive_inline "running_DOUBLE2_CTRL_callTime"
set_directive_inline "running_DOUBLE2_CTRL_failCount"
set_directive_inline "running_DOUBLE2_CTRL_fail"

#set_directive_inline "running_DOUBLE2_CTRL_intervalDelay"
