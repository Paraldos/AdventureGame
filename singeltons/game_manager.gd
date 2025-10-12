extends Node

enum STATES { NONE, HEROCREATION, BATTLE, CONVERSATION }

var state = STATES.NONE :
	set(new_state):
		if new_state == state: return
		_exit()
		state = new_state
		_enter(new_state)
		GameData.game_state = new_state

func _exit():
	match state:
		STATES.NONE:
			pass
		STATES.HEROCREATION:
			pass

func _enter(new_state):
	match new_state:
		STATES.HEROCREATION:
			pass
		STATES.BATTLE:
			pass
