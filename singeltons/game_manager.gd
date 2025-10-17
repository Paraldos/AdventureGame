extends Node

enum States { NONE, RECRUTING, BATTLE }
var last_state

# =========================================== new game
func new_game():
	DialogManager.add_dialog_to_game_data("Tutorial/Start")
	# actors
	GameData.actors = []
	GameData.actors.resize(7)
	GameData.actors.fill(null)
	GameData.credits = 0

# =========================================== state
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
