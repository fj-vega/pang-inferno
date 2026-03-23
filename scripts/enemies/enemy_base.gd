extends CharacterBody2D

signal defeated(position: Vector2, score_value: int, split_count: int, child_rank: int, child_scale: float)

const MUTATION_SPEED_MULTIPLIER := 1.35
const MUTATION_SCORE_MULTIPLIER := 2
const MUTATION_COLOR := Color(0.854902, 0.258824, 0.12549, 1)

@export var move_speed := 180.0
@export var arena_size := Vector2(1280.0, 720.0)
@export var arena_margin := 36.0
@export var max_health := 3
@export var rank := 2
@export var score_value := 100
@export var can_mutate := true
@export var mutation_delay := 7.0

@onready var sprite: Polygon2D = $Sprite

var current_health := 0
var mutation_elapsed := 0.0
var mutated := false

func _ready() -> void:
	add_to_group("enemies")
	current_health = max_health
	velocity = Vector2(-0.8, 0.6).normalized() * move_speed
	_refresh_visuals()


func _physics_process(delta: float) -> void:
	_update_mutation(delta)
	move_and_slide()

	if global_position.x <= arena_margin or global_position.x >= arena_size.x - arena_margin:
		velocity.x *= -1.0
		global_position.x = clamp(global_position.x, arena_margin, arena_size.x - arena_margin)

	if global_position.y <= arena_margin or global_position.y >= arena_size.y - arena_margin:
		velocity.y *= -1.0
		global_position.y = clamp(global_position.y, arena_margin, arena_size.y - arena_margin)


func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health > 0:
		return

	var split_count := 0
	var child_rank := 0
	var child_scale := 1.0
	if rank > 1:
		split_count = 2
		child_rank = rank - 1
		child_scale = 0.72

	defeated.emit(global_position, score_value, split_count, child_rank, child_scale)
	queue_free()


func configure_variant(new_rank: int, new_scale: float, starting_direction: Vector2) -> void:
	rank = new_rank
	scale = Vector2.ONE * new_scale
	move_speed = 150.0 + (20.0 * float(new_rank))
	max_health = max(1, new_rank)
	score_value = 50 * new_rank
	current_health = max_health
	can_mutate = new_rank <= 1
	mutation_delay = 5.0 + (2.0 * float(new_rank))
	mutated = false
	mutation_elapsed = 0.0
	velocity = starting_direction.normalized() * move_speed
	_refresh_visuals()


func _update_mutation(delta: float) -> void:
	if not can_mutate or mutated:
		return

	mutation_elapsed += delta
	if mutation_elapsed < mutation_delay:
		return

	mutated = true
	move_speed *= MUTATION_SPEED_MULTIPLIER
	score_value *= MUTATION_SCORE_MULTIPLIER
	velocity = velocity.normalized() * move_speed
	_refresh_visuals()


func _refresh_visuals() -> void:
	if sprite == null:
		return

	if mutated:
		sprite.color = MUTATION_COLOR
	else:
		sprite.color = Color(0.54902, 0.109804, 0.0784314, 1)
