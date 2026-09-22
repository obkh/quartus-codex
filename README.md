# Quartus Codex

A reusable Codex skill and project-local operating manual for Intel/Altera FPGA projects. It covers Quartus project files and constraints, Platform Designer/Qsys Tcl, the separate Nios II and Nios V software flows, compilation/programming, and evidence-based error handling.

The skill is in [`skill/SKILL.md`](skill/SKILL.md). [`AGENTS.md`](AGENTS.md) gives project-local instructions. Detailed workflows are under `skill/references/`; concise, version-labelled Tcl and pin examples are under `skill/examples/`.

The skill is installed for this user at `~/.codex/skills/quartus-codex` as a link to this repository. Copy `AGENTS.md` into a Quartus project root when you want that project's local instructions to load regardless of skill selection.

Examples document or demonstrate patterns; always verify part, board revision, software release, IP version, and device support before reusing them.
