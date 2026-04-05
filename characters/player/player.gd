extends Node2D

@onready var camera: Camera2D = %Camera
@onready var area: Area2D = %Area
var moving = false
var cell_size = 16

func _ready() -> void:
	Signals.set_camera_rect.connect(on_set_camera_rect)

func on_set_camera_rect(rect : Rect2) -> void:
	camera.limit_left = rect.position[0]
	camera.limit_top = rect.position[1]
	camera.limit_right = rect.size[0] * 16
	camera.limit_bottom = rect.size[1] * 16

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		_prep_move(Vector2(-1,0))
	if Input.is_action_pressed("right"):
		_prep_move(Vector2(1,0))
	if Input.is_action_pressed("up"):
		_prep_move(Vector2(0,-1))
	if Input.is_action_pressed("down"):
		_prep_move(Vector2(0,1))

func _prep_move(dir):
	if moving: return
	var target_pos = global_position + (dir * cell_size)
	var target_cell = Utils.world.tile_map.local_to_map(target_pos)
	if Utils.world.astar_grid.is_point_solid(target_cell): return
	_move(target_pos)

func _move(target_pos):
	moving = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'global_position', target_pos, 0.2)
	await tween.finished
	_end_move()

func _end_move():
	await get_tree().create_timer(0.05).timeout
	var overlaps = area.get_overlapping_areas()
	for overlap in overlaps:
		var parent = overlap.get_parent()
		if parent.has_method("action"):
			parent.action()
	moving = false
