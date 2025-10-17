extends CanvasLayer

func _on_start_btn_pressed() -> void:
	SceneManager.got_to_scene("locations/test_area")
	GameManager.new_game()
