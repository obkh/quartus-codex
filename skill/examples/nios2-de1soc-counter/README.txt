Nios II DE1-SoC counter (Quartus II 13.0 Web Edition)

This design uses a Nios II/e CPU, 32 KiB on-chip RAM, an Avalon PIO connected to HEX0, an interval timer, and JTAG UART. The C program displays 0, 1, ... 8 on HEX0, advancing once per second, then repeats from 0. KEY0 resets the Nios system while held.

Target part: Cyclone V SoC 5CSEMA5F31C6 (DE1-SoC). The pin map is for the standard Terasic DE1-SoC layout. Check your exact board revision before programming.

Hardware generation:
1. Open a Windows Command Prompt and cd to this folder.
2. Run:
   C:\altera\13.0\quartus\sopc_builder\bin\qsys-script.exe --script=nios_counter_system.tcl
   C:\altera\13.0\quartus\sopc_builder\bin\qsys-generate.exe nios_counter_system.qsys --synthesis=VERILOG
3. Open nios2_counter_de1soc.qpf in Quartus II 13.0 and compile the nios2_counter_de1soc revision.

Nios software (from the Nios II Command Shell):
1. Create the HAL BSP. The counter polls the interval timer directly, so do not assign it as the HAL system timer:
   nios2-bsp hal software/bsp nios_counter_system.sopcinfo --cpu-name cpu --default_stdio jtag_uart --default_sys_timer none
2. Generate the application makefile and build the ELF:
   nios2-app-generate-makefile --bsp-dir software/bsp --app-dir software/counter --src-dir software/counter/src --elf-name counter.elf
   make -C software/counter
3. Program output_files\nios2_counter_de1soc.sof, then download software/counter/counter.elf over JTAG and restart the processor.

The FPGA image and application ELF are separate. Rebuild the BSP/application whenever the Qsys hardware changes. If Quartus reports missing Cyclone V devices, install the matching device support. Quartus II 13.0.0 Build 156 completed synthesis and fitting here but did not emit a programming file for this part; Quartus II 13.0sp1 Web Edition lists Cyclone V device support.
