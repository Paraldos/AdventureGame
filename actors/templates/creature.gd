extends Node2D

@onready var idle: AnimatedSprite2D = %Idle
@onready var lifebar: TextureProgressBar = %Lifebar
var index = 0

func _ready() -> void:
	_update_lifebar()

func _update_lifebar(slow = false):
	var tween_time = 0.8
	var max_hp = ActorManager.get_max_hp(index)
	var current_hp = ActorManager.get_current_hp(index)
	lifebar.max_value = max_hp * 100
	if slow:
		var tween = create_tween()
		tween.tween_property(lifebar, 'value', current_hp, tween_time)
	else:
		lifebar.value = current_hp * 100

func _on_main_btn_pressed() -> void:
	GameData.selected_actor = index
	SignalManager.select_hero.emit()
