# Plan

Use this file as the ordered implementation backlog.

## Status Legend

- `pending`
- `in_progress`
- `done`
- `blocked`
- `skipped`

## Planning Rules

- Prefer vertical slices over broad unfinished systems.
- Keep each task concrete enough to verify.
- Replan when new information invalidates the original order.
- Update task status as work progresses.

## Task Template

### N. Task Name

- Status: `pending`
- Depends on:
- Goal:
- Player value:
- Targets:
- Verify:
- Notes:

## Starter Backlog

### 1. Environment and Bootstrap

- Status: `done`
- Depends on:
- Goal: Confirm Godot availability, create the initial project, and establish the main scene for Pang Inferno.
- Player value: The project becomes runnable and ready for gameplay work.
- Targets: `project.godot`, `scenes/`, `scripts/`, `docs/STRUCTURE.md`
- Verify: Godot opens the project and `godot --headless --quit` completes without script errors.
- Notes: Godot is configured, the initial project bootstrap is complete, and `godot --headless --quit` now succeeds.

### 2. Core Loop Slice

- Status: `done`
- Depends on: `1. Environment and Bootstrap`
- Goal: Implement one playable 5-minute round with top-down movement, shooting, bouncing enemies, splitting behavior, scoring, and a boss phase.
- Player value: There is something playable, not just a shell.
- Targets: `scenes/main/`, `scripts/player/`, `scripts/enemies/`, `scripts/systems/`
- Verify: A tester can survive, kill enemies, trigger splits or mutations, collect at least one power-up, and reach the boss phase.
- Notes: Player combat, enemy splitting, score tracking, spawn pacing, three distinct upgrade effects, enemy mutation, boss victory flow, and first-pass run readability are now in place. Stronger thematic polish remains a key next layer.

### 3. UX and Feedback Pass

- Status: `done`
- Depends on: `2. Core Loop Slice`
- Goal: Add HUD, combat feedback, power-up readability, boss alerts, and stronger dark fantasy presentation cues for the MVP loop.
- Player value: The game becomes understandable and satisfying enough to evaluate.
- Targets: `scenes/ui/`, `assets/`, `docs/ASSETS.md`
- Verify: The player can understand state, goals, and outcomes without explanation.
- Notes: The HUD now exposes phase, objective, boon state, controls, low-health pressure, and clearer boss/victory messaging. The next presentation pass should focus more on thematic visuals than raw comprehension.

### 4. Enemy Evolution System

- Status: `pending`
- Depends on: `2. Core Loop Slice`
- Goal: Formalize the rank, split, and mutation rules so enemy escalation is easy to expand without rewriting the combat loop.
- Player value: Encounters become more surprising and replayable while staying coherent.
- Targets: `scripts/enemies/`, `docs/STRUCTURE.md`, `docs/MEMORY.md`
- Verify: At least three enemy states can transition cleanly through death, split, or mutation rules without script duplication.
- Notes: Prefer data-driven tuning where practical.

### 5. Power-Up and Weapon Flavor Pass

- Status: `done`
- Depends on: `2. Core Loop Slice`
- Goal: Add a first set of dark fantasy upgrades that make the run feel like steel-and-sorcery instead of abstract arcade combat.
- Player value: Players get expressive build choices and stronger thematic identity.
- Targets: `scripts/powerups/`, `docs/ASSETS.md`, `docs/PRD.md`
- Verify: At least three distinct upgrade effects are available and clearly noticeable during a run.
- Notes: The current MVP now frames the base weapon as the Ashen Pike, gives boon pickups distinct relic silhouettes and labels, and dresses the arena in a ritual black-iron look without changing the underlying combat rules.
