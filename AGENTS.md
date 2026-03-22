# Codex Game Project Guide

This repository uses Codex as the primary agent and Godot 4 stable as the target engine.

## Mission

Build the game in layers:

1. define the concept clearly
2. create a playable foundation
3. grow the project without losing architecture or documentation quality

## Working Files

Treat these files as the shared project memory:

- `docs/PRD.md`: product goals, audience, pillars, loop, scope
- `docs/PLAN.md`: ordered tasks, dependencies, verification targets
- `docs/STRUCTURE.md`: scenes, scripts, autoloads, input actions, signal boundaries
- `docs/ASSETS.md`: asset ownership, source, status, license, import notes
- `docs/MEMORY.md`: discoveries, decisions, pitfalls, workarounds
- `docs/GODOT_NOTES.md`: distilled engine conventions from official docs
- `docs/INTAKE.md`: minimum human-provided context required before building a real game from a vague prompt

Update them as part of the work, not as a cleanup task for later.

## Startup Checklist

Before substantial implementation:

1. Read `docs/PRD.md`, `docs/PLAN.md`, `docs/STRUCTURE.md`, and `docs/MEMORY.md` if they exist.
2. If the project is new, create or refresh those docs before writing a lot of code.
3. If the request is vague, check `docs/INTAKE.md` and request the missing minimum context before implementation.
4. Confirm Godot is available through `PATH` or `GODOT`. Use `tools/check-godot.ps1` on Windows.
5. Pick one coherent task and finish it fully before moving on.

## Repo Layout

Use these directories by default:

- `scenes/` for scene entry points and scene-owned subfolders
- `scripts/` for shared runtime logic and systems
- `assets/` for shared assets or raw source art that is reused broadly
- `tests/` for task-specific verification harnesses
- `tools/` for developer-side scripts, not game runtime code

As the project grows, favor feature ownership over giant global buckets. Official Godot guidance recommends keeping assets close to the scenes that use them when practical.

## Godot Architecture Conventions

- Target Godot 4.
- Prefer composition with scenes and nodes over monolithic scripts.
- Keep autoloads rare and reserve them for truly global state or services.
- Prefer signals for communication between independent systems to reduce coupling.
- Prefer scene unique nodes for stable same-scene references when direct child paths become brittle.
- Use groups or autoloads for cross-scene discovery when scene unique nodes are not appropriate.
- Keep scenes small enough that ownership is obvious.

## GDScript Conventions

Follow official GDScript style guidance unless the project has a stronger local reason not to:

- use `snake_case` for variables and functions
- use `PascalCase` for class names and scene-like types
- use `ALL_CAPS` for constants
- use LF line endings and UTF-8
- use tabs for indentation in `.gd` files
- keep code ordered so signals and properties appear before methods

## Validation

Use the strongest local check that fits the task:

- `godot --headless --import` after adding or changing imported assets
- `godot --headless --quit` for broad script and project validation
- task-specific harnesses in `tests/` when a general parse check is not enough

If Godot is unavailable in the environment, stop short of pretending validation happened. Record the blocker and describe what remains unverified.

## Version Control Rules

- Commit `.import` files created next to imported assets.
- Do not commit the `.godot/` cache directory.
- Do not delete generated import metadata casually; it carries import settings.
- Keep documentation and code changes aligned in the same working session whenever possible.

## Model and Tooling Constraints

This project is adapted from a Claude-oriented workflow, but this repository assumes:

- Codex is the coding agent
- OpenAI models are the only guaranteed model family
- `AGENTS.md` replaces `CLAUDE.md`
- external image or 3D generation services are optional extensions, not core dependencies

## Local Playbooks

Project-local playbooks live under `codex-skills/`. They are written in Codex skill format so they can be installed later if useful, but they are also readable as plain project guidance inside the repo.
