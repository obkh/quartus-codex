Nios II DE1-SoC counter (Quartus II 13.0 Web Edition)

This design uses a Nios II/e CPU, 32 KiB on-chip RAM, an Avalon PIO connected to HEX0, an interval timer, and JTAG UART. The C program displays 0, 1, ... 8 on HEX0, advancing once per second, then repeats from 0. KEY0 resets the Nios system while held.

Target part: Cyclone V SoC 5CSEMA5F31C6 (DE1-SoC). The pin map is for the standard Terasic DE1-SoC layout. Check your exact board revision before programming.

Hardware generation:
1. Open a Windows Command Prompt and cd to this folder.
2. Run:
   C:\altera\13.0\quartus\sopc_builder\bin\qsys-script.exe --script=nios_counter_system.tcl
   C:\altera\13.0\quartus\sopc_builder\bin\qsys-generate.exe nios_counter_system.qsys --synthesis=VERILOG
3. Open nios2_counter_de1soc.qpf in Quartus II 13.0 and compile the nios2_counter_de1soc revision.

Nios software:
1. Start the Nios II Command Shell from the Quartus 13.0 Start Menu group.
2. From this folder, create a HAL BSP for nios_counter_system.sopcinfo using CPU instance cpu and the generated system timer interval_timer. Generate the BSP files.
3. Generate an application makefile for software\counter with software\bsp as the BSP directory, then build the application.
4. Connect and power the DE1-SoC. Program output_files\nios2_counter_de1soc.sof with Quartus Programmer.
5. Use nios2-download to download software\counter\counter.elf over JTAG. Restart the processor; the display begins at 0.

The FPGA image and application ELF are separate. Rebuild the BSP/application whenever the Qsys hardware changes. If Quartus reports missing Cyclone V devices, install the Cyclone V device support file matching Quartus 13.0.
