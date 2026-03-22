extends CharacterBody2D

@export var move_speed := 180.0
@export var arena_size := Vector2(1280.0, 720.0)
@export var arena_margin := 36.0

func _ready() -> void:
	velocity = Vector2(-0.8, 0.6).normalized() * move_speed


func _physics_process(_delta: float) -> void:
	move_and_slide()

	if global_position.x <= arena_margin or global_position.x >= arena_size.x - arena_margin:
		velocity.x *= -1.0
		global_position.x = clamp(global_position.x, arena_margin, arena_size.x - arena_margin)

	if global_position.y <= arena_margin or global_position.y >= arena_size.y - arena_margin:
		velocity.y *= -1.0
		global_position.y = clamp(global_position.y, arena_margin, arena_size.y - arena_margin)
