SetActiveLib -work
comp -include "$DSN\src\Booth.vhd" 
comp -include "$DSN\src\TestBench\booth_ent_TB.vhd" 
asim TESTBENCH_FOR_booth_ent 
wave 
wave -noreg q
wave -noreg m
wave -noreg clk
wave -noreg prod
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$DSN\src\TestBench\booth_ent_TB_tim_cfg.vhd" 
# asim TIMING_FOR_booth_ent 
