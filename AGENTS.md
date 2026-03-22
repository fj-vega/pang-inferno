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
- `docs/IMPLEMENTATION_CHECKLIST.md`: concrete, testable delivery slices and done conditions
- `docs/STRUCTURE.md`: scenes, scripts, autoloads, input actions, signal boundaries
- `docs/ASSETS.md`: asset ownership, source, status, license, import notes
- `docs/MEMORY.md`: discoveries, decisions, pitfalls, workarounds
- `docs/GODOT_NOTES.md`: distilled engine conventions from official docs
- `docs/INTAKE.md`: minimum human-provided context required before building a real game from a vague prompt

Update them as part of the work, not as a cleanup task for later.

## Source Of Truth

Before implementation work, align with:

1. `docs/PRD.md`
2. `docs/IMPLEMENTATION_CHECKLIST.md`
3. `docs/PLAN.md`
4. `docs/STRUCTURE.md`
5. `README.md`

If there is a conflict, use this precedence:

1. PRD
2. Implementation checklist
3. Plan
4. Structure
5. README

## Startup Checklist

Before substantial implementation:

1. Read `docs/PRD.md`, `docs/IMPLEMENTATION_CHECKLIST.md`, `docs/PLAN.md`, `docs/STRUCTURE.md`, and `docs/MEMORY.md` if they exist.
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

Testing is a delivery requirement, not an optional cleanup step:

- Every functional area should have a verification path, whether through headless project validation, test scenes, harness scripts, or a clearly documented manual check.
- Any bug fix should add a focused reproduction or regression check when practical.
- No feature is complete without acceptance criteria, relevant validation, and updated docs when behavior changed.

## Version Control Rules

- Commit `.import` files created next to imported assets.
- Do not commit the `.godot/` cache directory.
- Do not delete generated import metadata casually; it carries import settings.
- Keep documentation and code changes aligned in the same working session whenever possible.

## Pull Request Policy

Use a PR-first workflow for non-trivial changes.

1. Default unit of work:
   - One small checklist slice per PR.
2. Branching:
   - Work from short-lived branches.
   - Do not push directly to the default branch.
3. Merge policy:
   - PR review is required before merge.
   - Required checks must pass before merge.
   - Direct pushes to the default branch should be restricted in GitHub settings.
4. Required PR evidence:
   - Checklist item or slice covered.
   - Acceptance criteria addressed.
   - Validation run and results.
   - Risk notes or rollback considerations when relevant.
   - Docs updated when behavior, scope, or architecture changed.
5. Scope control:
   - Do not mix unrelated slices in one PR unless there is a clear dependency.
   - Prefer correctness and reviewability over batching many features together.
6. Automation policy:
   - CI should run on every PR.
   - AI-assisted summaries or review helpers may assist, but must not bypass required checks or human review.

## Delivery Workflow

Use this loop for all non-trivial work:

1. Plan
2. Pre-Implementation Review
3. Implementation
4. Post-Implementation Review
5. Validate and Close

### 1. Plan

1. Select a small vertical slice from `docs/IMPLEMENTATION_CHECKLIST.md` or `docs/PLAN.md`.
2. Define acceptance criteria and a validation approach before coding.
3. Identify risks, dependencies, and blockers.

### 2. Pre-Implementation Review

1. Check the slice against `docs/PRD.md` and `docs/STRUCTURE.md`.
2. Confirm scene ownership, input implications, and signal boundaries.
3. Resolve material ambiguities before writing code.

### 3. Implementation

1. Implement in small, reviewable increments.
2. Prefer scene composition and feature ownership over giant scripts.
3. Keep docs synchronized when scope or architecture shifts.

### 4. Post-Implementation Review

1. Review for correctness, regressions, readability, and maintainability.
2. Check that new logic fits the planned architecture and does not create hidden coupling.
3. Ensure no accidental scope drift beyond the selected slice.

### 5. Validate and Close

1. Run the strongest relevant validation available.
2. Update checklist status and any impacted docs.
3. Capture useful implementation context in `docs/MEMORY.md`.
4. Only then mark the task complete.

## Definition Of Done

A task or slice is done only when all of these are true:

1. Implementation matches the current PRD and selected checklist scope.
2. Code follows the architecture and style rules in this file.
3. Relevant validation has been run, or the specific blocker is documented clearly.
4. Error states and gameplay edge cases are handled to a reasonable MVP standard.
5. Related docs are updated if behavior, scope, or architecture changed.
6. Useful discoveries are captured in shared project docs.

## Context Capture

If useful project-level context is discovered at any point, document it.

What counts as useful context:

- architecture decisions and tradeoffs
- Godot-specific constraints or editor/runtime quirks
- non-obvious bug patterns and root causes
- performance findings that influence design or defaults
- tooling limitations and reliable workarounds
- gameplay tuning decisions that affect future implementation

Where to document it:

- product or scope decisions: `docs/PRD.md`
- implementation sequencing and progress: `docs/PLAN.md` or `docs/IMPLEMENTATION_CHECKLIST.md`
- architecture and ownership: `docs/STRUCTURE.md`
- assets, sourcing, and placeholder strategy: `docs/ASSETS.md`
- discoveries, pitfalls, and workarounds: `docs/MEMORY.md`

Do not leave important implementation knowledge only in code comments or chat history.

## Clarification Rule

If material context is missing and assumptions could cause incorrect implementation:

1. Pause before making the risky decision.
2. Ask for the missing context concisely.
3. Prefer clarification over building the wrong system.

Material context includes:

- gameplay behavior that would materially change the core loop
- ambiguous acceptance criteria or conflicting docs
- engine or environment constraints that affect implementation approach

## Autonomy

Use bounded autonomy:

1. Default to one small vertical slice at a time.
2. Proceed autonomously when acceptance criteria are clear and risk is low.
3. Escalate when a decision would meaningfully affect scope, architecture, or player expectations.

## Model and Tooling Constraints

This project is adapted from a Claude-oriented workflow, but this repository assumes:

- Codex is the coding agent
- OpenAI models are the only guaranteed model family
- `AGENTS.md` replaces `CLAUDE.md`
- external image or 3D generation services are optional extensions, not core dependencies

## Local Playbooks

Project-local playbooks live under `codex-skills/`. They are written in Codex skill format so they can be installed later if useful, but they are also readable as plain project guidance inside the repo.
