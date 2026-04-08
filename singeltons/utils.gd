extends Node

var debug_map = false
var world
var rng = RandomNumberGenerator.new()
var floating_number_bp = preload("res://floating_number/floating_number.tscn")

func _ready() -> void:
	rng.randomize()

func string_to_id(text: String):
	var id = text.to_lower()
	id = id.replace(" ", "_")
	return id

func d6():
	return rng.randi_range(1,6)

func spawn_floating_number(pos: Vector2, number: int, color: Color):
	var floating_number = floating_number_bp.instantiate()
	floating_number.number = number
	floating_number.color = color
	floating_number.start_pos = pos
	get_tree().current_scene.add_child(floating_number)
