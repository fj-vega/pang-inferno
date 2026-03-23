extends Node2D

const ROUND_DURATION := 300.0

var projectile_scene := preload("res://scenes/projectiles/Projectile.tscn")
var enemy_scene := preload("res://scenes/enemies/EnemyBase.tscn")

@onready var player: CharacterBody2D = $Player
@onready var player_health: Node = $Player/PlayerHealth
@onready var enemy_container: Node2D = $Enemies
@onready var projectile_container: Node = $Projectiles
@onready var hud: CanvasLayer = $HUD

var elapsed_time := 0.0
var run_over := false
var score := 0

func _ready() -> void:
	var input_changed := _ensure_input_actions()
	if input_changed:
		ProjectSettings.save()
	_connect_gameplay_signals()
	_configure_hud()


func _process(delta: float) -> void:
	if run_over:
		return

	elapsed_time = min(elapsed_time + delta, ROUND_DURATION)
	var remaining_time: float = max(ROUND_DURATION - elapsed_time, 0.0)
	if hud.has_method("set_round_time"):
		hud.call("set_round_time", remaining_time)
	if remaining_time <= 0.0:
		_on_round_survived()


func _connect_gameplay_signals() -> void:
	if player.has_signal("shot_requested"):
		player.shot_requested.connect(_spawn_projectile)
	if player_health.has_signal("health_changed"):
		player_health.health_changed.connect(_on_player_health_changed)
	if player_health.has_signal("died"):
		player_health.died.connect(_on_player_died)
	for child in enemy_container.get_children():
		_connect_enemy(child)


func _configure_hud() -> void:
	if hud.has_method("set_round_time"):
		hud.call("set_round_time", ROUND_DURATION)
	if hud.has_method("set_status"):
		hud.call("set_status", "Fight through the inferno")
	if hud.has_method("set_health"):
		hud.call("set_health", player_health.call("get_current_health"), player_health.call("get_max_health"))
	if hud.has_method("set_score"):
		hud.call("set_score", score)


func _spawn_projectile(origin: Vector2, direction: Vector2) -> void:
	if run_over:
		return

	var projectile := projectile_scene.instantiate()
	projectile.global_position = origin
	projectile.call("setup", direction)
	projectile_container.add_child(projectile)


func _on_player_health_changed(current_health: int, max_health: int) -> void:
	if hud.has_method("set_health"):
		hud.call("set_health", current_health, max_health)


func _on_player_died() -> void:
	run_over = true
	if hud.has_method("set_status"):
		hud.call("set_status", "The hunter has fallen")


func _on_enemy_defeated(position: Vector2, score_value: int, split_count: int, child_rank: int, child_scale: float) -> void:
	score += score_value
	if hud.has_method("set_score"):
		hud.call("set_score", score)
	if hud.has_method("set_status"):
		hud.call("set_status", "Infernal foe destroyed")
	if split_count > 0 and child_rank > 0:
		_spawn_split_children(position, split_count, child_rank, child_scale)


func _spawn_split_children(position: Vector2, split_count: int, child_rank: int, child_scale: float) -> void:
	var directions := [
		Vector2(0.8, -0.6),
		Vector2(-0.8, 0.6),
		Vector2(-0.7, -0.7),
		Vector2(0.7, 0.7)
	]
	for index in split_count:
		var enemy := enemy_scene.instantiate()
		enemy.global_position = position + (directions[index] * 14.0)
		enemy.call("configure_variant", child_rank, child_scale, directions[index])
		enemy_container.add_child(enemy)
		_connect_enemy(enemy)


func _connect_enemy(enemy: Node) -> void:
	if enemy.has_signal("defeated") and not enemy.defeated.is_connected(_on_enemy_defeated):
		enemy.defeated.connect(_on_enemy_defeated)


func _on_round_survived() -> void:
	run_over = true
	if hud.has_method("set_status"):
		hud.call("set_status", "You survived the round")


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
