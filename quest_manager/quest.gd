extends PanelContainer
class_name Quest

enum QuestTypes { RECRUITE_MERCS }
enum QuestStates { NONE, OPEN, SOLVED, FINISHED, FAILED }

@onready var quest_open: TextureRect = %QuestOpen
@onready var quest_done: TextureRect = %QuestDone
@onready var label: Label = %Label
@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var title = ""
@export var quest_type : QuestTypes
@export var required_amount = 0
@export var follow_up_dialog : String
@export var start_battle : String

var bp_quest_done_notification = preload("res://quest_manager/quest_done_notification.tscn")
var quest_state = QuestStates.FAILED :
	set(new_state):
		if new_state == quest_state: return
		visible = new_state == QuestStates.OPEN or new_state == QuestStates.SOLVED
		quest_open.visible = new_state == QuestStates.OPEN
		quest_done.visible = new_state == QuestStates.SOLVED
		quest_state = new_state

# ================================================ ready
func _ready() -> void:
	SignalManager.start_quest.connect(_on_start_quest)
	SignalManager.merc_recruited.connect(_update)
	SignalManager.finish_quest.connect(_on_finish_quest)
	quest_state = QuestStates.NONE
	label.text = title

func _on_start_quest(quest_id : String):
	if quest_id != name: return
	animation_player.play('fade_in')
	quest_state = QuestStates.OPEN
	GameData.open_quests.append(name)

func _on_finish_quest(quest_id : String):
	if quest_id != name: return
	if quest_state != QuestStates.SOLVED: return
	animation_player.play_backwards('fade_in')
	await animation_player.animation_finished
	quest_state = QuestStates.FINISHED
	#
	var quest_done_notification = bp_quest_done_notification.instantiate()
	get_tree().current_scene.add_child(quest_done_notification)
	print('finished')

func quit_quest():
	GameData.closed_quests.append(name)

# ================================================ update
func _update():
	if quest_state == QuestStates.NONE: return
	if quest_state == QuestStates.FINISHED: return
	if quest_state == QuestStates.FAILED: return
	if quest_type == QuestTypes.RECRUITE_MERCS:
		if _recruite_mercs_check():
			quest_state = QuestStates.SOLVED
		else:
			quest_state = QuestStates.OPEN
	if quest_state == QuestStates.SOLVED:
		DialogManager.add_dialog_to_game_data(follow_up_dialog)

func _recruite_mercs_check():
	var amount_of_mercs = 0
	for index in range(0,3):
		var actor = GameData.actors[index]
		if actor:
			amount_of_mercs += 1
	return amount_of_mercs >= required_amount
