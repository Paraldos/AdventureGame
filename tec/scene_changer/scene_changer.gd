extends CanvasLayer

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _change_scene(new_scene_path):
	if !new_scene_path: return
	animation_player.play("fade_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(new_scene_path)
	await get_tree().create_timer(0.1).timeout
	animation_player.play("fade_out")
