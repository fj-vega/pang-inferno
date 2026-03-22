---
name: godot-task
description: Execute a single Godot 4 implementation task in a Codex-managed project. Use when Codex needs to create or edit scenes, scripts, input actions, autoloads, or task-specific validation for one scoped gameplay, UI, or systems change.
---

# Godot Task Executor

Use this playbook when handling one task from `docs/PLAN.md`.

## Read First

Read these files before changing code:

- `docs/PLAN.md`
- `docs/STRUCTURE.md`
- `docs/MEMORY.md`
- `docs/GODOT_NOTES.md`

Read `docs/ASSETS.md` if the task touches imported resources.

## Workflow

1. Identify the target files and verification goal.
2. Update scenes first when node structure drives script attachment.
3. Update scripts and input/autoload wiring second.
4. Import assets if new resources were added or import settings changed.
5. Run headless validation.
6. Record any noteworthy discoveries in `docs/MEMORY.md`.

## Validation Commands

Use the strongest applicable local command:

```bash
godot --headless --import
godot --headless --quit
```

Add a task-specific harness in `tests/` when broad validation is not enough.

## Implementation Preferences

- Prefer small, readable GDScript files.
- Keep scene ownership obvious.
- Prefer signals for decoupled interactions.
- Prefer scene unique nodes for stable same-scene references.
- Use groups or autoloads for cross-scene access when needed.
- Avoid hiding game logic inside massive scene files.
- Favor deterministic setup that can be rebuilt.

## Asset Rules

- Track source assets and their import metadata.
- Keep `.import` files.
- Do not treat `.godot/` as durable project state.

## Porting Notes

This is adapted from a Claude-oriented workflow. Keep the execution discipline, but do not assume:

- automatic sub-agent fanout
- Gemini-based screenshot analysis
- Tripo3D asset generation
- Teleforge or chat bridge integration
