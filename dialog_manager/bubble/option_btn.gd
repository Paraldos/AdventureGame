extends Btn

var option : DialogOption
var parent_bubble : DialogBubble

func _on_pressed() -> void:
	DialogManager.next_step(option)
