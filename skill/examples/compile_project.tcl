# Run with: quartus_sh -t compile_project.tcl
project_open -revision nios2_counter_de1soc nios2_counter_de1soc
execute_flow -compile
project_close
