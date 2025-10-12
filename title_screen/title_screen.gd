extends CanvasLayer

func _on_start_btn_pressed() -> void:
	SceneManager.got_to_scene("game/game")
	_new_game()

func _new_game():
	GameData.actors = []
	GameData.actors.resize(7)
	GameData.actors.fill(null)
	GameData.slots = [
		Slot.BTN_STATUS.ACTIVE,
		Slot.BTN_STATUS.ACTIVE,
		Slot.BTN_STATUS.ACTIVE,
		Slot.BTN_STATUS.INVISIBLE,
		Slot.BTN_STATUS.INVISIBLE,
		Slot.BTN_STATUS.INVISIBLE 
	]
