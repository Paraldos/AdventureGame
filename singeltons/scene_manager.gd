extends CanvasLayer

@onready var color_rect: ColorRect = %ColorRect
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	color_rect.modulate = Color("ffffff00")
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func got_to_scene(scene_path : String) -> void:
	await _fade_in()
	get_tree().change_scene_to_file('res://%s.tscn' % scene_path)
	_fade_out()

func _fade_in():
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	animation_player.play("fade_in")
	await animation_player.animation_finished
	return

func _fade_out():
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return
