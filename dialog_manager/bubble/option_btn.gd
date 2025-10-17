extends Btn

var parent_dialog : Dialog
var option : DialogOption

func _ready() -> void:
	text = option.text

func _on_pressed() -> void:
	SignalManager.dialog_option_selected.emit( parent_dialog.id, option )
	SignalManager.remove_dialog_bubbles.emit()
