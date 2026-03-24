extends Area2D

const MOVE_SPEED := 720.0
const LIFETIME := 1.1
const ASHEN_BOLT_COLOR := Color(0.952941, 0.666667, 0.368627, 1)
const ASHEN_TRAIL_COLOR := Color(0.505882, 0.172549, 0.109804, 0.95)
const VOID_BOLT_COLOR := Color(0.713726, 0.607843, 0.972549, 1)
const VOID_TRAIL_COLOR := Color(0.278431, 0.133333, 0.364706, 0.95)

@onready var sprite: Polygon2D = $Sprite
@onready var trail: Polygon2D = $Trail

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
	_refresh_visuals()


func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.call("take_damage", 1)
		if remaining_pierces > 0:
			remaining_pierces -= 1
			return
	queue_free()


func _refresh_visuals() -> void:
	if sprite == null or trail == null:
		return

	if remaining_pierces > 0:
		sprite.color = VOID_BOLT_COLOR
		trail.color = VOID_TRAIL_COLOR
	else:
		sprite.color = ASHEN_BOLT_COLOR
		trail.color = ASHEN_TRAIL_COLOR
