open_project prj.REG
set_top top_REG_1
add_files ./src/top_REG_1.cc

open_solution "solution"
set_part xc7z020clg484-1
create_clock -period 10

#source "./directives.tcl"

csynth_design
