extends Node2D

@onready var main_sprite: Sprite2D = %MainSprite
@onready var movement_detector: RayCast2D = %MovementDetector
@onready var bump_detector: RayCast2D = %BumpDetector

const MOVE_TIME := 0.15
const OFFSET := Vector2(8,8)
var animating : = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if animating:
		return
	if Input.is_action_pressed("down"):
		_try_move(Vector2.DOWN)
	elif Input.is_action_pressed("up"):
		_try_move(Vector2.UP)
	elif Input.is_action_pressed("left"):
		_try_move(Vector2.LEFT)
	elif Input.is_action_pressed("right"):
		_try_move(Vector2.RIGHT)

var direction_frames := {
	Vector2.RIGHT: 0,
	Vector2.LEFT: 1,
	Vector2.DOWN: 2,
	Vector2.UP: 3
}
func _try_move(dir: Vector2) -> void:
	animating = true

	main_sprite.frame = direction_frames[dir]

	var angle := dir.angle()
	bump_detector.rotation = angle
	movement_detector.rotation = angle

	bump_detector.force_raycast_update()
	movement_detector.force_raycast_update()

	if bump_detector.is_colliding():
		_bump()
	elif not movement_detector.is_colliding():
		await _move(global_position, dir)
	animating = false

func _bump() -> void:
	var target = bump_detector.get_collider()
	if target and target.has_signal("bump"):
		target.emit_signal("bump")

func _move(old_pos: Vector2, dir: Vector2) -> void:
	var new_pos = old_pos + dir * 16
	global_position = new_pos
	main_sprite.global_position = old_pos + OFFSET
	var t = create_tween()
	t.tween_property(main_sprite, "global_position", new_pos + OFFSET, MOVE_TIME)
	await t.finished
