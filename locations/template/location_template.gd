extends Node2D

@onready var player_display: Marker2D = %PlayerDisplay
@onready var npc_display: Marker2D = %NPCDisplay
@onready var dialog_ui: CanvasLayer = %DialogUi
@onready var battle_ui: CanvasLayer = %BattleUi

@export var dialogs : Array[String] = []
@export var player_idle : PackedScene
@export var player_attack1 : PackedScene
@export var player_attack2 : PackedScene
@export var player_defend : PackedScene
@export var player_hurt : PackedScene

var current_battle : Battle
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	player_display.update(player_idle)
	_reset_ui()
	for dialog_id in dialogs:
		_start_dialog(dialog_id)
	Signals.change_dialog_node.connect(_change_dialog_node)
	Signals.end_dialog.connect(_end_dialog)
	Signals.start_battle.connect(_start_battle)
	Signals.change_display.connect(_on_change_display)

func _on_change_display(display_id, change_player_display):
	match display_id:
		GlobalEnums.BattleAnimations.ATTACK:
			var player_attacks = [player_attack1, player_attack2]
			var npc_attacks = [current_battle.enemy_attack1, current_battle.enemy_attack2]
			var attack_number = rng.randi_range(0,1)
			if change_player_display:
				player_display.update(player_attacks[attack_number]) 
			else:
				npc_display.update(npc_attacks[attack_number])
		GlobalEnums.BattleAnimations.DEFEND:
			if change_player_display:
				player_display.update(player_defend)
			else:
				npc_display.update(current_battle.enemy_defend)
		GlobalEnums.BattleAnimations.HURT:
			if change_player_display:
				player_display.update(player_hurt)
			else:
				npc_display.update(current_battle.enemy_hurt)
		GlobalEnums.BattleAnimations.IDLE:
			if change_player_display:
				player_display.update(player_idle)
			else:
				npc_display.update(current_battle.enemy_idle)

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
