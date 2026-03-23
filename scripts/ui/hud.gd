extends CanvasLayer

@onready var health_value: Label = $MarginContainer/VBoxContainer/HealthValue
@onready var score_value: Label = $MarginContainer/VBoxContainer/ScoreValue
@onready var timer_value: Label = $MarginContainer/VBoxContainer/TimerValue
@onready var status_value: Label = $MarginContainer/VBoxContainer/StatusValue

func set_health(current_health: int, max_health: int) -> void:
	health_value.text = "%d / %d" % [current_health, max_health]


func set_score(score: int) -> void:
	score_value.text = str(score)


func set_round_time(remaining_time: float) -> void:
	var seconds := int(remaining_time)
	var minutes_part := seconds / 60
	var seconds_part := seconds % 60
	timer_value.text = "%d:%02d" % [minutes_part, seconds_part]


func set_status(text: String) -> void:
	status_value.text = text
