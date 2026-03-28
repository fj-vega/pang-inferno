# Pang Inferno

Pang Inferno is a 2D top-down dark fantasy arena survival shooter built in Godot 4.

This repo was just meant to be a vibe coding experiment: take a starter, build a small playable idea quickly, and see how far a Codex-driven Godot workflow could push a focused arcade prototype.

The game mixes the ricochet threat pattern of Pang with the escalating survival pressure of Vampire Survivors. You control a mobile hunter in a cursed arena, dodge infernal enemies that rebound across the battlefield, collect power-ups, and survive long enough to face a final boss.

## Game Pillars

- Movement and positioning matter as much as offense because enemies ricochet unpredictably.
- Enemy kills reshape the encounter through splitting and mutation.
- Weapons and power-ups should feel like steel-and-sorcery, not generic arcade sci-fi.

## Current Scope

The current MVP target is:

- one top-down 2D arena
- omnidirectional player movement
- shooting-based combat
- ricocheting enemies
- enemy split or mutation behavior
- score and round timer
- dark fantasy power-ups
- a final boss near the end of a 5-minute round

Out of scope for the first playable:

- multiple stages or biomes
- story campaign structure
- online multiplayer
- meta-progression between runs
- final art and audio polish

## Current Project Status

The repo is no longer just a starter template. It now includes:

- a runnable Godot project via [project.godot](/E:/My%20Documents/coding/pang-inferno/project.godot)
- a bootstrap main scene in [scenes/main/Main.tscn](/E:/My%20Documents/coding/pang-inferno/scenes/main/Main.tscn)
- starter player, enemy, power-up, HUD, and game-flow scripts
- headless validation support through Godot CLI and GitHub Actions

Current state in plain terms:

- playable single-round MVP
- keyboard/controller fire support
- mouse aiming support
- dark fantasy placeholder presentation
- still rough and intentionally incomplete in polish, content, and feel

Known limitation:

- mouse firing was attempted during development and discarded after unreliable behavior in playtesting

The current bootstrap already opens and validates cleanly with:

```powershell
& $env:GODOT --headless --path . --quit
```

## Local Setup

1. Install Godot 4 stable.
2. Make Godot available through `PATH` or set the `GODOT` environment variable.
3. Verify the setup:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\check-godot.ps1
```

4. Run headless validation:

```powershell
& $env:GODOT --headless --path . --quit
```

5. Open the project in Godot:

```powershell
& $env:GODOT --path .
```

## Workflow

This repo uses a PR-first workflow for non-trivial work.

- one small vertical slice per PR by default
- required CI validation before merge
- docs updated alongside code
- implementation tracked through `docs/PLAN.md` and `docs/IMPLEMENTATION_CHECKLIST.md`

Important project docs:

- `AGENTS.md`: project working agreement for coding agents
- `docs/PRD.md`: game vision, scope, and design pillars
- `docs/PLAN.md`: ordered implementation backlog
- `docs/IMPLEMENTATION_CHECKLIST.md`: concrete slices and done conditions
- `docs/STRUCTURE.md`: scene and system architecture
- `docs/MEMORY.md`: implementation discoveries and decisions
- `docs/ASSETS.md`: asset planning and ownership
- `docs/FINAL_STATE.md`: final MVP snapshot, controls, limitations, and discarded ideas

## Repository Layout

- `scenes/`: scene entry points and scene-owned content
- `scripts/`: runtime gameplay code and systems
- `assets/`: shared visual, audio, and other game assets
- `tests/`: focused verification harnesses and test scenes
- `tools/`: developer-side helper scripts
- `.github/`: CI workflow plus PR and issue templates

## Validation

Primary validation paths:

- `powershell -ExecutionPolicy Bypass -File .\tools\check-godot.ps1`
- `& $env:GODOT --headless --path . --quit`

GitHub Actions also runs the reusable required check:

- `CI / validate`

## References

- [Godot stable documentation](https://docs.godotengine.org/en/stable/)
- [Project PRD](/E:/My%20Documents/coding/pang-inferno/docs/PRD.md)
- [Implementation checklist](/E:/My%20Documents/coding/pang-inferno/docs/IMPLEMENTATION_CHECKLIST.md)
