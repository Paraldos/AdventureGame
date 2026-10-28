extends Area2D
class_name Bumper

signal bump

func _ready() -> void:
	bump.connect(on_bumped)

func on_bumped():
	print('bumped')
