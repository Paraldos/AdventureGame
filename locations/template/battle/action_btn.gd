extends Button

var action

func _ready() -> void:
	icon = action.icon

func _on_pressed() -> void:
	Signals.change_battle_display.emit(action.player_animation, true)
	Signals.change_battle_display.emit(action.npc_animation, false)

func _on_mouse_entered() -> void:
	Signals.change_action_description.emit(action.description)

func _on_mouse_exited() -> void:
	Signals.change_action_description.emit("")
