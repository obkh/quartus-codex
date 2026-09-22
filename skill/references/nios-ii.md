# Nios II legacy projects

Nios II is the classic Altera soft processor supported by Quartus II 13.0. Its ISA, IP component names, BSP tools, compiler, debugger, and download commands are separate from Nios V. The Quartus II 13.0 Web Edition installation includes Nios II EDS tools when that package is installed; verify the selected device support pack and installed components.

## Hardware system

Build a Qsys system containing a Nios II CPU, writable executable memory, required Avalon peripherals, a JTAG UART when console/debug output is needed, and clock/reset components. For a small lab design, on-chip RAM is often enough. Connect both instruction and data masters to executable memory; map every peripheral into the CPU data address space; set reset and exception vectors to valid memory. Export board-facing PIOs and clocks/resets to a top-level HDL wrapper.

Select the CPU implementation intentionally (Nios II/e “Tiny” for minimal area, Nios II/s or /f when their capabilities are needed). Quartus 13.0's component may be named `altera_nios2_qsys`; later releases may expose a generation-2 component. Read the local IP GUI/Tcl component definition rather than assuming an identifier or parameter from a newer release.

## Software system

The Nios II SBT uses a `.sopcinfo` file emitted from the generated hardware system. A BSP maps the selected HAL and drivers to that hardware; an application makefile compiles C/C++ against the BSP. If the Qsys system changes, regenerate the `.sopcinfo` and BSP before rebuilding the app. Do not hand-edit generated BSP headers such as `system.h`.

Quartus 13.0 tools commonly live under `nios2eds/bin` and `nios2eds/sdk2/bin`; look for `nios2-bsp`, `nios2-app-generate-makefile`, `nios2-download`, `nios2-terminal`, and the `nios2-elf-*` compiler. Use the Nios II Command Shell or explicitly initialize the supplied environment so Windows paths and tool variables resolve. Confirm command syntax with `--help` because SBT flags changed over time.

## Build and run

Typical flow:

1. Generate the Qsys system and `.sopcinfo`.
2. Create/generate a HAL BSP for that `.sopcinfo` and CPU instance.
3. Create/build the Nios II application against that BSP.
4. Compile the Quartus hardware image.
5. Program the FPGA image over JTAG, then download the application ELF into the CPU's RAM using `nios2-download` (or the IDE debugger).
6. Open `nios2-terminal` if the app uses JTAG UART output.

An FPGA `.sof` alone does not automatically contain the Nios application unless memory initialization or flash boot is deliberately configured. Keep the hardware image and the matching ELF/BSP together.

## References

- [Nios II Software Developer Handbook](https://www.intel.com/programmable/technical-pdfs/683525.pdf)
- [Nios II Embedded Design Suite User Guide](https://www.intel.com/content/www/us/en/docs/programmable/683525/current/nios-ii-software-developer-handbook.html)
- [Quartus II 13.0 download page](https://www.altera.com/downloads/fpga-development-tools/quartus-ii-web-edition-design-software-version-13-0-b156-windows)
