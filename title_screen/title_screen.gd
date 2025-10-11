extends CanvasLayer

func _on_start_btn_pressed() -> void:
	_new_game()
	SceneManager.got_to_scene("game/game")

func _new_game():
	pass
