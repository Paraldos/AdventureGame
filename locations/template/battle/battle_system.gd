extends Node

@onready var parent: Node2D = $".."
@onready var player_display: Marker2D = %PlayerDisplay
@onready var npc_display: Marker2D = %NPCDisplay
@onready var battle_ui: CanvasLayer = %BattleUi

var current_battle : Battle
var rng = RandomNumberGenerator.new()
var turn : int = 0

func _ready() -> void:
	rng.randomize()
	Signals.start_battle.connect(_start_battle)
	Signals.use_action.connect(_on_use_action)

func _start_battle(battle_id : String) -> void:
	# guard
	var b = Battles.get_node(battle_id)
	if not b: return
	# basic setup
	turn = 0
	current_battle = b.duplicate()
	# setup ui
	parent.reset_ui()
	battle_ui.visible = true
	battle_ui.init_lifebars(current_battle)
	battle_ui.init_btns()
	# start
	_next_turn()

func _next_turn() -> void:
	turn += 1
	player_display.update(parent.player_idle)
	npc_display.update(current_battle.enemy_idle)
	if turn % 2 == 0:
		battle_ui.toggle_btns(false)
	else:
		_npc_turn()

func _npc_turn():
	_next_turn()

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

func _on_use_action(action : Action):
	battle_ui.toggle_btns(true)
	_change_player_display(action.player_animation)
	_change_npc_display(action.npc_animation)
	if action.attack != 0.0:
		_player_attack(action)
	if action.heal != 0.0:
		_player_heal(action)
	await get_tree().create_timer(0.5).timeout
	_next_turn()

func _player_attack(action : Action):
	# calc dmg
	var dmg = Utils.roll_dice(6,2)
	dmg += Utils.get_player_attribute(action.attribute)
	dmg *= action.attack
	if Utils.roll_d100() <= GameData.crit: 
		dmg *= 1.5
	dmg -= current_battle.defense
	dmg = int(round(dmg))
	# use dmg
	current_battle.current_hp -= dmg
	npc_display.spawn_floating_number("-%s" % dmg)
	battle_ui.update_lifebars(current_battle)

func _player_heal(action : Action):
	# calc heal
	var heal = Utils.roll_dice(6,2)
	heal += Utils.get_player_attribute(action.attribute)
	heal *= action.heal
	if Utils.roll_d100() <= GameData.crit: 
		heal *= 1.5
	heal = int(round(heal))
	# use heal
	GameData.current_hp += heal
	player_display.spawn_floating_number("+%s" % heal)
	battle_ui.update_lifebars(current_battle)
