extends Node2D

@onready var idle: AnimatedSprite2D = %Idle
@onready var main_btn: Button = $VBoxContainer/MainBtn
@onready var lifebar: TextureProgressBar = %Lifebar
var index = 0

func _ready() -> void:
	SignalManager.select_hero.connect(_on_select_creature)
	_update_lifebar()

func _on_select_creature():
	main_btn.button_pressed = index == GameData.selected_hero
	if main_btn.button_pressed:
		main_btn.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		main_btn.mouse_filter = Control.MOUSE_FILTER_STOP

func _update_lifebar(slow = false):
	var tween_time = 0.8
	lifebar.max_value = GameData.creatures[index].max_hp * 100
	if slow:
		var tween = create_tween()
		tween.tween_property(lifebar, 'value', GameData.creatures[index].current_hp * 100, tween_time)
	else:
		lifebar.value = GameData.creatures[index].current_hp * 100

func _on_main_btn_pressed() -> void:
	GameData.selected_hero = index
	SignalManager.select_hero.emit()
