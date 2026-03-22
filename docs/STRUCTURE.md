# Structure

Use this file to record the actual project layout and architecture decisions.

## Scenes

| Path | Role | Root Node | Notes |
|---|---|---|---|
| `scenes/` | Placeholder until scenes exist | | |

## Scripts and Systems

| Path | Responsibility | Depends On | Notes |
|---|---|---|---|
| `scripts/` | Placeholder until scripts exist | | |

## Autoloads

| Name | Path | Responsibility | Why Global |
|---|---|---|---|
| None yet | | | |

## Input Actions

| Action | Device | Purpose |
|---|---|---|
| None yet | | |

## Signal Boundaries

Record important event flow between scenes and systems here.

## Node Access Strategy

- Prefer scene unique nodes for stable same-scene references.
- Prefer signals for decoupled cross-system communication.
- Prefer groups or autoloads when cross-scene discovery is truly needed.

## Notes

Record scene ownership, signal flow, and important architectural decisions here.
