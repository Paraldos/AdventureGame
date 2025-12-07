extends Marker2D

var last_display : PackedScene
var floating_number_bp = preload("res://locations/template/battle/floating_number.tscn")

func update(display_bp : PackedScene) -> void:
	if last_display == display_bp: return
	remove_display()
	last_display = display_bp
	var instance = display_bp.instantiate()
	instance.position = Vector2.ZERO
	add_child(instance)

func remove_display():
	for child in get_children():
		child.queue_free()

func spawn_floating_number(txt : String):
	var number = floating_number_bp.instantiate()
	number.position = position + Vector2(0, -70)
	get_tree().current_scene.add_child(number)
	number.start(txt)
