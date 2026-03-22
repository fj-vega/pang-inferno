# Bootstrap

Use this checklist when turning the starter pack into a runnable Godot project.

## Prerequisites

- Godot 4 stable installed
- `godot` available on `PATH`, `godot4` available on `PATH`, or `GODOT` set to the executable path
- A chosen game concept in `docs/PRD.md`

## Environment Check

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\check-godot.ps1
```

## First Project Tasks

1. Create `project.godot`
2. Create the main scene under `scenes/`
3. Define initial input actions in project settings
4. Add the smallest runtime scripts needed for the first playable loop
5. Update `docs/STRUCTURE.md`
6. Run headless validation

## Validation Commands

```powershell
godot --headless --import
godot --headless --quit
```

If `godot` is not on `PATH`, run the executable directly or set `GODOT` first.
