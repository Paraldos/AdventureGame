extends Node

enum States { NONE, HEROCREATION, BATTLE, DIALOG }
var last_state

var state = States.NONE :
	set(new_state):
		if new_state == state: return
		last_state = state
		_exit()
		state = new_state
		_enter(new_state)
		GameData.game_state = new_state

func _exit():
	match state:
		States.NONE:
			pass
		States.DIALOG:
			DialogManager.disable_background_btn()

func _enter(new_state):
	match new_state:
		States.DIALOG:
			DialogManager.disable_background_btn(false)
