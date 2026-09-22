# Nios V projects

Nios V is a newer RISC-V soft processor. It is not an alias or drop-in software-tool replacement for Nios II. Do not build a Nios V system with Quartus II 13.0. Official documentation states that Nios V/m is available in Quartus Prime Pro Edition 21.3 and later; Standard Edition support begins in a later release (22.1). Check the exact edition, release, target family, and component support for the selected device before starting.

Nios V uses a RISC-V ISA and a distinct software toolchain and BSP flow. Typical tools include `niosv-shell`, `niosv-bsp`, and the associated RISC-V compiler/debug environment. Nios II SBT commands and `nios2-elf-*` binaries must not be assumed to build Nios V applications.

Use the current Nios V Embedded Processor Design Handbook and matching release notes for the installed Quartus version. Build hardware in Platform Designer, generate the system, create the BSP for the exact system/CPU/revision, then build the RISC-V application. Confirm generated platform metadata and reset/address configuration before debugging.

## References

- [Nios V/m processor support statement](https://www.intel.com/content/www/us/en/docs/programmable/683632/22-2-21-3-0/processor.html)
- [Nios V Embedded Processor Design Handbook](https://docs.altera.com/r/docs/726952/26.1/nios-v-embedded-processor-design-handbook)
- [Nios V processor release notes](https://www.intel.com/programmable/technical-pdfs/683098.pdf)
