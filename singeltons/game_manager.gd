extends Node

enum States { NONE, RECRUTING, BATTLE }
var last_state

var state = States.NONE :
	set(new_state):
		if new_state == state: return
		last_state = state
		_exit()
		state = new_state
		_enter()
		GameData.game_state = new_state

func _exit():
	pass

func _enter():
	SignalManager.state_changed.emit()
