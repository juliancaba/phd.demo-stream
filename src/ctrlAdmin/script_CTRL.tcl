open_project prj.CTRL
set_top top_CTRL
add_files ./src/hls_casting.cc
add_files ./src/wrapper_DOUBLE1_CTRL.cc
add_files ./src/wrapper_DOUBLE2_CTRL.cc
add_files ./src/top_CTRL.cc

open_solution "solution"
set_part xc7z020clg484-1
create_clock -period 10

source "./directives_CTRL.tcl"

csynth_design
