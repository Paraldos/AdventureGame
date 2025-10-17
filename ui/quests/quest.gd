extends PanelContainer
class_name Quest

enum QuestTypes { RECRUITE_MERCS }
enum QuestStates { NONE, READY, OPEN, SOLVED, CLOSED }

@onready var quest_open: TextureRect = %QuestOpen
@onready var quest_done: TextureRect = %QuestDone
@onready var label: Label = %Label
@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var title = ""
@export var quest_type : QuestTypes
@export var required_amount = 0
@export var reward_credits = 500
@export_category('Quest Finished')
@export var follow_up_dialog : String

var bp_quest_done_notification = preload("res://ui/quests/quest_done_notification.tscn")
var quest_state = QuestStates.NONE :
	set(new_state):
		if new_state == quest_state: return
		visible = new_state == QuestStates.OPEN or new_state == QuestStates.SOLVED
		quest_open.visible = new_state == QuestStates.OPEN
		quest_done.visible = new_state == QuestStates.SOLVED
		quest_state = new_state

# ================================================ ready
func _ready() -> void:
	SignalManager.start_quest.connect(_on_start_quest)
	SignalManager.merc_recruited.connect(_update_quest)
	SignalManager.finish_quest.connect(_on_finish_quest)
	label.text = title
	if GameData.open_quests.find(name) > 0:
		quest_state = QuestStates.OPEN
		_update_quest()
	elif GameData.closed_quests.find(name):
		quest_state = QuestStates.CLOSED
	else:
		quest_state = QuestStates.READY

func _on_start_quest(quest_id : String):
	if quest_id != name: return
	animation_player.play('fade_in')
	quest_state = QuestStates.OPEN
	GameData.open_quests.append(name)

func _on_finish_quest(quest_id : String):
	# guard
	if quest_id != name: return
	if quest_state != QuestStates.SOLVED: return
	# animation
	animation_player.play_backwards('fade_in')
	await animation_player.animation_finished
	quest_state = QuestStates.CLOSED
	# reward
	GameManager.add_credits(reward_credits)
	# message
	var quest_done_notification = bp_quest_done_notification.instantiate()
	get_tree().current_scene.add_child(quest_done_notification)

func quit_quest():
	GameData.closed_quests.append(name)

# ================================================ update
func _update_quest():
	if quest_state == QuestStates.READY: return
	if quest_state == QuestStates.CLOSED: return
	if quest_type == QuestTypes.RECRUITE_MERCS:
		if _recruite_mercs_check():
			quest_state = QuestStates.SOLVED
		else:
			quest_state = QuestStates.OPEN
	if quest_state == QuestStates.SOLVED:
		DialogManager.add_dialog_to_game_data(follow_up_dialog)
	else:
		DialogManager.remve_dialog_from_game_data(follow_up_dialog)

func _recruite_mercs_check():
	var amount_of_mercs = 0
	for index in range(0,3):
		var actor = GameData.actors[index]
		if actor:
			amount_of_mercs += 1
	return amount_of_mercs >= required_amount
