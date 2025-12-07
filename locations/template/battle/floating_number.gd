extends Node2D

@onready var label: Label = $Label
var colors = [Color('red')]

func start(text : String) -> void:
	# label
	label.modulate = colors[0]
	label.text = text
	# position
	var tween_pos := create_tween()
	var target_pos = position + Vector2(0, -40)
	tween_pos.tween_property(self, "position", target_pos, 1.0)
	# visibility
	var tween_modulate = create_tween()
	tween_modulate.tween_property(self, "modulate", Color(255, 255, 255, 0), 1.0)
	# queue free
	await tween_modulate.finished
	queue_free()
