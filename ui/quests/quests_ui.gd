extends MarginContainer

@onready var list_of_quests: VBoxContainer = %ListOfQuests
var bp_quest_note = preload("res://ui/quests/quest_note.tscn")

func _ready() -> void:
	SignalManager.start_quest.connect(_on_start_quest)

func _on_start_quest(quest_id : String):
	var note = bp_quest_note.instantiate()
	note.quest_id = quest_id
	list_of_quests.add_child(note)
