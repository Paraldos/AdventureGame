extends Node

@onready var parent: Node2D = $".."
@onready var player_display: Marker2D = %PlayerDisplay
@onready var npc_display: Marker2D = %NPCDisplay
@onready var battle_ui: CanvasLayer = %BattleUi

var current_battle : Battle
var rng = RandomNumberGenerator.new()
var time_to_wait_after_turn = 1.0

func _ready() -> void:
	rng.randomize()
	Signals.start_battle.connect(_start_battle)

func _start_battle(battle_id : String) -> void:
	# basic setup
	current_battle = Battles.get_node(battle_id).duplicate()
	current_battle.current_hp = current_battle.max_hp
	# setup ui
	parent.reset_ui()
	battle_ui.visible = true
	battle_ui.init_lifebars(current_battle)
	battle_ui.init_btns()
	# start
	Signals.start_player_turn.emit()

func _start_player_turn():
	battle_ui.toggle_btns(false)

func change_player_display(display_id : int):
	match display_id:
		GlobalEnums.BattleAnimations.ATTACK:
			var player_attacks = [parent.player_attack1, parent.player_attack2]
			var attack_number = rng.randi_range(0,1)
			player_display.update(player_attacks[attack_number]) 
		GlobalEnums.BattleAnimations.DEFEND:
			player_display.update(parent.player_defend)
		GlobalEnums.BattleAnimations.HURT:
			player_display.update(parent.player_hurt)
		GlobalEnums.BattleAnimations.IDLE:
			player_display.update(parent.player_idle)

func change_npc_display(display_id : int):
	match display_id:
		GlobalEnums.BattleAnimations.ATTACK:
			var npc_attacks = [current_battle.enemy_attack1, current_battle.enemy_attack2]
			var attack_number = rng.randi_range(0,1)
			npc_display.update(npc_attacks[attack_number])
		GlobalEnums.BattleAnimations.DEFEND:
			npc_display.update(current_battle.enemy_defend)
		GlobalEnums.BattleAnimations.HURT:
			npc_display.update(current_battle.enemy_hurt)
		GlobalEnums.BattleAnimations.IDLE:
			npc_display.update(current_battle.enemy_idle)
