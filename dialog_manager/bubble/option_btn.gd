extends Button

var option : DialogOption
var parent_bubble : DialogBubble

func _on_pressed() -> void:
	if option.target_id:
		DialogManager.start_dialog(option.target_id)
	else:
		DialogManager.end_dialog()
	parent_bubble.queue_free()
