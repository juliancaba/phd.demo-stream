open_project prj.DOUBLE1_REPLAST
set_top top_DOUBLE1_REPLAST_A
add_files ./src/top_DOUBLE1_REPLAST_A.cc

open_solution "solution"
set_part xc7z020clg484-1
create_clock -period 10

#source "./directives.tcl"

csynth_design
