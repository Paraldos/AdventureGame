extends CanvasLayer

@onready var credits_label: Label = %CreditsLabel
var quest
var waiting_time_for_dialog = 0.3

func _ready():
	get_tree().paused = true
	credits_label.text = "Credits: %s" % GameData.credits

func _on_background_btn_pressed() -> void:
	_exit_note()

func _on_btn_pressed() -> void:
	_exit_note()

func _exit_note():
	get_tree().paused = false
	SignalManager.quest_finished.emit()
	if quest.finished_dialog:
		SignalManager.enable_dialog.emit(quest.finished_dialog, true, waiting_time_for_dialog)
	queue_free()
