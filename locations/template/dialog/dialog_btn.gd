extends Button

var option : DialogOption

func _ready() -> void:
	if option and option.text:
		text = "%s" % option.text
	else:
		text = "End"

func _on_pressed() -> void:
	if option and option.battle_id:
		Signals.start_battle.emit(option.battle_id)
	elif option and option.target:
		Signals.change_dialog_node.emit(option.target)
	else:
		Signals.end_dialog.emit()
