extends CanvasLayer

func _on_start_btn_pressed() -> void:
	SceneManager.got_to_scene("locations/test_area")
	_new_game()

func _new_game():
	DialogManager.add_dialog_to_game_data("Dialog1")
	DialogManager.add_dialog_to_game_data("Dialog2")
	# actors
	GameData.actors = []
	GameData.actors.resize(7)
	GameData.actors.fill(null)
	# slots
	GameData.slots = [
		Slot.BTN_STATUS.ACTIVE,
		Slot.BTN_STATUS.ACTIVE,
		Slot.BTN_STATUS.ACTIVE,
		Slot.BTN_STATUS.INVISIBLE,
		Slot.BTN_STATUS.INVISIBLE,
		Slot.BTN_STATUS.INVISIBLE 
	]
