extends Area2D

signal collected(effect_name: String)

const EFFECT_VARIANTS := [
	{
		"display_name": "Blood Rite",
		"effect_name": "rapid_fire",
		"color": Color(0.909804, 0.709804, 0.243137, 1)
	},
	{
		"display_name": "Iron Ward",
		"effect_name": "heal",
		"color": Color(0.556863, 0.772549, 0.623529, 1)
	},
	{
		"display_name": "Void Thorn",
		"effect_name": "pierce",
		"color": Color(0.647059, 0.505882, 0.882353, 1)
	}
]

@onready var sprite: Polygon2D = $Sprite

@export var display_name := "Blood Rite"
@export var effect_name := "rapid_fire"

func _ready() -> void:
	add_to_group("powerups")
	body_entered.connect(_on_body_entered)
	_apply_visual_variant()


func configure_random(random_source: RandomNumberGenerator) -> void:
	var variant: Dictionary = EFFECT_VARIANTS[random_source.randi_range(0, EFFECT_VARIANTS.size() - 1)]
	display_name = variant["display_name"]
	effect_name = variant["effect_name"]
	if sprite != null:
		sprite.color = variant["color"]


func _apply_visual_variant() -> void:
	for variant in EFFECT_VARIANTS:
		if variant["effect_name"] == effect_name:
			sprite.color = variant["color"]
			return


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		collected.emit(effect_name)
		queue_free()
