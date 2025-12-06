extends Node

@onready var parent: Node2D = $".."
@onready var player_display: Marker2D = %PlayerDisplay
@onready var npc_display: Marker2D = %NPCDisplay
@onready var battle_ui: CanvasLayer = %BattleUi

var current_battle : Battle
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	Signals.start_battle.connect(_start_battle)
	Signals.use_action.connect(_on_use_action)

func _start_battle(battle_id : String) -> void:
	# guard
	var b = Battles.get_node(battle_id)
	if not b: return
	# basic setup
	parent._reset_ui()
	battle_ui.visible = true
	current_battle = b.duplicate()
	player_display.update(parent.player_idle)
	npc_display.update(current_battle.enemy_idle)
	battle_ui.init_lifebars(current_battle)
	_next_turn()

func _next_turn() -> void:
	battle_ui.update_btns()

func _on_use_action(action : Action):
	_change_player_display(action.player_animation)
	_change_npc_display(action.npc_animation)
	var dice_result = Utils.roll_dice()
	if action.dmg_player:
		pass
	if action.dmg_npc:
		pass
	if action.heal_player:
		pass
	if action.heal_npc:
		pass

func _change_player_display(display_id : int):
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

func _change_npc_display(display_id : int):
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
