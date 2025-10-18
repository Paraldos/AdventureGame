extends PanelContainer

@onready var quest_open: TextureRect = %QuestOpen
@onready var quest_done: TextureRect = %QuestDone
@onready var label: Label = %Label
@onready var animation_player: AnimationPlayer = %AnimationPlayer
var quest_id
var quest : Quest

func _ready() -> void:
	SignalManager.update_quest.connect(_on_update_quest)
	animation_player.play('fade_in')
	quest = Utils.list_of_quests[quest_id]
	print(quest)
	label.text = quest.text
	_update_visibility()

func _on_update_quest():
	await get_tree().process_frame
	_update_visibility()

func _update_visibility():
	quest_open.visible = quest.state == Quest.QuestStates.OPEN
	quest_done.visible = quest.state == Quest.QuestStates.SOLVED
