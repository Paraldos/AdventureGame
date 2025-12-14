extends Node2D

func _on_button_pressed() -> void:
	Signals.end_battle.emit()
	queue_free()
