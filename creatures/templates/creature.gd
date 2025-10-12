extends Node2D

@onready var idle: AnimatedSprite2D = %Idle
@onready var lifebar: TextureProgressBar = %Lifebar
var index = 0

func _ready() -> void:
	_update_lifebar()

func _update_lifebar(slow = false):
	return
	var tween_time = 0.8
	lifebar.max_value = GameData.actors[index].max_hp * 100
	if slow:
		var tween = create_tween()
		tween.tween_property(lifebar, 'value', GameData.actors[index].current_hp * 100, tween_time)
	else:
		lifebar.value = GameData.actors[index].current_hp * 100

func _on_main_btn_pressed() -> void:
	GameData.selected_actor = index
	SignalManager.select_hero.emit()
