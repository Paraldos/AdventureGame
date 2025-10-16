extends CanvasLayer

func _on_start_btn_pressed() -> void:
	SceneManager.got_to_scene("locations/test_area")
	_new_game()

func _new_game():
	DialogManager.add_dialog_to_game_data("Test/Start")
	# actors
	GameData.actors = []
	GameData.actors.resize(7)
	GameData.actors.fill(null)
