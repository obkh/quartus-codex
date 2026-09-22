# Platform Designer and legacy Qsys

## Select the installed flow

Quartus 13.x calls the system integration tool **Qsys** and uses `.qsys` files. New releases present it as **Platform Designer**. The concepts carry over, but Tcl API versions, component identifiers, parameters, generated HDL, and tool paths can differ. Use the Qsys version shipped with the project toolchain; do not copy a recent Tcl component definition into an old Qsys release without checking it.

Quartus 13.0 installation paths commonly include:

- `quartus/sopc_builder/bin/qsys-script.exe`
- `quartus/sopc_builder/bin/qsys-generate.exe`
- `ip/altera/nios2_ip/` and `ip/altera/sopc_builder_ip/`

Check actual paths on the host. Start with each executable's `--help` and the local component's `*_hw.tcl` file to find the exact component ID, version, and legal parameters.

## Construction invariants

A usable Nios system needs a connected clock and reset, an Avalon memory path for instructions and data, a valid reset vector and exception vector, an address map without overlap, and exported interfaces that agree with the top-level HDL wrapper. Every clocked IP block must receive the intended clock/reset domain. Every required interrupt must be connected and assigned an IRQ. Export board I/O at a PIO conduit or component conduit, then expose and name it consistently in generated HDL and the wrapper.

Generate the system with Qsys/Platform Designer; generated HDL is output and should not be edited by hand. When changing components or connections, update the system source and regenerate. After generation, inspect the generated top-level module to confirm exported port names before writing the wrapper.

## Tcl pattern

The following is a structural sketch. Component versions and parameters must be verified against the installed release:

```tcl
package require -exact qsys 13.0
create_system {nios_counter_system}
set_project_property DEVICE_FAMILY {Cyclone V}
set_project_property DEVICE {5CSEMA5F31C6}

# add_instance <instance> <component-id> <installed-version>
# set_instance_parameter_value <instance> <parameter> <value>
# add_connection <master.interface> <slave.interface> avalon
# add_interface <external-name> conduit end
# set_interface_property <external-name> EXPORT_OF <instance.interface>

save_system {nios_counter_system.qsys}
```

The API must match the version requested by `package require`. For a repeatable generation, use the installed `qsys-script --script=<file>` and `qsys-generate <system.qsys> --synthesis=VERILOG` options shown by that release's help. Keep the `.qsys`, Tcl source, `.sopcinfo`, generated wrapper, and Quartus project revision together.

## Validation sequence

1. Generate the system and resolve validation errors at their source.
2. Read generated HDL port names and `.sopcinfo` before writing a wrapper or BSP.
3. Check the generated address map and CPU reset/exception vector assignments.
4. Compile the enclosing Quartus project and inspect IP-generation warnings.
5. Regenerate the BSP after any hardware system change that affects memory, clocks, interrupts, or peripherals.

## References

- [Quartus II Handbook, Version 13.0, Volume 2 (command-line scripting/Qsys-era design)](https://cdrdv2-public.intel.com/653795/quartusii_handbook_archive_130.pdf)
- [Quartus II Handbook, Version 13.1 (Qsys scripting API)](https://cdrdv2-public.intel.com/653796/quartusii_handbook_archive_131.pdf)
- [Quartus Prime Standard Edition Platform Designer User Guide](https://www.intel.com/content/www/us/en/programmable/technical-pdfs/683364.pdf)
- [Platform Designer qsys-script guidance](https://docs.altera.com/r/bK2~2hJNzEOPcq7GSHCzGA/K7_KzY5yWDwfuzJRNfUlqg)
