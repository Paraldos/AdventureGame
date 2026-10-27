extends Node2D

@onready var main_sprite: Sprite2D = %MainSprite
@export var right: RayCast2D
@export var left: RayCast2D
@export var down: RayCast2D
@export var up: RayCast2D

const MOVE_TIME := 0.15
var animating = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if animating:
		return
	if Input.is_action_pressed("down"):
		_move(Vector2.DOWN)
	elif Input.is_action_pressed("up"):
		_move(Vector2.UP)
	elif Input.is_action_pressed("left"):
		_move(Vector2.LEFT)
	elif Input.is_action_pressed("right"):
		_move(Vector2.RIGHT)

func _move(dir: Vector2) -> void:
	match dir:
		Vector2.RIGHT:
			main_sprite.frame = 0
			if right.is_colliding(): return
		Vector2.LEFT:
			main_sprite.frame = 1
			if left.is_colliding(): return
		Vector2.DOWN:
			main_sprite.frame = 2
			if down.is_colliding(): return
		Vector2.UP:
			main_sprite.frame = 3
			if up.is_colliding(): return
		_:
			return
	var old_pos = global_position
	var new_pos = global_position + dir * 16
	global_position = new_pos
	_move_animation(new_pos, old_pos)

func _move_animation(new_pos: Vector2, old_pos: Vector2) -> void:
	animating = true
	main_sprite.global_position = old_pos
	var t = create_tween()
	t.tween_property(main_sprite, "global_position", new_pos, MOVE_TIME)
	await t.finished
	animating = false
