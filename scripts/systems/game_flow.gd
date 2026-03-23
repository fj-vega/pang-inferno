extends Node2D

const ROUND_DURATION := 300.0
const MAX_ENEMIES := 8
const ENEMY_SPAWN_INTERVAL := 2.8
const POWERUP_SPAWN_INTERVAL := 18.0
const BOSS_PHASE_TRIGGER_TIME := 45.0

var projectile_scene := preload("res://scenes/projectiles/Projectile.tscn")
var enemy_scene := preload("res://scenes/enemies/EnemyBase.tscn")
var boss_scene := preload("res://scenes/enemies/Boss.tscn")
var powerup_scene := preload("res://scenes/powerups/PowerUpPickup.tscn")

@onready var player: CharacterBody2D = $Player
@onready var player_health: Node = $Player/PlayerHealth
@onready var enemy_container: Node2D = $Enemies
@onready var projectile_container: Node = $Projectiles
@onready var powerup_container: Node2D = $PowerUps
@onready var hud: CanvasLayer = $HUD

var elapsed_time := 0.0
var run_over := false
var score := 0
var enemy_spawn_timer := 1.5
var powerup_spawn_timer := 10.0
var boss_spawned := false
var boss_active := false
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	var input_changed := _ensure_input_actions()
	if input_changed:
		ProjectSettings.save()
	rng.randomize()
	_connect_gameplay_signals()
	_configure_hud()


func _process(delta: float) -> void:
	if run_over:
		return

	elapsed_time = min(elapsed_time + delta, ROUND_DURATION)
	var remaining_time: float = max(ROUND_DURATION - elapsed_time, 0.0)
	if hud.has_method("set_round_time"):
		hud.call("set_round_time", remaining_time)
	if not boss_spawned and remaining_time <= BOSS_PHASE_TRIGGER_TIME:
		_spawn_boss_phase()
	if remaining_time <= 0.0:
		_on_round_survived()
		return

	if not boss_active:
		_update_enemy_spawning(delta)
	_update_powerup_spawning(delta)


func _connect_gameplay_signals() -> void:
	if player.has_signal("shot_requested"):
		player.shot_requested.connect(_spawn_projectile)
	if player_health.has_signal("health_changed"):
		player_health.health_changed.connect(_on_player_health_changed)
	if player_health.has_signal("died"):
		player_health.died.connect(_on_player_died)
	for child in enemy_container.get_children():
		_connect_enemy(child)
	for child in powerup_container.get_children():
		_connect_powerup(child)


func _configure_hud() -> void:
	if hud.has_method("set_round_time"):
		hud.call("set_round_time", ROUND_DURATION)
	if hud.has_method("set_status"):
		hud.call("set_status", "Fight through the inferno")
	if hud.has_method("set_health"):
		hud.call("set_health", player_health.call("get_current_health"), player_health.call("get_max_health"))
	if hud.has_method("set_score"):
		hud.call("set_score", score)


func _update_enemy_spawning(delta: float) -> void:
	enemy_spawn_timer -= delta
	if enemy_spawn_timer > 0.0:
		return
	if enemy_container.get_child_count() >= MAX_ENEMIES:
		enemy_spawn_timer = 1.0
		return

	enemy_spawn_timer = max(1.1, ENEMY_SPAWN_INTERVAL - (elapsed_time / 90.0))
	var enemy := enemy_scene.instantiate()
	enemy.global_position = _random_arena_position(72.0)
	var direction: Vector2 = (player.global_position - enemy.global_position).normalized()
	if direction.length() <= 0.0:
		direction = Vector2.LEFT
	enemy.call("configure_variant", 2, 1.0, direction)
	enemy_container.add_child(enemy)
	_connect_enemy(enemy)


func _update_powerup_spawning(delta: float) -> void:
	powerup_spawn_timer -= delta
	if powerup_spawn_timer > 0.0:
		return
	if powerup_container.get_child_count() > 0:
		powerup_spawn_timer = 6.0
		return

	powerup_spawn_timer = POWERUP_SPAWN_INTERVAL
	var powerup := powerup_scene.instantiate()
	powerup.global_position = _random_arena_position(120.0)
	powerup.call("configure_random", rng)
	powerup_container.add_child(powerup)
	_connect_powerup(powerup)


func _spawn_boss_phase() -> void:
	boss_spawned = true
	boss_active = true
	for child in enemy_container.get_children():
		child.queue_free()

	var boss := boss_scene.instantiate()
	boss.global_position = Vector2(640.0, 120.0)
	boss.call("set_target", player)
	enemy_container.add_child(boss)
	_connect_enemy(boss)
	if hud.has_method("set_status"):
		hud.call("set_status", "Boss phase: infernal champion")


func _spawn_projectile(origin: Vector2, direction: Vector2, pierce_count: int) -> void:
	if run_over:
		return

	var projectile := projectile_scene.instantiate()
	projectile.global_position = origin
	projectile.call("setup", direction, pierce_count)
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
	if split_count > 0 and child_rank > 0 and not boss_active:
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


func _connect_powerup(powerup: Node) -> void:
	if powerup.has_signal("collected") and not powerup.collected.is_connected(_on_powerup_collected):
		powerup.collected.connect(_on_powerup_collected)


func _on_powerup_collected(effect_name: String) -> void:
	match effect_name:
		"rapid_fire":
			player.call("apply_rapid_fire", 0.45, 8.0)
			if hud.has_method("set_status"):
				hud.call("set_status", "Blood rite: rapid fire")
		"heal":
			player_health.call("heal", 2)
			if hud.has_method("set_status"):
				hud.call("set_status", "Iron ward: vitality restored")
		"pierce":
			player.call("grant_piercing_shots", 8)
			if hud.has_method("set_status"):
				hud.call("set_status", "Void thorn: shots pierce")


func _on_round_survived() -> void:
	run_over = true
	if hud.has_method("set_status"):
		hud.call("set_status", "You survived the round")


func _random_arena_position(margin: float) -> Vector2:
	return Vector2(
		rng.randf_range(64.0 + margin, 1216.0 - margin),
		rng.randf_range(64.0 + margin, 656.0 - margin)
	)


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
