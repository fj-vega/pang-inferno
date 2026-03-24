extends Area2D

signal collected(effect_name: String)

const EFFECT_VARIANTS := [
	{
		"display_name": "Blood Rite",
		"effect_name": "rapid_fire",
		"color": Color(0.839216, 0.298039, 0.227451, 1),
		"label_color": Color(0.996078, 0.858824, 0.733333, 1),
		"points": [
			Vector2(0, -16),
			Vector2(14, -2),
			Vector2(8, 16),
			Vector2(-8, 16),
			Vector2(-14, -2)
		]
	},
	{
		"display_name": "Iron Ward",
		"effect_name": "heal",
		"color": Color(0.545098, 0.658824, 0.517647, 1),
		"label_color": Color(0.878431, 0.92549, 0.807843, 1),
		"points": [
			Vector2(-12, -12),
			Vector2(12, -12),
			Vector2(16, 0),
			Vector2(12, 12),
			Vector2(-12, 12),
			Vector2(-16, 0)
		]
	},
	{
		"display_name": "Void Thorn",
		"effect_name": "pierce",
		"color": Color(0.52549, 0.380392, 0.768627, 1),
		"label_color": Color(0.905882, 0.854902, 0.984314, 1),
		"points": [
			Vector2(0, -18),
			Vector2(6, -6),
			Vector2(18, 0),
			Vector2(6, 6),
			Vector2(0, 18),
			Vector2(-6, 6),
			Vector2(-18, 0),
			Vector2(-6, -6)
		]
	}
]

@onready var sprite: Polygon2D = $Sprite
@onready var rune_label: Label = $NameLabel

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
	_apply_variant(variant)


func _apply_visual_variant() -> void:
	for variant in EFFECT_VARIANTS:
		if variant["effect_name"] == effect_name:
			_apply_variant(variant)
			return


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		collected.emit(effect_name)
		queue_free()


func _apply_variant(variant: Dictionary) -> void:
	if sprite != null:
		sprite.color = variant["color"]
		sprite.polygon = PackedVector2Array(variant["points"])
	if rune_label != null:
		rune_label.text = variant["display_name"]
		rune_label.modulate = variant["label_color"]
