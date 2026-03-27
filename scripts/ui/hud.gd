extends CanvasLayer

const LOW_HEALTH_COLOR := Color(0.996078, 0.478431, 0.380392, 1)
const NORMAL_HEALTH_COLOR := Color(0.964706, 0.905882, 0.811765, 1)

@onready var health_value: Label = $MarginContainer/VBoxContainer/HealthValue
@onready var score_value: Label = $MarginContainer/VBoxContainer/ScoreValue
@onready var timer_value: Label = $MarginContainer/VBoxContainer/TimerValue
@onready var phase_value: Label = $MarginContainer/VBoxContainer/PhaseValue
@onready var objective_value: Label = $MarginContainer/VBoxContainer/ObjectiveValue
@onready var boon_value: Label = $MarginContainer/VBoxContainer/BoonValue
@onready var status_value: Label = $MarginContainer/VBoxContainer/StatusValue
@onready var controls_value: Label = $MarginContainer/VBoxContainer/ControlsValue
@onready var result_panel: PanelContainer = $ResultPanel
@onready var result_title: Label = $ResultPanel/MarginContainer/VBoxContainer/ResultTitle
@onready var result_subtitle: Label = $ResultPanel/MarginContainer/VBoxContainer/ResultSubtitle

func set_health(current_health: int, max_health: int) -> void:
	health_value.text = "%d / %d" % [current_health, max_health]
	health_value.modulate = LOW_HEALTH_COLOR if current_health <= 2 else NORMAL_HEALTH_COLOR


func set_score(score: int) -> void:
	score_value.text = str(score)


func set_round_time(remaining_time: float) -> void:
	var seconds := int(remaining_time)
	var minutes_part := seconds / 60
	var seconds_part := seconds % 60
	timer_value.text = "%d:%02d" % [minutes_part, seconds_part]


func set_phase(text: String) -> void:
	phase_value.text = text


func set_objective(text: String) -> void:
	objective_value.text = text


func set_boon(text: String) -> void:
	boon_value.text = text


func set_status(text: String) -> void:
	status_value.text = text


func set_controls_hint(text: String) -> void:
	controls_value.text = text


func show_result(title: String, subtitle: String, accent_color: Color) -> void:
	result_panel.visible = true
	result_title.text = title
	result_title.modulate = accent_color
	result_subtitle.text = subtitle


func clear_result() -> void:
	result_panel.visible = false
