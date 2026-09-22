# Quartus projects, pins, and timing

## Project inventory

Quartus projects are normally rooted in a `.qpf` project file and one or more `.qsf` revision settings files. The active revision determines the top-level entity, target part, HDL sources, SDC files, IP files, and build settings. Read these before editing. Check `PROJECT_REVISION`, `TOP_LEVEL_ENTITY`, `FAMILY`, `DEVICE`, and `SDC_FILE`; do not silently substitute a similar package or board.

The `.qsf` is Tcl-like assignment syntax. Prefer an explicit assignment for the named signal and I/O standard. Use bus indices that match the HDL port exactly. A QSF imported from a board reference project may contain thousands of unrelated assignments; copy only the used ports unless preserving the whole known-good board setup is required.

## Pin assignment workflow

1. Identify the exact board model and hardware revision from the board label/manual.
2. Identify the FPGA part from that board revision's schematic or official board manual.
3. Obtain the pin table or starter QSF for that same board revision from the board vendor.
4. Match top-level HDL ports to board signals; confirm active-low buttons, display segment ordering/polarity, and width.
5. Add `set_location_assignment` and `IO_STANDARD` assignments. Do not constrain internal Platform Designer wires as package pins.
6. Compile and inspect Pin Planner / fitter reports for missing or conflicting I/O assignments.

Never guess package pins from an FPGA family, another board, a pinout image, or an old project with a different revision. The DE1-SoC and DE2 have different device families and pin maps; “DE2” can also be confused with DE2-115. Ask for the exact board when it is not known.

### Small example

This is a format example only. Validate each package pin against the exact board revision before use.

```tcl
set_location_assignment PIN_AF14 -to CLOCK_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50
set_location_assignment PIN_AA14 -to KEY[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[0]
```

For buses, use one location assignment per bit, for example `-to HEX0[0]`. Seven-segment displays are commonly active-low; confirm whether the top-level design exports decoded segments or a binary digit. Do not assign a PIO's internal bus to physical pins when only a display port is intended.

## Timing constraints

Use an SDC file for clocks and external timing. A 50 MHz board clock has a 20 ns period:

```tcl
create_clock -name CLOCK_50 -period 20.000 [get_ports {CLOCK_50}]
derive_clock_uncertainty
```

Declare clocks that actually enter the FPGA. Do not create clocks on generated or unrelated inputs merely to silence timing warnings. Read the TimeQuest report and distinguish unconstrained paths from design errors.

## Official references

- [Quartus Prime Project Settings File Reference](https://www.intel.com/content/www/us/en/programmable/quartushelp/18.1/reference/glossary/def_qsf.htm)
- [Quartus Prime Timing Analyzer documentation](https://www.intel.com/content/www/us/en/docs/programmable/683243/21-3/timing-analyzer.html)
- [Terasic DE1-SoC product page and resources](https://www.terasic.com.tw/cgi-bin/page/archive.pl?CategoryNo=167&Language=English&No=836)
- [Terasic DE2 product page](https://www.terasic.com.tw/cgi-bin/page/archive.pl?CategoryNo=53&Language=English&No=30)
- [Terasic DE1-SoC User Manual](https://community.altera.com/t5/s/jgyke29768/attachments/jgyke29768/fpga-device/73098/1/DE1-SoC_User_manual_revf.pdf)
