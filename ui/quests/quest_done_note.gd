extends CanvasLayer

@onready var credits_label: Label = %CreditsLabel
var quest

func _ready():
	credits_label.text = "Credits: %s" % GameData.credits

func _on_background_btn_pressed() -> void:
	SignalManager.quest_finished.emit()
	queue_free()

func _on_btn_pressed() -> void:
	SignalManager.quest_finished.emit()
	queue_free()
