extends Node

enum GAMESTATES { NONE, HEROCREATION, BATTLE, CONVERSATION }

var state = GAMESTATES.NONE :
	set(new_state):
		if new_state == state: return
		_exit()
		state = new_state
		_enter(new_state)
		GameData.game_state = new_state

func _exit():
	match state:
		GAMESTATES.NONE:
			pass
		GAMESTATES.HEROCREATION:
			pass

func _enter(new_state):
	match new_state:
		GAMESTATES.HEROCREATION:
			pass
		GAMESTATES.BATTLE:
			pass
