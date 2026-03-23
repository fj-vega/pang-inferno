extends Node

signal health_changed(current_health: int, max_health: int)
signal died

@export var max_health := 5
@export var contact_damage := 1
@export var invulnerability_duration := 0.75

@onready var hurtbox: Area2D = $"../Hurtbox"

var current_health := 0
var invulnerability_remaining := 0.0

func _ready() -> void:
	current_health = max_health
	hurtbox.body_entered.connect(_on_hurtbox_body_entered)
	health_changed.emit(current_health, max_health)


func _process(delta: float) -> void:
	invulnerability_remaining = max(invulnerability_remaining - delta, 0.0)


func apply_damage(amount: int) -> void:
	if invulnerability_remaining > 0.0 or current_health <= 0:
		return

	current_health = max(current_health - amount, 0)
	invulnerability_remaining = invulnerability_duration
	health_changed.emit(current_health, max_health)

	if current_health == 0:
		died.emit()


func get_current_health() -> int:
	return current_health


func get_max_health() -> int:
	return max_health


func _on_hurtbox_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		apply_damage(contact_damage)
