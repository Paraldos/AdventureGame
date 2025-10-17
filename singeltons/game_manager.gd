extends Node

enum States { NONE, RECRUTING, BATTLE }
var last_state

# =========================================== update game data
func add_credits(value) -> void:
	GameData.credits += value
	SignalManager.update_credits.emit()

# =========================================== new game
func new_game():
	# dialogs
	for dialog in GameData.dialogs:
		dialog[1] = false
	SignalManager.enable_dialog.emit("Start", true)
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
