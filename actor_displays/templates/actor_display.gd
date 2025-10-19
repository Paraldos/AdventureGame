extends Node2D

@onready var idle: AnimatedSprite2D = %Idle
@onready var lifebar: TextureProgressBar = %Lifebar
@onready var status_bar: Node2D = %StatusBar

var slot_index = 0
var actor

func _ready() -> void:
	SignalManager.update_actor_display.connect(_on_update_actor_display)
	_update_lifebar()

func _on_update_actor_display(target_index : int):
	if slot_index != target_index: return
	queue_free()

func _update_lifebar(slow = false):
	var tween_time = 0.8
	var max_hp = actor.get_max_hp()
	var current_hp = actor.get_current_hp()
	lifebar.max_value = max_hp * 100
	if slow:
		var tween = create_tween()
		tween.tween_property(lifebar, 'value', current_hp, tween_time)
	else:
		lifebar.value = current_hp * 100

func _on_main_btn_pressed() -> void:
	GameData.selected_actor = slot_index
	SignalManager.select_hero.emit()
