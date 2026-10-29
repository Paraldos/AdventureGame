@tool
extends Resource
class_name DialogSegment

@export var id: String
@export var content: String

func _init() -> void:
	id = "__" + Resource.generate_scene_unique_id()
