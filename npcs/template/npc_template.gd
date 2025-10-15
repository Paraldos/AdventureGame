extends Node2D
class_name NPC

func _ready() -> void:
	SignalManager.remove_npcs.connect(queue_free)
