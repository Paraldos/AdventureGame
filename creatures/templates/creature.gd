extends Node2D

@onready var idle: AnimatedSprite2D = %Idle
@onready var main_btn: Button = $VBoxContainer/MainBtn
var index = 0

func _ready() -> void:
	SignalManager.select_hero.connect(_on_select_creature)

func _on_select_creature():
	main_btn.button_pressed = index == GameData.selected_hero
	if not index == GameData.selected_hero: return

func _on_main_btn_pressed() -> void:
	GameData.selected_hero = index
	SignalManager.select_hero.emit()
