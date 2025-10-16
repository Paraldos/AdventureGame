extends PanelContainer
class_name Quest

enum QuestTypes { RECRUITE_MERCS }

@onready var quest_open: TextureRect = %QuestOpen
@onready var quest_done: TextureRect = %QuestDone
@onready var label: Label = %Label
@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var title = ""
@export var quest_type : QuestTypes
@export var required_amount = 0

var open = false
var solved = false

func _ready() -> void:
	SignalManager.merc_recruited.connect(update)
	visible = false
	quest_done.visible = false
	label.text = title

func open_quest():
	visible = true
	quest_open.visible = true
	animation_player.play('fade_in')
	GameData.open_quests.append(name)

func solve_quest():
	visible = false
	GameData.closed_quests.append(name)

func quit_quest():
	pass

# ================================================ update
func update():
	match quest_type:
		QuestTypes.RECRUITE_MERCS:
			print(_recruite_mercs_check())

func _recruite_mercs_check():
	var amount_of_mercs = 0
	for index in range(0,3):
		var actor = GameData.actors[index]
		if actor:
			amount_of_mercs += 1
	return amount_of_mercs >= required_amount