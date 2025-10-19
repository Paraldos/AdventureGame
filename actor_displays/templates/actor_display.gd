extends Node2D

@onready var sprites: Node2D = %Sprites
@onready var idle: AnimatedSprite2D = %Idle

@onready var lifebar: ProgressBar = %Lifebar
@onready var ini_box: TextureRect = %IniBox
@onready var ini_label: Label = %IniLabel

var slot_index = 0
var actor

func _ready() -> void:
	SignalManager.state_changed.connect(_on_state_changed)
	SignalManager.update_actor_display.connect(_on_update_actor_display)
	SignalManager.update_ini.connect(_on_update_ini)
	ini_box.visible = false
	_update_lifebar()
	if slot_index > 2:
		sprites.scale.x = -1

func _on_state_changed():
	ini_box.visible = false

func _on_update_actor_display(target_index : int):
	if slot_index != target_index: return
	queue_free()

func _on_update_ini():
	ini_box.visible = true
	ini_label.text = "%s" % actor.current_ini_position

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
