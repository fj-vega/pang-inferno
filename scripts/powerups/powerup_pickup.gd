extends Area2D

signal collected(effect_name: String)

@export var display_name := "Blood Rite"
@export var effect_name := "rapid_fire"

func _ready() -> void:
	add_to_group("powerups")
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		collected.emit(effect_name)
		queue_free()
