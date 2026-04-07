extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true

func _on_tree_exiting() -> void:
	get_tree().paused = false
