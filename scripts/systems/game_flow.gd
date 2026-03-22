extends Node2D

const ROUND_DURATION := 300.0

@onready var hud: CanvasLayer = $HUD

var elapsed_time := 0.0

func _ready() -> void:
	var input_changed := _ensure_input_actions()
	if input_changed:
		ProjectSettings.save()
	_configure_hud()


func _process(delta: float) -> void:
	elapsed_time = min(elapsed_time + delta, ROUND_DURATION)
	var remaining_time: float = max(ROUND_DURATION - elapsed_time, 0.0)
	if hud.has_method("set_round_time"):
		hud.call("set_round_time", remaining_time)


func _configure_hud() -> void:
	if hud.has_method("set_round_time"):
		hud.call("set_round_time", ROUND_DURATION)
	if hud.has_method("set_status"):
		hud.call("set_status", "Bootstrap arena ready")


func _ensure_input_actions() -> bool:
	var changed := false
	changed = _add_key_action("move_left", KEY_A, KEY_LEFT) or changed
	changed = _add_key_action("move_right", KEY_D, KEY_RIGHT) or changed
	changed = _add_key_action("move_up", KEY_W, KEY_UP) or changed
	changed = _add_key_action("move_down", KEY_S, KEY_DOWN) or changed
	changed = _add_key_action("fire", KEY_SPACE, KEY_ENTER) or changed
	changed = _add_key_action("pause", KEY_ESCAPE, KEY_P) or changed
	changed = _add_joy_axis_action("move_left", JOY_AXIS_LEFT_X, -1.0) or changed
	changed = _add_joy_axis_action("move_right", JOY_AXIS_LEFT_X, 1.0) or changed
	changed = _add_joy_axis_action("move_up", JOY_AXIS_LEFT_Y, -1.0) or changed
	changed = _add_joy_axis_action("move_down", JOY_AXIS_LEFT_Y, 1.0) or changed
	changed = _add_joy_axis_action("aim_left", JOY_AXIS_RIGHT_X, -1.0) or changed
	changed = _add_joy_axis_action("aim_right", JOY_AXIS_RIGHT_X, 1.0) or changed
	changed = _add_joy_axis_action("aim_up", JOY_AXIS_RIGHT_Y, -1.0) or changed
	changed = _add_joy_axis_action("aim_down", JOY_AXIS_RIGHT_Y, 1.0) or changed
	changed = _add_joy_button_action("fire", JOY_BUTTON_A) or changed
	changed = _add_joy_button_action("pause", JOY_BUTTON_START) or changed
	return changed


func _add_key_action(action_name: StringName, primary_key: Key, secondary_key: Key = KEY_NONE) -> bool:
	var changed := false
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
		changed = true
	changed = _add_key_event(action_name, primary_key) or changed
	if secondary_key != KEY_NONE:
		changed = _add_key_event(action_name, secondary_key) or changed
	return changed


func _add_key_event(action_name: StringName, keycode: Key) -> bool:
	for existing_event in InputMap.action_get_events(action_name):
		if existing_event is InputEventKey and existing_event.physical_keycode == keycode:
			return false
	var event := InputEventKey.new()
	event.physical_keycode = keycode
	InputMap.action_add_event(action_name, event)
	return true


func _add_joy_axis_action(action_name: StringName, axis: JoyAxis, axis_value: float) -> bool:
	var changed := false
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
		changed = true
	for existing_event in InputMap.action_get_events(action_name):
		if existing_event is InputEventJoypadMotion and existing_event.axis == axis and is_equal_approx(existing_event.axis_value, axis_value):
			return changed
	var event := InputEventJoypadMotion.new()
	event.axis = axis
	event.axis_value = axis_value
	InputMap.action_add_event(action_name, event)
	return true


func _add_joy_button_action(action_name: StringName, button_index: JoyButton) -> bool:
	var changed := false
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
		changed = true
	for existing_event in InputMap.action_get_events(action_name):
		if existing_event is InputEventJoypadButton and existing_event.button_index == button_index:
			return changed
	var event := InputEventJoypadButton.new()
	event.button_index = button_index
	InputMap.action_add_event(action_name, event)
	return true
