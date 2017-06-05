open_project prj.DOUBLE1_CALL_MON
set_top top_DOUBLE1_CALL_MON
add_files ./src/top_DOUBLE1_CALL_MON.cc

open_solution "solution"
set_part xc7z020clg484-1
create_clock -period 10

#source "./directives.tcl"

csynth_design
