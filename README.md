# Codex Godot Starter Pack

This repository is a Codex-native Godot starter pack adapted from ideas in [`htdt/godogen`](https://github.com/htdt/godogen), but trimmed to fit an OpenAI-only workflow.

It is meant to help us move in this order:

1. shape the game idea
2. build a playable base
3. document architecture and product intent as the game grows

## What This Repo Gives You

- a project-level agent contract in `AGENTS.md`
- a document-driven workflow in `docs/`
- project-local Codex playbooks in `codex-skills/`
- Godot-friendly repo defaults for version control and editing
- a small environment check in `tools/check-godot.ps1`

## Quick Start

1. Install Godot 4 stable and make it available through `PATH` or the `GODOT` environment variable.
2. Run `powershell -ExecutionPolicy Bypass -File .\tools\check-godot.ps1`
3. Fill in `docs/PRD.md`
4. Break the work into tasks in `docs/PLAN.md`
5. Capture architecture decisions in `docs/STRUCTURE.md`
6. Build one task at a time and record discoveries in `docs/MEMORY.md`

## Repository Layout

- `AGENTS.md`: Codex operating guide for this project
- `docs/`: PRD, plan, structure, assets, bootstrap notes, and memory
- `docs/INTAKE.md`: the checklist for turning a vague game request into a buildable brief
- `codex-skills/`: local playbooks for orchestration and per-task Godot work
- `scenes/`: scene files and scene-local folders
- `scripts/`: runtime scripts and shared gameplay code
- `tests/`: task-specific harnesses and verification scenes/scripts
- `tools/`: developer-side helper scripts

## Godot Conventions In This Starter

- Prefer scene composition and feature ownership over giant scripts.
- Group assets as close to the scenes that own them as practical.
- Use signals to reduce coupling between systems.
- Use scene unique nodes for stable same-scene lookups when they help.
- Commit generated `.import` metadata files.
- Do not commit the `.godot/` cache directory.
- Use LF endings, UTF-8, and tabs for GDScript indentation.

## Current State

This starter pack does not create `project.godot` automatically yet. That is intentional for now:

- the current environment does not have `godot` on `PATH`
- the actual project bootstrap should follow the game concept we choose next

## Vague Request Workflow

If this repo is forked and someone says "build me a game about X", Codex should not guess past the safe point. It should first run the checklist in `docs/INTAKE.md`, ask only for the missing minimum context, then translate those answers into `docs/PRD.md` and `docs/PLAN.md`.

## References

- Official Godot docs notes captured in `docs/GODOT_NOTES.md`
- Stable docs homepage: [docs.godotengine.org/en/stable](https://docs.godotengine.org/en/stable/)
