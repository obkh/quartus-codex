package require -exact qsys 13.0
create_system {nios_counter_system}
set_project_property DEVICE_FAMILY {Cyclone V}
set_project_property DEVICE {5CSEMA5F31C6}

add_instance clk_0 clock_source 13.0.0
set_instance_parameter_value clk_0 {clockFrequency} {50000000.0}
set_instance_parameter_value clk_0 {clockFrequencyKnown} {1}
set_instance_parameter_value clk_0 {resetSynchronousEdges} {NONE}

add_instance cpu altera_nios2_qsys 13.0
set_instance_parameter_value cpu {impl} {Tiny}
set_instance_parameter_value cpu {icache_size} {0}
set_instance_parameter_value cpu {debug_level} {Level1}
set_instance_parameter_value cpu {resetSlave} {onchip_memory.s1}
set_instance_parameter_value cpu {exceptionSlave} {onchip_memory.s1}

add_instance onchip_memory altera_avalon_onchip_memory2 13.0.1
set_instance_parameter_value onchip_memory {dataWidth} {32}
set_instance_parameter_value onchip_memory {memorySize} {32768}
set_instance_parameter_value onchip_memory {initMemContent} {0}
set_instance_parameter_value onchip_memory {blockType} {AUTO}

add_instance hex0_pio altera_avalon_pio 13.0.1
set_instance_parameter_value hex0_pio {direction} {Output}
set_instance_parameter_value hex0_pio {width} {7}
set_instance_parameter_value hex0_pio {resetValue} {127}
set_instance_parameter_value hex0_pio {generateIRQ} {0}

add_instance interval_timer altera_avalon_timer 13.0.1
set_instance_parameter_value interval_timer {counterSize} {32}
set_instance_parameter_value interval_timer {fixedPeriod} {1}
set_instance_parameter_value interval_timer {period} {1000}
set_instance_parameter_value interval_timer {periodUnits} {MSEC}
set_instance_parameter_value interval_timer {alwaysRun} {0}

add_instance jtag_uart altera_avalon_jtag_uart 13.0.1

add_connection clk_0.clk cpu.clk
add_connection clk_0.clk onchip_memory.clk1
add_connection clk_0.clk hex0_pio.clk
add_connection clk_0.clk interval_timer.clk
add_connection clk_0.clk jtag_uart.clk

add_connection clk_0.clk_reset cpu.reset_n
add_connection clk_0.clk_reset onchip_memory.reset1
add_connection clk_0.clk_reset hex0_pio.reset
add_connection clk_0.clk_reset interval_timer.reset
add_connection clk_0.clk_reset jtag_uart.reset
add_connection cpu.jtag_debug_module_reset cpu.reset_n
add_connection cpu.jtag_debug_module_reset onchip_memory.reset1
add_connection cpu.jtag_debug_module_reset hex0_pio.reset
add_connection cpu.jtag_debug_module_reset interval_timer.reset
add_connection cpu.jtag_debug_module_reset jtag_uart.reset

add_connection cpu.data_master onchip_memory.s1
set_connection_parameter_value cpu.data_master/onchip_memory.s1 baseAddress {0x00000000}
add_connection cpu.instruction_master onchip_memory.s1
set_connection_parameter_value cpu.instruction_master/onchip_memory.s1 baseAddress {0x00000000}
add_connection cpu.data_master cpu.jtag_debug_module
set_connection_parameter_value cpu.data_master/cpu.jtag_debug_module baseAddress {0x00010800}
add_connection cpu.instruction_master cpu.jtag_debug_module
set_connection_parameter_value cpu.instruction_master/cpu.jtag_debug_module baseAddress {0x00010800}
add_connection cpu.data_master hex0_pio.s1
set_connection_parameter_value cpu.data_master/hex0_pio.s1 baseAddress {0x00010000}
add_connection cpu.data_master interval_timer.s1
set_connection_parameter_value cpu.data_master/interval_timer.s1 baseAddress {0x00010020}
add_connection cpu.data_master jtag_uart.avalon_jtag_slave
set_connection_parameter_value cpu.data_master/jtag_uart.avalon_jtag_slave baseAddress {0x00010040}

add_connection cpu.d_irq interval_timer.irq
set_connection_parameter_value cpu.d_irq/interval_timer.irq irqNumber {0}
add_connection cpu.d_irq jtag_uart.irq
set_connection_parameter_value cpu.d_irq/jtag_uart.irq irqNumber {1}

add_interface clk clock sink
set_interface_property clk EXPORT_OF clk_0.clk_in
add_interface reset reset sink
set_interface_property reset EXPORT_OF clk_0.clk_in_reset
add_interface hex0 conduit end
set_interface_property hex0 EXPORT_OF hex0_pio.external_connection

set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}

save_system {nios_counter_system.qsys}
