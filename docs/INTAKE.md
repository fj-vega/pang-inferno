# Game Intake Checklist

Use this checklist when a user says something like "build me a game about X" but the concept is still too vague to execute well.

The goal is not to demand a full design document up front. The goal is to identify the minimum human-provided context needed to turn a vague request into a buildable plan.

## How To Use This

1. Read the user's request.
2. Infer as much as possible from the request and existing repo docs.
3. Do not ask for things that can be reasonably assumed.
4. Check the requirement groups below.
5. If critical information is missing, ask only for the missing required items.
6. Once the answers exist, update `docs/PRD.md` and `docs/PLAN.md` before major implementation.

## Minimum Required Context

These are the minimum inputs a human should provide before Codex starts building a real game.

### 1. Core Fantasy

Codex needs to understand what the player is doing and why it is appealing.

Required:

- one-sentence game pitch
- genre or closest comparison
- 2D or 3D

### 2. Core Loop

Codex needs the repeatable player loop, even if it is rough.

Required:

- what the player does most of the time
- what counts as progress
- what counts as failure or pressure

### 3. Scope Target

Codex needs to know what size of game to build first.

Required:

- prototype, game jam slice, MVP, or larger foundation
- rough expectation for length or depth

### 4. Platform And Input

Codex needs to avoid building the wrong interaction model.

Required:

- target platform
- primary input method

## Strongly Recommended Context

Codex can start without these, but quality improves a lot if they are provided early.

### 5. Aesthetic Direction

- visual tone or references
- audio mood
- UI feel

### 6. Reference Games

- one to three comparison titles
- what to borrow from each one
- what to avoid copying

### 7. Boundaries

- explicit out-of-scope features
- engine or technical constraints
- content constraints

### 8. Preference Calls

- story-heavy or systems-heavy
- arcade or simulation
- cozy or punishing
- local-only or future online ambitions

## Ready / Not Ready Rule

The project is ready to build when all of these are true:

- the minimum required context above exists
- `docs/PRD.md` contains real answers, not placeholders
- `docs/PLAN.md` contains taskable work for this specific game
- Godot is available locally for validation

If any of those are false, Codex should stop pretending implementation is ready and ask for the missing items.

## Suggested Intake Response

When the request is too vague, Codex should respond in this pattern:

"I can build this, but before I start I need a little more context so I don't make the wrong game. Please give me:

1. the one-sentence pitch
2. whether this is 2D or 3D
3. the core player loop
4. the target scope for the first version
5. the target platform and input method"

Then Codex should convert those answers into `docs/PRD.md` and `docs/PLAN.md`.
