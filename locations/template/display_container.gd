extends Marker2D

func update(display_bp : PackedScene):
	for child in get_children():
		child.queue_free()
	var instance = display_bp.instantiate()
	instance.position = Vector2.ZERO
	add_child(instance)
