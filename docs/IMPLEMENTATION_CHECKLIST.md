# Pang Inferno - Implementation Checklist

Last updated: 2026-03-22

## How To Use This Checklist

1. Complete slices in order unless a dependency is explicitly cleared first.
2. Each task should be small enough to verify without guesswork.
3. Mark a task done only when its stated done condition is met.
4. Keep `docs/PLAN.md`, `docs/STRUCTURE.md`, and `docs/MEMORY.md` aligned as work lands.

## Locked Decisions

1. Engine: Godot 4 stable.
2. Game format: 2D top-down arena survival action.
3. Core round length: 5 minutes.
4. Main platform: PC.
5. Primary inputs: keyboard and controller.
6. Core identity: ricocheting enemies, split or mutation escalation, dark fantasy weapons and power-ups, final boss.
7. Default implementation preference: scene composition, signals, and small feature-owned scripts over giant global systems.

## Immediate Project Setup

- [x] Define the game concept in `docs/PRD.md`.
      Done: Pang Inferno vision, scope, loop, and presentation are documented.

- [x] Create an ordered implementation plan in `docs/PLAN.md`.
      Done: Major slices, dependencies, and verification goals exist.

- [x] Record initial architecture direction in `docs/STRUCTURE.md`.
      Done: Planned scenes, systems, input actions, and signal boundaries are documented.

- [x] Verify Godot availability for this environment.
      Done: `tools/check-godot.ps1` resolves `GODOT` successfully.

## Repository Governance Setup

- [ ] Configure GitHub branch protection for the default branch.
      Done: PR required, status checks required, and direct pushes restricted.

- [x] Add a PR template.
      Done: Pull requests must report slice, validation, docs impact, and risk notes.

- [x] Add issue templates.
      Done: Bugs and feature requests follow a consistent structure.

- [x] Add CI workflow for baseline validation.
      Done: Pull requests run the configured validation workflow automatically.

- [ ] Require CI checks before merge in GitHub settings.
      Done: The GitHub repository blocks merge until required checks pass.

- [ ] Add AI-assisted PR helpers only after CI is stable.
      Done: AI assistance does not bypass required checks or review.

## Slice 1 - Project Bootstrap

- [x] Create `project.godot` and set the main scene.
      Done: The project opens and `godot --headless --quit` succeeds.

- [x] Define initial input actions for keyboard and controller.
      Done: Movement, fire, aim, and pause inputs exist for keyboard and controller through the bootstrap scene initialization.

- [x] Create the core scene skeleton.
      Done: Main scene, player scene, enemy base scene, power-up pickup scene, and HUD scene exist with valid script attachments.

- [x] Add the smallest run loop bootstrap.
      Done: Launching the main scene shows an arena with a controllable player and no script errors.

## Slice 2 - Player Combat Foundation

- [x] Implement omnidirectional movement.
      Done: The player can move smoothly in all directions with keyboard and controller.

- [x] Implement initial aiming and firing behavior.
      Done: The player can reliably attack in a defined direction with a simple starter weapon.

- [x] Add basic player health and defeat handling.
      Done: The player takes damage, can die, and the run ends cleanly on death.

- [x] Add a minimal projectile or hit system.
      Done: Player attacks can damage enemies in a repeatable, testable way.

## Slice 3 - Enemy Bounce and Evolution

- [x] Implement a base ricochet enemy.
      Done: An enemy moves, bounces against arena bounds, and damages the player on contact.

- [x] Implement enemy damage and death.
      Done: Enemy defeat is visible, scoreable, and free of script errors.

- [x] Implement at least one split behavior.
      Done: A higher-rank enemy can spawn smaller successors on defeat.

- [ ] Implement at least one mutation behavior or state change.
      Done: An enemy can transition into a more dangerous state without bespoke one-off logic.

## Slice 4 - Round Flow and Scoring

- [x] Add a 5-minute round timer.
      Done: The HUD and game flow reflect the remaining round time accurately.

- [x] Add score tracking.
      Done: Defeating enemies increases score and the HUD updates correctly.

- [x] Add spawn pacing.
      Done: Enemies appear over time in a way that creates increasing pressure.

- [x] Add round-end conditions.
      Done: The game resolves cleanly on player death or timer survival for the current slice.

## Slice 5 - Power-Ups and Dark Fantasy Flavor

- [x] Add collectible power-up drops.
      Done: At least one pickup can appear and be collected during normal play.

- [ ] Implement at least three distinct upgrades.
      Done: Three upgrades have clearly different gameplay effects during a run.

- [ ] Tie weapons and power-ups to the dark fantasy theme.
      Done: Naming, visuals, and behavior feel steel-and-sorcery rather than generic arcade sci-fi.

## Slice 6 - Boss Phase

- [ ] Add boss spawn timing near the end of the round.
      Done: The boss phase begins consistently and communicates itself clearly.

- [ ] Implement one boss behavior set.
      Done: The boss has readable attack or movement patterns and interacts with the same combat rules where practical.

- [ ] Finalize boss victory flow.
      Done: Defeating the boss triggers a distinct win state.

## Slice 7 - UX and Readability Pass

- [ ] Add HUD essentials.
      Done: Health, timer, score, and boss phase are visible without explanation.

- [ ] Improve combat readability.
      Done: Hits, damage, pickups, and dangerous states are legible during heavy action.

- [ ] Improve first-run clarity.
      Done: A new tester can understand how to move, fight, survive, and win without verbal coaching.

## Validation Expectations

1. Use `godot --headless --quit` for broad project validation after meaningful script or scene changes.
2. Use `godot --headless --import` after adding imported assets when needed.
3. Add focused test scenes or harness scripts in `tests/` when a system benefits from repeatable verification.
4. Document manual verification steps when automated checks are not practical yet.
5. Treat bug fixes as incomplete without a regression check when practical.

## Exit Criteria For The First Playable

- [ ] The project boots cleanly from `project.godot`.
- [ ] The player can move, shoot, survive, and die.
- [ ] Enemies ricochet, take damage, and at least one enemy type splits or mutates.
- [ ] Score, timer, and at least one power-up are working.
- [ ] A boss appears and can be defeated.
- [ ] The game reads clearly enough to playtest without explanation.
