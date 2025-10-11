extends CanvasLayer

func _on_start_btn_pressed() -> void:
	SceneManager.got_to_scene("game/game")
	_new_game()

func _new_game():
	GameData.creatures.append(CreatureManager.create_hero())
	GameData.creatures.append(CreatureManager.create_hero())
	GameData.creatures.append(CreatureManager.create_hero())
