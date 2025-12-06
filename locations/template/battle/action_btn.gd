extends Button

var action

func _ready() -> void:
	icon = action.icon

func _on_pressed() -> void:
	pass # Replace with function body.

func _on_mouse_entered() -> void:
	Signals.change_action_description.emit(action.description)

func _on_mouse_exited() -> void:
	Signals.change_action_description.emit("")
