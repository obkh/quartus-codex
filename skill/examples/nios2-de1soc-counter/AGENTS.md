# DE1-SoC Nios II counter

This example targets the Terasic DE1-SoC, Cyclone V 5CSEMA5F31C6, with Quartus II 13.0 and legacy Nios II. Read the repository [Quartus Codex skill](../../SKILL.md) and the [Nios II](../../references/nios-ii.md), [Platform Designer](../../references/platform-designer.md), and [build/debug](../../references/build-debug.md) references before version-sensitive changes.

- Preserve the selected part, top-level entity, board pin map, and 20 ns clock constraint unless the target is explicitly changed.
- Edit `nios_counter_system.tcl` and regenerate Qsys output; do not patch generated system HDL or BSP files by hand.
- `software/bsp` is generated from `nios_counter_system.sopcinfo`; regenerate it after hardware changes.
- Keep `interval_timer` out of the HAL system-clock role because `software/counter/src/main.c` polls it directly. Create the BSP with `--default_sys_timer none`.
- Build in the Nios II Command Shell using the commands in `README.txt`.
- Quartus II 13.0.0 Build 156 completed synthesis and fitting here but emitted no programming file for this Cyclone V part. Confirm a `.sof` exists before attempting to program the board.
