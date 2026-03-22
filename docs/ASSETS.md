# Assets

Track art, audio, fonts, shaders, imported resources, and their ownership here.

## Asset Rules

- Keep assets close to the scenes that own them when practical.
- Track source and license for anything not created in-repo.
- Commit `.import` files generated next to source assets.
- Do not rely on `.godot/` as source-of-truth project data.

## Needed Assets

| Asset | Intended Path | Owner Scene or System | Source | License | Status | Notes |
|---|---|---|---|---|---|---|
| Player hunter sprite placeholder | `assets/player/` | `scenes/player/Player.tscn` | In-repo placeholder | TBD | pending | Barbarian or dark ranger silhouette with readable facing |
| Infernal orb enemy sprites | `assets/enemies/` | `scenes/enemies/EnemyBase.tscn` | In-repo placeholder | TBD | pending | Each rank should stay readable while hinting at mutation |
| Boss sprite placeholder | `assets/enemies/` | `scenes/enemies/Boss.tscn` | In-repo placeholder | TBD | pending | Should feel heavier and more occult than standard enemies |
| Projectile and muzzle FX | `assets/fx/` | Player combat systems | In-repo placeholder | TBD | pending | Steel-and-sorcery shots, not sci-fi bullets |
| Power-up icons | `assets/powerups/` | `scenes/powerups/PowerUpPickup.tscn` | In-repo placeholder | TBD | pending | Good early themes are cursed shot, ward, pierce, and spread |
| Arena tiles or background | `assets/environment/` | `scenes/main/Main.tscn` | In-repo placeholder | TBD | pending | Dark stone, ritual floor, or infernal battleground motif |
| HUD font and panel art | `assets/ui/` | `scenes/ui/HUD.tscn` | In-repo placeholder | TBD | pending | Needs strong readability over a dark arena |
| Combat SFX set | `assets/audio/sfx/` | Combat and UI systems | TBD | TBD | pending | Impacts, ricochets, pickups, damage, boss warning |
| Music loop and boss cue | `assets/audio/music/` | Main gameplay flow | TBD | TBD | pending | Sword-and-sorcery mood with escalating intensity |
