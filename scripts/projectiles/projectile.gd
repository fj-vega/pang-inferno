extends Area2D

const MOVE_SPEED := 720.0
const LIFETIME := 1.1

var direction := Vector2.RIGHT
var lifetime_remaining := LIFETIME
var remaining_pierces := 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	global_position += direction * MOVE_SPEED * delta
	lifetime_remaining -= delta
	if lifetime_remaining <= 0.0:
		queue_free()


func setup(new_direction: Vector2, pierce_count: int = 0) -> void:
	direction = new_direction.normalized()
	remaining_pierces = pierce_count
	rotation = direction.angle()


func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.call("take_damage", 1)
		if remaining_pierces > 0:
			remaining_pierces -= 1
			return
	queue_free()
