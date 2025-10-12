extends CanvasLayer

func _ready() -> void:
	SignalManager.scene_change_finished.connect(_on_scene_change_finished)

func _on_scene_change_finished():
	pass
