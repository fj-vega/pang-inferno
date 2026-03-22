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
| `scripts/enemies/enemy_base.gd` | Shared enemy movement and bounce behavior | Arena bounds, evolution data | Core ricochet behavior lives here |
| `scripts/enemies/enemy_evolution.gd` | Split and mutation rules by enemy rank | Enemy base, spawn system | Candidate for lightweight data-driven config |
| `scripts/enemies/boss_controller.gd` | Boss movement and attack logic | Main game flow | Should plug into same damage systems where practical |
| `scripts/systems/game_flow.gd` | Round timer, win or loss state, and boss timing | Player, enemy manager, HUD | Good candidate to keep the 5-minute structure clear |
| `scripts/systems/spawn_manager.gd` | Enemy spawn pacing and wave pressure | Enemy scenes, timer | Can start simple and expand later |
| `scripts/systems/score_manager.gd` | Score tracking and reward hooks | Enemy deaths, HUD | Autoload only if cross-scene reuse becomes necessary |
| `scripts/powerups/powerup_effects.gd` | Upgrade definitions and application | Player, combat systems | Supports dark fantasy weapon and magic upgrades |

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

## Node Access Strategy

- Prefer scene unique nodes for stable same-scene references.
- Prefer signals for decoupled cross-system communication.
- Prefer groups or autoloads when cross-scene discovery is truly needed.

## Notes

- Arena logic should define the bounce bounds clearly so enemy ricochet feels deliberate rather than glitchy.
- Enemy evolution is a signature system and should stay modular enough to support future enemy types without rewriting the base enemy controller.
- Presentation should remain readable even with dark fantasy styling; combat contrast outranks visual ornament.
