extends Node

@onready var battle_system: Node = %BattleSystem
@onready var battle_ui: CanvasLayer = %BattleUi
@onready var player_display: Marker2D = %PlayerDisplay
@onready var npc_display: Marker2D = %NPCDisplay
var current_battle : Battle
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	Signals.start_battle.connect(_start_battle)
	Signals.start_npc_turn.connect(_on_start_npc_turn)

func _start_battle(_battle_id : String) -> void:
	await get_tree().create_timer(0.3).timeout
	current_battle = battle_system.current_battle

func _on_start_npc_turn():
	var action =_select_action()
	_animation(action)
	_npc_attack(action)
	_npc_heal(action)
	await get_tree().create_timer(battle_system.time_to_wait_after_turn).timeout
	Signals.next_turn.emit()

func _select_action():
	current_battle.actions.shuffle()
	return Actions.get_node(current_battle.actions[0])

func _animation(action : Action):
	battle_system.change_player_display(action.player_animation)
	battle_system.change_npc_display(action.npc_animation)

func _npc_attack(action : Action):
	if action.attack == 0.0: return
	# calc dmg
	var dmg = Utils.roll_dice(6,2)
	dmg += Utils.get_battle_attribute(action.attribute, current_battle)
	dmg *= action.attack
	if Utils.roll_d100() <= GameData.crit: dmg *= 1.5
	dmg -= GameData.defense
	dmg = int(round(dmg))
	# use dmg
	GameData.current_hp -= dmg
	player_display.spawn_floating_number("-%s" % dmg)
	battle_ui.update_lifebars(current_battle)

func _npc_heal(action : Action):
	if action.heal == 0.0: return
	# calc heal
	var heal = Utils.roll_dice(6,2)
	heal += Utils.get_battle_attribute(action.attribute, current_battle)
	heal *= action.heal
	if Utils.roll_d100() <= GameData.crit: heal *= 1.5
	heal = int(round(heal))
	# use heal
	current_battle.current_hp += heal
	npc_display.spawn_floating_number("+%s" % heal)
	battle_ui.update_lifebars(current_battle)
