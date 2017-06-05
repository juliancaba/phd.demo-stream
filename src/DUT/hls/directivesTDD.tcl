## topTesting directives
set_directive_interface -mode ap_ctrl_none "l2norm" 
set_directive_interface -mode ap_fifo "l2norm" histIN
set_directive_interface -mode ap_fifo "l2norm" histOUT
set_directive_dataflow "l2norm"

config_dataflow -default_channel fifo -fifo_depth 32
