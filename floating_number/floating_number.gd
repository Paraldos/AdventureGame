extends CanvasLayer

@onready var anchor: Node2D = %Anchor
@onready var label: Label = %Label
var tween_time = 0.8
var number = 123
var color : Color
var start_pos := Vector2.ZERO
var target_pos: Vector2

func _ready() -> void:
	anchor.global_position = start_pos
	target_pos = start_pos + Vector2(0, -15)
	label.text = "%s" % number
	if color:
		label.modulate = color
	_fade()
	_move()

func _fade():
	var tween = create_tween()
	tween.tween_property(anchor, "modulate", Color("000000"), tween_time)

func _move():
	var tween = create_tween()
	tween.tween_property(anchor, "global_position", target_pos, tween_time)
	await tween.finished
	queue_free()
