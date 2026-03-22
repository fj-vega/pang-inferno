extends CharacterBody2D

const MOVE_SPEED := 360.0
const ARENA_MARGIN := 48.0
const ARENA_SIZE := Vector2(1280.0, 720.0)

@onready var facing_indicator: Polygon2D = $FacingIndicator

var look_direction := Vector2.RIGHT

func _physics_process(_delta: float) -> void:
	var movement := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = movement * MOVE_SPEED
	move_and_slide()
	_clamp_into_arena()
	_update_look_direction(movement)
	_update_indicator_rotation()


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
