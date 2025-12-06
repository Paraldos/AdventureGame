extends Node2D

@onready var player_display: Marker2D = %PlayerDisplay
@onready var npc_display: Marker2D = %NPCDisplay
@onready var dialog_ui: CanvasLayer = %DialogUi
@onready var battle_ui: CanvasLayer = %BattleUi
@onready var battle_system: Node = %BattleSystem
@onready var dialog_system: Node = %DialogSystem

@export var dialogs : Array[String] = []
@export var player_idle : PackedScene
@export var player_attack1 : PackedScene
@export var player_attack2 : PackedScene
@export var player_defend : PackedScene
@export var player_hurt : PackedScene

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	player_display.update(player_idle)
	_reset_ui()
	for dialog_id in dialogs:
		dialog_system._start_dialog(dialog_id)

func _reset_ui():
	dialog_ui.visible = false
	battle_ui.visible = false
