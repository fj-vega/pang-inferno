---
name: godogen-orchestrator
description: Coordinate creation or expansion of a Godot 4 game inside a Codex-managed repository. Use when Codex is asked to build a game from a natural language description, create the PRD and plan, define architecture, or manage multi-step game implementation while keeping project documentation in sync.
---

# Godot Orchestrator

Use this playbook to turn a game idea into an ordered implementation workflow.

## Read First

Read these files if they exist:

- `AGENTS.md`
- `docs/PRD.md`
- `docs/PLAN.md`
- `docs/STRUCTURE.md`
- `docs/ASSETS.md`
- `docs/MEMORY.md`
- `docs/GODOT_NOTES.md`

## Outputs To Maintain

- `docs/PRD.md`
- `docs/PLAN.md`
- `docs/STRUCTURE.md`
- `docs/ASSETS.md`
- `docs/MEMORY.md`

## Workflow

1. Clarify or infer the game concept.
2. Write or update the PRD.
3. Break the work into small, testable tasks in `docs/PLAN.md`.
4. Define scene, script, input, and autoload architecture in `docs/STRUCTURE.md`.
5. Identify asset ownership and sourcing in `docs/ASSETS.md`.
6. Execute one task at a time.
7. After each task, validate locally and record discoveries in `docs/MEMORY.md`.

## Task Rules

- Prefer a playable vertical slice over broad incomplete systems.
- Keep tasks concrete enough that a later Codex run can verify them.
- Replan when architecture changes invalidate old tasks.
- Keep documents aligned with the codebase as you go.

## Godot-Specific Guidance

- Favor scene composition over monolithic scripts.
- Prefer signals to reduce coupling across systems.
- Organize assets near the scenes that own them when practical.
- Keep autoloads scarce and intentional.

## Constraints

- Assume Codex is the agent runtime.
- Do not rely on Claude-specific skill invocation or agent syntax.
- Treat automated image generation and automated visual QA as optional extensions, not default dependencies.
- If Godot is unavailable locally, document the validation gap explicitly.
