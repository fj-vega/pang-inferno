extends CharacterBody2D

signal defeated(position: Vector2, score_value: int, split_count: int, child_rank: int, child_scale: float)

@export var move_speed := 130.0
@export var max_health := 20
@export var score_value := 1000

@onready var sprite: Polygon2D = $Sprite

var current_health := 0
var target: Node2D

func _ready() -> void:
	add_to_group("enemies")
	add_to_group("boss")
	current_health = max_health
	if sprite != null:
		sprite.color = Color(0.458824, 0.0862745, 0.0705882, 1)


func _physics_process(_delta: float) -> void:
	if target != null:
		var desired_direction := global_position.direction_to(target.global_position)
		if desired_direction.length() > 0.0:
			velocity = desired_direction * move_speed
	move_and_slide()


func set_target(new_target: Node2D) -> void:
	target = new_target


func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health > 0:
		return

	defeated.emit(global_position, score_value, 0, 0, 1.0)
	queue_free()
