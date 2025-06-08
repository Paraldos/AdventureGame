extends CanvasLayer

func _on_new_btn_pressed() -> void:
	SceneChanger._change_scene("res://world/locations/location_template.tscn")


func _randome_background():
	pass

func _on_load_btn_pressed() -> void:
	print("Load button pressed")