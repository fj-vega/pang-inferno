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

### 2026-03-23 - Combat Foundation Added

- Context: After bootstrap, the next smallest vertical slice was real player combat and survivability rather than more placeholder structure.
- Discovery: A simple loop of player firing, projectile hits, enemy defeat, contact damage, and HUD health feedback is enough to move the project from bootstrap into an actual combat prototype.
- Decision: Keep firing scene-local for now by having the player emit shot requests and the main game-flow scene spawn projectiles.
- Follow-up: Add enemy split or mutation behavior, score tracking, and stronger round-state transitions in the next slice.

### 2026-03-23 - Enemy Split And Score Layer

- Context: The combat slice still lacked the signature Pang-like escalation and any visible score reward.
- Discovery: One rank-based split rule plus score feedback already makes fights feel much closer to the intended loop, even before broader wave or boss systems exist.
- Decision: Keep split spawning in `game_flow.gd` for now as a lightweight orchestration step instead of introducing separate evolution and score managers too early.
- Follow-up: Add mutation or alternate enemy states, then introduce spawn pacing so the arena stays populated without hand-placed enemies.

### 2026-03-23 - Spawn Pacing And First Power-Up

- Context: After split behavior and score existed, the arena still depended too much on a fixed starting enemy and placeholder pickup placement.
- Discovery: Periodic enemy spawns plus a single timed rapid-fire pickup make the run feel substantially more alive without needing a full wave system yet.
- Decision: Keep both spawn pacing and power-up spawning inside `game_flow.gd` for now, and use a temporary rapid-fire boon as the first dark fantasy flavored upgrade effect.
- Follow-up: Add more upgrade variety, replace the temporary placeholder boon naming and presentation with stronger dark fantasy flavor, and introduce mutation or boss pressure on top of the pacing loop.

### 2026-03-23 - Enemy Mutation State

- Context: The evolution slice still lacked a true mutation behavior even after split mechanics were working.
- Discovery: Letting low-rank enemies mutate in-place after surviving for a few seconds creates meaningful pressure without requiring a separate enemy scene or a one-off boss-like script.
- Decision: Keep mutation as a lightweight state transition inside `enemy_base.gd` for now, driven by survival time, movement-speed escalation, score increase, and a visual color shift.
- Follow-up: Add more upgrade variety for the player, then move toward boss timing and boss victory flow so the round has a real climax.
