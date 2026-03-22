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

- Status: `pending`
- Depends on:
- Goal: Confirm Godot availability, create the initial project, and establish the main scene.
- Player value: The project becomes runnable and ready for gameplay work.
- Targets: `project.godot`, `scenes/`, `scripts/`, `docs/STRUCTURE.md`
- Verify: Godot opens the project and `godot --headless --quit` completes without script errors.
- Notes: Use placeholder art and minimal systems only.

### 2. Core Loop Slice

- Status: `pending`
- Depends on: `1. Environment and Bootstrap`
- Goal: Implement the smallest playable loop described in the PRD.
- Player value: There is something playable, not just a shell.
- Targets:
- Verify: A tester can perform the core loop from start to finish at least once.
- Notes: Favor fake content over missing interaction.

### 3. UX and Feedback Pass

- Status: `pending`
- Depends on: `2. Core Loop Slice`
- Goal: Add basic UI, feedback, juice, and clarity for the MVP loop.
- Player value: The game becomes understandable and satisfying enough to evaluate.
- Targets:
- Verify: The player can understand state, goals, and outcomes without explanation.
- Notes: Use temporary assets if needed.
