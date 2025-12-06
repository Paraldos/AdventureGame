extends Node2D

@onready var player_display: Marker2D = %PlayerDisplay
@onready var npc_display: Marker2D = %NPCDisplay
@onready var dialog_ui: CanvasLayer = %DialogUi
@onready var battle_ui: CanvasLayer = %BattleUi

@export var dialogs : Array[String] = []
@export var player_idle : PackedScene
@export var player_attack1 : PackedScene
@export var player_attack2 : PackedScene
@export var player_hurt : PackedScene

var current_battle : Battle

func _ready() -> void:
	player_display.update(player_idle)
	_reset_ui()
	for dialog_id in dialogs:
		_start_dialog(dialog_id)
	Signals.change_dialog_node.connect(_change_dialog_node)
	Signals.end_dialog.connect(_end_dialog)
	Signals.start_battle.connect(_start_battle)

# battle system
func _start_battle(battle_id : String) -> void:
	# guard
	var b = Battles.get_node(battle_id)
	if not b: return
	# basic setup
	_reset_ui()
	battle_ui.visible = true
	current_battle = b.duplicate()
	player_display.update(player_idle)
	npc_display.update(current_battle.enemy_idle)
	battle_ui.init_lifebars(current_battle)
	_next_turn()

func _next_turn() -> void:
	battle_ui.update_btns()

# dialog system
func _start_dialog(dialog_id : String) -> void:
	var d: DialogNode = Dialogs.get_node(dialog_id)
	if not d: return
	_reset_ui()
	dialog_ui.visible = true
	_change_dialog_node(d)

func _change_dialog_node(d : DialogNode):
	dialog_ui.update_label(d)
	dialog_ui.update_options(d)
	if d.player_display:
		player_display.update(d.player_display)
	if d.npc_display:
		npc_display.update(d.npc_display)

func _end_dialog():
	_reset_ui()
	npc_display.remove_display()
	player_display.update(player_idle)

# helper
func _reset_ui():
	dialog_ui.visible = false
	battle_ui.visible = false
