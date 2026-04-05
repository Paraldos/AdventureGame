extends Node2D

@onready var camera: Camera2D = %Camera
var moving = false

func _ready() -> void:
	Signals.set_camera_rect.connect(on_set_camera_rect)

func on_set_camera_rect(rect : Rect2) -> void:
	print(rect.size[1] * 16)
	camera.limit_left = rect.position[0]
	camera.limit_top = rect.position[1]
	camera.limit_right = rect.size[0] * 16
	camera.limit_bottom = rect.size[1] * 16

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		_prep_move(Vector2(-16,0))
	if Input.is_action_pressed("right"):
		_prep_move(Vector2(16,0))
	if Input.is_action_pressed("up"):
		_prep_move(Vector2(0,-16))
	if Input.is_action_pressed("down"):
		_prep_move(Vector2(0,16))

func _prep_move(dir):
	if moving: return
	var target_pos = global_position + dir
	var target_cell = Utils.world.tile_map.local_to_map(target_pos)
	if Utils.world.astar_grid.is_point_solid(target_cell): return
	_move(target_pos)

func _move(target_pos):
	moving = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'global_position', target_pos, 0.2)
	await tween.finished
	await get_tree().create_timer(0.05).timeout
	moving = false
