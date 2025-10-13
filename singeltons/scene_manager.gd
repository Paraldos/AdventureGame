extends CanvasLayer

@onready var background: TextureRect = %background
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE

func got_to_scene(scene_path : String) -> void:
	await _fade_in()
	get_tree().change_scene_to_file('res://%s.tscn' % scene_path)
	await _fade_out()
	SignalManager.scene_change_finished.emit()

func _fade_in():
	background.mouse_filter = Control.MOUSE_FILTER_STOP
	animation_player.play("fade_in")
	await animation_player.animation_finished
	return

func _fade_out():
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return
