extends PanelContainer
class_name Quest

@onready var quest_open: TextureRect = %QuestOpen
@onready var quest_done: TextureRect = %QuestDone
@onready var label: Label = %Label
@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var title = ""
@export var recruite_mercs = false
@export var required_amount = 0

var open = false

func _ready() -> void:
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
