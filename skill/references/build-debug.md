# Compilation, programming, and error handling

## Identify and run the matching compiler

Run tools from the Quartus release that owns the project and generated IP. On Windows, use the Quartus command shell or the explicit install path. On Linux, use the corresponding `quartus/bin` tools and environment. A standard batch compile is:

```sh
quartus_sh --flow compile <project_name>
```

Do not compile by passing an arbitrary HDL file when the intended build is a QPF revision with QSF, SDC, Qsys, and IP inputs. Select the revision explicitly when a project has multiple revisions, using that release's documented flow syntax.

For JTAG programming, the Quartus Programmer CLI is `quartus_pgm`; enumerate cables before specifying a cable index. A typical flow is:

```sh
quartus_pgm -l
quartus_pgm -c 1 --auto
quartus_pgm -c 1 -m jtag -o "p;output_files/<project>.sof"
```

Shell quoting differs between Windows `cmd.exe`, PowerShell, and POSIX shells. Confirm `quartus_pgm --help` and preserve the exact cable name/index and programming operation for the installed release.

## Diagnose from evidence

When a command fails:

1. Record the tool version and full command.
2. Read the first fatal/error message and the referenced log (for example `.map.rpt`, `.fit.rpt`, `.sta.rpt`, Qsys generation log, BSP log).
3. Trace the message to the exact source setting, IP parameter, HDL declaration, device file, or unsupported version.
4. Make the smallest correction that addresses that cause.
5. Rerun the failed stage, then the required downstream stages. Do not claim success from a partial stage.

Treat warnings according to their effect: distinguish fatal compilation, missing device support, license restrictions, unconstrained timing, unused pins, and harmless legacy warnings. Do not blanket-suppress warnings or alter pin locations to silence them.

Common issues and checks:

- **Part not found:** verify the correct device support pack is installed for the same Quartus release and exact device suffix.
- **Unknown IP/component:** verify component catalog paths, exact component version, and whether the installed Quartus edition contains that IP.
- **Qsys generation failure:** inspect the generated system log, clocks, resets, interfaces, Avalon widths, address collisions, and CPU vectors.
- **BSP/application build failure:** verify `.sopcinfo` matches the current generated system, CPU instance name, BSP target, HAL drivers, and shell environment.
- **Unassigned pin or I/O standard:** connect every used top-level board port to the exact board/revision pin table; leave genuinely unused FPGA pins under the project's intended unused-pin policy.
- **Timing failure:** verify the SDC clock period/port names and inspect the failing path; do not relax a constraint without understanding the requirement.
- **Programming failure:** confirm USB Blaster driver/cable detection, JTAG chain, device image, and board power/mode switches.

## Official references

- [Quartus II 13.0 command-line scripting chapter](https://cdrdv2-public.intel.com/653795/quartusii_handbook_archive_130.pdf)
- [Quartus FPGA installation and licensing support](https://www.intel.com/content/www/us/en/support/programmable/licensing/installation-and-licensing.html)
- [Quartus II 13.0sp1 Web Edition archive](https://www.altera.com/downloads/fpga-development-tools/quartus-ii-web-edition-design-software-version-13-0sp1-windows)
