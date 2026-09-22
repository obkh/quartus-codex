---
name: quartus-codex
description: Build, edit, compile, or debug Intel/Altera Quartus FPGA projects, Platform Designer systems, and Nios II or Nios V software. Use when working in a Quartus project or with QPF/QSF/QSYS/SOPCINFO/SDC files; not for unrelated HDL-only work without Quartus.
metadata:
  short-description: Quartus FPGA project operating manual
---

# Quartus Codex operating manual

Use this skill when a task touches Quartus projects, Platform Designer/Qsys, FPGA pin constraints, or Nios software. Treat the installed Quartus release, project revision, target part, board revision, and processor generation as explicit inputs. Never infer pin locations, IP versions, generated module names, or software tools from a different board or Quartus release.

Start by reading the nearest `AGENTS.md`, then inspect the project files and tool installation. Identify the project `.qpf` revision, `.qsf` target family and part, `.qsys` or `.sopc` systems, HDL top-level entity, SDC clocks, device support pack, and compile logs. Preserve existing project conventions and user changes.

Choose the matching workflow below and read its reference before making version-sensitive edits:

- Quartus project, pin, and timing constraints: [references/quartus-projects.md](references/quartus-projects.md)
- Platform Designer/Qsys and Tcl systems: [references/platform-designer.md](references/platform-designer.md)
- Nios II legacy hardware/software tools: [references/nios-ii.md](references/nios-ii.md)
- Nios V hardware/software tools: [references/nios-v.md](references/nios-v.md)
- Compilation, programming, and error triage: [references/build-debug.md](references/build-debug.md)
- Focused Tcl and pin-assignment examples: [examples/](examples/)

Prefer the exact installed toolchain and its local `--help` output. For current support claims or an undocumented/version-specific behavior, verify with the official Altera/Intel documentation for that release. Examples are starting points, not board definitions; check all values against the project's target and authoritative board resources.

Do not downgrade or upgrade a project, regenerate IP, overwrite a generated BSP, change physical pins, or alter licensing settings as an incidental cleanup. Make the requested change and keep generated output reproducible. When an operation fails, preserve the first meaningful error, inspect the corresponding log and source configuration, identify a concrete cause, then make the smallest correction and rerun the relevant command. Report actual build/program results separately from static review.
