# Memory

Use this file for discoveries that future tasks should not have to rediscover.

## Entry Template

### YYYY-MM-DD - Topic

- Context:
- Discovery:
- Decision:
- Follow-up:

## Entries

### 2026-03-22 - Initial Game Definition

- Context: The initial repo was the `codex-godot-starter` template with no `project.godot` yet and no specific game concept filled in.
- Discovery: The game concept is now a 2D top-down survival shooter inspired by Pang, Super Pang, and Vampire Survivors, with enemies behaving like ricocheting balls that can split or mutate.
- Decision: The first target is a playable but expandable MVP centered on a single 5-minute round, dark fantasy presentation, score chasing, power-ups, and a final boss.
- Follow-up: Bootstrap the Godot project once the engine is available locally, then implement the smallest vertical slice around movement, shooting, enemy bounce, enemy evolution, and boss timing.

### 2026-03-22 - Environment Blocker

- Context: The project startup checklist requires a local Godot 4 executable.
- Discovery: Running `tools/check-godot.ps1` failed because Godot was not found through `PATH`, `godot4`, or the `GODOT` environment variable in this environment.
- Decision: Documentation and architecture planning can proceed now, but engine validation and scene bootstrap remain blocked until Godot is installed or configured.
- Follow-up: Install Godot 4 stable or set the `GODOT` environment variable to the executable path, then create `project.godot` and run headless validation.

### 2026-03-22 - Environment Unblocked

- Context: The project could not move from planning into implementation until Godot was callable from the repo environment.
- Discovery: Setting `GODOT` to `C:\Software\Godot_v4.6.1-stable_win64_console.exe` made validation commands work reliably in Windows shell sessions.
- Decision: Use the console executable for project automation and headless checks instead of the GUI executable.
- Follow-up: Use `tools/check-godot.ps1` plus `godot --headless --quit` as the default validation path.

### 2026-03-22 - Bootstrap Completed

- Context: The repo started as a documentation-first starter with no runnable Godot project.
- Discovery: A minimal bootstrap with `project.godot`, a main scene, player scene, enemy placeholder, power-up placeholder, HUD, and headless validation is enough to turn the repo into a real playable foundation.
- Decision: The first bootstrap keeps keyboard and controller input setup in the startup script so the project is immediately playable without blocking on manual input-map editing.
- Follow-up: Build the combat foundation next and decide later whether to keep input bootstrap in code or serialize the final input map directly into `project.godot`.
