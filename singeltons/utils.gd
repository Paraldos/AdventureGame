extends Node

var debug_map = false
var world
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func string_to_id(text: String):
	var id = text.to_lower()
	id = id.replace(" ", "_")
	return id

func d6():
	return rng.randi_range(1,6)
