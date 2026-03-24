extends CharacterBody2D

signal shot_requested(origin: Vector2, direction: Vector2, pierce_count: int)
signal boons_changed(summary_text: String)

const MOVE_SPEED := 360.0
const ARENA_MARGIN := 48.0
const ARENA_SIZE := Vector2(1280.0, 720.0)
const BASE_FIRE_COOLDOWN := 0.22

@onready var facing_indicator: Polygon2D = $FacingIndicator

var look_direction := Vector2.RIGHT
var fire_cooldown_remaining := 0.0
var fire_cooldown_multiplier := 1.0
var rapid_fire_duration_remaining := 0.0
var piercing_shots_remaining := 0

func _ready() -> void:
	add_to_group("player")


func _physics_process(delta: float) -> void:
	var movement := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = movement * MOVE_SPEED
	move_and_slide()
	_clamp_into_arena()
	_update_look_direction(movement)
	_update_indicator_rotation()
	_update_buff_timers(delta)
	_update_firing(delta)


func _clamp_into_arena() -> void:
	global_position.x = clamp(global_position.x, ARENA_MARGIN, ARENA_SIZE.x - ARENA_MARGIN)
	global_position.y = clamp(global_position.y, ARENA_MARGIN, ARENA_SIZE.y - ARENA_MARGIN)


func _update_look_direction(movement: Vector2) -> void:
	var stick_aim := Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	if stick_aim.length() > 0.2:
		look_direction = stick_aim.normalized()
		return

	var mouse_direction := global_position.direction_to(get_global_mouse_position())
	if mouse_direction.length() > 0.05:
		look_direction = mouse_direction
		return

	if movement.length() > 0.0:
		look_direction = movement.normalized()


func _update_indicator_rotation() -> void:
	facing_indicator.rotation = look_direction.angle()


func _update_buff_timers(delta: float) -> void:
	var boons_changed_this_frame := false
	if rapid_fire_duration_remaining > 0.0:
		var previous_rapid_fire := rapid_fire_duration_remaining
		rapid_fire_duration_remaining = max(rapid_fire_duration_remaining - delta, 0.0)
		boons_changed_this_frame = previous_rapid_fire != rapid_fire_duration_remaining
		if rapid_fire_duration_remaining == 0.0:
			fire_cooldown_multiplier = 1.0
	if boons_changed_this_frame:
		_emit_boon_summary()


func _update_firing(delta: float) -> void:
	fire_cooldown_remaining = max(fire_cooldown_remaining - delta, 0.0)
	if not Input.is_action_pressed("fire"):
		return
	if fire_cooldown_remaining > 0.0:
		return

	fire_cooldown_remaining = BASE_FIRE_COOLDOWN * fire_cooldown_multiplier
	shot_requested.emit(global_position + (look_direction * 24.0), look_direction, piercing_shots_remaining)


func apply_rapid_fire(cooldown_multiplier: float, duration: float) -> void:
	fire_cooldown_multiplier = cooldown_multiplier
	rapid_fire_duration_remaining = duration
	_emit_boon_summary()


func grant_piercing_shots(count: int) -> void:
	piercing_shots_remaining += count
	_emit_boon_summary()


func consume_pierce_charge() -> void:
	if piercing_shots_remaining <= 0:
		return
	piercing_shots_remaining -= 1
	_emit_boon_summary()


func get_boon_summary() -> String:
	var boon_parts: Array[String] = []
	if rapid_fire_duration_remaining > 0.0:
		boon_parts.append("Blood Rite %.1fs" % rapid_fire_duration_remaining)
	if piercing_shots_remaining > 0:
		boon_parts.append("Void Thorn %d bolts" % piercing_shots_remaining)
	if boon_parts.is_empty():
		return "Ashen Pike alone"
	return " | ".join(boon_parts)


func _emit_boon_summary() -> void:
	boons_changed.emit(get_boon_summary())
