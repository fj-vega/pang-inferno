# Godot Notes

These are short starter-pack notes distilled from the official Godot stable documentation.

## Project Organization

- Godot uses the filesystem directly and is scene-based.
- The docs recommend grouping assets as close to the scenes that use them as practical because it scales better as projects grow.

Reference:

- [Project organization](https://docs.godotengine.org/en/stable/tutorials/best_practices/project_organization.html)

## Signals

- Signals are built-in delegation and help reduce coupling between objects.
- Prefer signals when one system should react to another without hard references.

Reference:

- [Using signals](https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html)

## Scene Unique Nodes

- Scene unique nodes are useful for stable same-scene lookups.
- They only work within the same scene boundary.
- For cross-scene access, consider groups or autoloads instead.

Reference:

- [Scene Unique Nodes](https://docs.godotengine.org/en/stable/tutorials/scripting/scene_unique_nodes.html)

## Imports and Version Control

- Imported source assets generate neighboring `.import` files that should be committed.
- The `.godot/` import cache should generally not be committed.

Reference:

- [Import process](https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/import_process.html)

## Headless and Command Line

- `--headless` is the main non-graphical mode for automation and server-style use.
- `--import` waits for imports to finish and then quits.
- `--quit` exits after the first iteration and is useful for validation-style runs.

Reference:

- [Command line tutorial](https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html)

## GDScript Style

- Use LF line endings and UTF-8.
- Use tabs for indentation in GDScript.
- Keep properties and signals above methods for readability.

Reference:

- [GDScript style guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
