# Structure

Use this file to record the actual project layout and architecture decisions.

## Scenes

| Path | Role | Root Node | Notes |
|---|---|---|---|
| `scenes/main/Main.tscn` | Main gameplay scene for a single survival round | `Node2D` | Will own arena, spawners, player, enemies, pickups, and HUD hooks |
| `scenes/player/Player.tscn` | Player-controlled hunter | `CharacterBody2D` | Movement, aiming, shooting, damage intake |
| `scenes/enemies/EnemyBase.tscn` | Shared base enemy scene | `CharacterBody2D` | Supports bounce motion and rank-based evolution |
| `scenes/enemies/Boss.tscn` | Final boss encounter | `CharacterBody2D` | Spawned late in the 5-minute round |
| `scenes/powerups/PowerUpPickup.tscn` | Collectible upgrade or buff pickup | `Area2D` | Applies run effects on contact |
| `scenes/ui/HUD.tscn` | In-run UI | `CanvasLayer` | Shows health, timer, score, and boss phase |

## Scripts and Systems

| Path | Responsibility | Depends On | Notes |
|---|---|---|---|
| `scripts/player/player_controller.gd` | Player movement, aim, and firing | Input map, projectile logic | Should support keyboard and controller from the start |
| `scripts/player/player_health.gd` | Damage, death, and survivability rules | HUD, game flow | Keep health logic separate from movement |
| `scripts/enemies/enemy_base.gd` | Shared enemy movement, bounce behavior, split metadata, and mutation state | Arena bounds, evolution data | Core ricochet behavior and lightweight mutation rules live here |
| `scripts/enemies/enemy_evolution.gd` | Split and mutation rules by enemy rank | Enemy base, spawn system | Candidate for lightweight data-driven config |
| `scripts/enemies/boss_controller.gd` | Boss chase behavior, health, and defeat signaling | Main game flow, player target | Shares the same damage and score pipeline where practical |
| `scripts/projectiles/projectile.gd` | Player projectile motion and enemy hit delivery | Player firing, enemy damage | Minimal starter projectile for the first combat slice |
| `scripts/systems/game_flow.gd` | Round timer, score, enemy spawning, power-up spawning, boss-phase transitions, and run state | Player, enemy container, power-up container, HUD | Currently owns lightweight orchestration until larger systems split out |
| `scripts/systems/spawn_manager.gd` | Enemy spawn pacing and wave pressure | Enemy scenes, timer | Can start simple and expand later |
| `scripts/systems/score_manager.gd` | Score tracking and reward hooks | Enemy deaths, HUD | Autoload only if cross-scene reuse becomes necessary |
| `scripts/powerups/powerup_pickup.gd` | Pickup variant selection and collection signaling | Player body, game flow | Currently supports rapid fire, heal, and piercing shot boons |

## Autoloads

| Name | Path | Responsibility | Why Global |
|---|---|---|---|
| None yet | | | Keep the MVP scene-local unless global state becomes clearly necessary |

## Input Actions

| Action | Device | Purpose |
|---|---|---|
| `move_left` | Keyboard, controller | Move horizontally left |
| `move_right` | Keyboard, controller | Move horizontally right |
| `move_up` | Keyboard, controller | Move vertically up |
| `move_down` | Keyboard, controller | Move vertically down |
| `fire` | Keyboard, controller | Shoot current weapon |
| `aim_left` | Controller | Optional right-stick or directional aim left |
| `aim_right` | Controller | Optional right-stick or directional aim right |
| `aim_up` | Controller | Optional right-stick or directional aim up |
| `aim_down` | Controller | Optional right-stick or directional aim down |
| `dash` | Keyboard, controller | Reserved for a possible evasive skill if the loop needs it |
| `pause` | Keyboard, controller | Pause the round |

## Signal Boundaries

Record important event flow between scenes and systems here.

- Player emits damage, death, and power-up collection events to game flow and HUD systems.
- Enemies emit defeated, split_requested, and mutation_requested events to spawn or evolution systems.
- Game flow emits timer milestones and boss_phase_started so the HUD and spawner can react without tight coupling.
- Power-up pickups emit applied effects to player or combat systems instead of mutating unrelated nodes directly.
- Current implementation uses the enemy defeated signal to award score and spawn split children without tightly coupling the player or projectile logic to enemy branching.
- Current implementation also spawns enemies and timed power-up pickups from `game_flow.gd` to keep the MVP loop active before dedicated spawn or reward systems exist.
- Low-rank enemies can currently mutate in-place after surviving long enough, creating a reusable danger-state transition without bespoke enemy scenes.
- The current boss phase clears regular enemies, spawns a single boss late in the round, and swaps the encounter into a focused chase phase.
- Defeating the boss now resolves the run into a distinct victory state instead of falling through to generic timer survival.

## Node Access Strategy

- Prefer scene unique nodes for stable same-scene references.
- Prefer signals for decoupled cross-system communication.
- Prefer groups or autoloads when cross-scene discovery is truly needed.

## Notes

- Arena logic should define the bounce bounds clearly so enemy ricochet feels deliberate rather than glitchy.
- Enemy evolution is a signature system and should stay modular enough to support future enemy types without rewriting the base enemy controller.
- Presentation should remain readable even with dark fantasy styling; combat contrast outranks visual ornament.
