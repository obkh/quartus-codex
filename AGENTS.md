# Quartus Codex repository instructions

When working in this repository or copying its guidance into a Quartus project:

- Read `skill/SKILL.md` and the relevant files in `skill/references/` before changing Quartus, Qsys/Platform Designer, pins, timing, or Nios software.
- Inspect the active `.qpf` revision, `.qsf`, top-level HDL, `.sdc`, `.qsys`/`.sopcinfo`, installed Quartus version, and target device before making edits.
- Treat board pin maps and IP component parameters as board- and tool-version-specific. Check the exact board revision and local IP definition; never derive pin locations from a related board or a different package.
- Keep generated HDL/BSP output distinct from editable source. Change the system source and regenerate generated files rather than patching generated HDL or headers.
- Separate Nios II (`nios2-elf-*`, Nios II SBT, legacy Qsys) from Nios V (RISC-V toolchain, newer Quartus/Platform Designer). Never use Nios V guidance for a Quartus II 13.x project.
- Use the installed tools and capture the full command and first meaningful error. Fix the source of the error and rerun the failed stage before reporting success.
- Preserve existing user files and project conventions. Do not change target parts, pins, revisions, device support, or toolchain versions as incidental cleanup.

The focused operating manual is in [`skill/`](skill/SKILL.md); begin with it rather than inferring a workflow from an unrelated example design.
