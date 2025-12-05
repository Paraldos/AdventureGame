extends Marker2D

var last_display : PackedScene

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
