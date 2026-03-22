# PRD

## Snapshot

- Working title: Pang Inferno
- Genre: 2D top-down arena survival shooter
- Perspective: Top-down
- Target platform: PC
- Primary input: Keyboard and controller
- Target session length: 5-minute rounds

## Vision

Pang Inferno is a dark fantasy survival-action game that blends the ricochet threat pattern of Pang and Pong-like enemies with the escalating pressure and reward cadence of Vampire Survivors. The player controls a mobile hunter in a cursed arena, kiting and shooting infernal orb-creatures that rebound violently around the space, split into new threats, mutate into deadlier forms, and culminate in a final boss encounter before the round timer ends.

The emotional tone should feel tense, aggressive, and arcadey, but dressed in a Conan-plus-magic aesthetic: iron weapons, occult power, infernal creatures, blood-red danger, and supernatural upgrades that feel earned through survival.

## Audience

- Primary audience: Players who enjoy arcade survival games with readable but demanding movement and projectile management
- Secondary audience: Fans of Pang, Vampire Survivors, and action games with dark fantasy presentation
- Comparable games: Pang, Super Pang, Vampire Survivors, Brotato

## Design Pillars

- Pillar 1: Movement and positioning matter as much as aim because enemies ricochet unpredictably across the arena
- Pillar 2: Every kill changes the battlefield through enemy splitting, mutation, and denser threat patterns
- Pillar 3: Dark fantasy weapons and magic power-ups turn survival into a power climb toward a boss showdown

## Player Experience Goals

- What should players feel in the first 5 minutes? Immediate pressure, readable danger, and satisfaction from mastering enemy bounce patterns while collecting impactful upgrades
- What should keep them playing after the novelty wears off? Build experimentation, escalating enemy transformations, score chasing, and the tension of surviving long enough to defeat the round boss

## Core Loop

Describe the repeatable player loop in a few lines:

1. Move through a compact arena, avoid ricocheting enemies, and fire at the nearest threats.
2. Kill weaker enemies to score points while stronger enemies split into smaller foes or mutate into new behaviors.
3. Collect power-ups, grow stronger, survive until the boss phase, and defeat the boss before time or health runs out.

## MVP

The MVP is a single 5-minute arena with one playable character, twin-stick-style movement and aiming on keyboard/controller, a small enemy roster built around bouncing orb-demons, basic player health, scoring, a few dark fantasy themed power-ups, and a boss that appears near the end of the round. The MVP should already feel complete as a survival loop, even if art, audio, and content variety are still placeholder quality.

## In Scope

- One top-down 2D arena
- Player movement in all directions
- Shooting-based combat
- Ricocheting enemy movement
- Enemy rank system with death, splitting, and mutation behaviors
- Score system
- Power-up drops and temporary or permanent upgrades
- One timed round structure lasting 5 minutes
- One final boss encounter
- Keyboard and controller support

## Out of Scope

- Multiple stages or biomes
- Story campaign structure
- Online multiplayer
- Meta-progression between runs
- Large enemy roster beyond what is needed for the first playable slice
- Final art, final audio, or advanced VFX polish

## Content and Systems

- Player verbs: Move, aim, shoot, dodge, collect power-ups, survive, score
- Progression: Earn points, survive the timer, gain weapon or magic upgrades during the round, and overcome stronger enemy states
- Failure state: Player health reaches zero before defeating the boss or surviving the round
- Win state: Player survives the round and defeats the final boss

## Presentation

- Visual direction: Dark fantasy with barbarian-and-sorcery energy, infernal enemies, occult power-ups, iron-and-magic weapons, and bold readable arena silhouettes
- Audio direction: Heavy percussive combat cues, ominous fantasy ambience, magical impact stings, and escalating boss intensity
- UI/HUD needs: Health, timer, score, current weapon or buffs, and clear boss-phase signaling

## Technical Notes

- Target Godot version: Godot 4 stable
- 2D or 3D: 2D
- Planned autoloads: Prefer none for MVP unless a run-state or event service becomes clearly global
- Special engine concerns: Need responsive keyboard and controller handling, deterministic-enough bounce behavior for enemies, and clean enemy state transitions for split and mutation logic

## Risks

- Enemy splitting and mutation can become visually chaotic if readability is not protected
- Ricochet-heavy movement may feel unfair if arena bounds, spawn timing, or enemy speed are not tuned carefully
- Without Godot available locally yet, engine validation and scene bootstrap are blocked

## Open Questions

- Should aiming default to movement direction on keyboard or use mouse aim plus optional controller right stick?
- Should power-ups be timed buffs, permanent-in-run upgrades, or a mix of both?
- Does the boss replace normal spawns near the end or appear alongside them?
