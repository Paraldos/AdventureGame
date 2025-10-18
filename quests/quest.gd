extends Node
class_name Quest

enum QuestTypes { RECRUITE_MERCS }
enum QuestStates { NONE, OPEN, SOLVED, CLOSED }

@export var text = ""
@export var quest_type : QuestTypes
@export var required_amount = 0
@export var reward_credits = 500
@export var follow_up_dialog : String

var id
var state = QuestStates.NONE :
	set(new_state):
		if new_state == state: return
		state = new_state
		GameData.quests[id] = { state = state }

# ================================================ ready
func _ready() -> void:
	SignalManager.start_quest.connect(_on_start_quest)
	SignalManager.finish_quest.connect(_on_finish_quest)
	SignalManager.update_quest.connect(_on_update_quest)
	#
	id = name
	await get_tree().process_frame
	Utils.list_of_quests[id] = self

func _on_start_quest(quest_id : String):
	if quest_id != id: return
	state = QuestStates.OPEN

func _on_finish_quest():
	state = QuestStates.CLOSED

# ================================================ upadte
func _on_update_quest():
	#
	if state == QuestStates.NONE: return
	if state == QuestStates.CLOSED: return
	#
	if quest_type == QuestTypes.RECRUITE_MERCS:
		if _recruite_mercs_check():
			state = QuestStates.SOLVED
		else:
			state = QuestStates.OPEN
	SignalManager.enable_dialog.emit(follow_up_dialog, state == QuestStates.SOLVED)

func _recruite_mercs_check():
	var amount_of_mercs = 0
	for index in range(0,3):
		var actor = GameData.actors[index]
		if actor:
			amount_of_mercs += 1
	return amount_of_mercs >= required_amount
