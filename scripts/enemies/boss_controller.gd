extends CharacterBody2D

@export var move_speed := 120.0

var direction := Vector2.LEFT

func _physics_process(_delta: float) -> void:
	velocity = direction * move_speed
	move_and_slide()
