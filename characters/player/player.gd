extends Node2D

var moving = false

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		_move(Vector2(-16,0))
	if Input.is_action_pressed("right"):
		_move(Vector2(16,0))
	if Input.is_action_pressed("up"):
		_move(Vector2(0,-16))
	if Input.is_action_pressed("down"):
		_move(Vector2(0,16))

func _move(dir):
	if moving: return
	moving = true
	var target_pos = global_position + dir
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'global_position', target_pos, 0.3)
	await tween.finished
	moving = false
