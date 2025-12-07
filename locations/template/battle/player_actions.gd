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
	Signals.start_player_turn.connect(_on_start_player_turn)
	Signals.action_btn_clicked.connect(_on_action_btn_clicked)

func _start_battle(_battle_id : String) -> void:
	await get_tree().create_timer(0.3).timeout
	current_battle = battle_system.current_battle

func _on_start_player_turn():
	battle_ui.toggle_btns(false)

func _on_action_btn_clicked(action : Action):
	battle_ui.toggle_btns(true)
	_animation(action)
	_player_attack(action)
	_player_heal(action)
	await get_tree().create_timer(battle_system.time_to_wait_after_turn).timeout
	Signals.next_turn.emit()

func _animation(action : Action):
	battle_system.change_player_display(action.player_animation)
	battle_system.change_npc_display(action.npc_animation)

func _player_attack(action : Action):
	if action.attack == 0.0: return
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
	if action.heal == 0.0: return
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
