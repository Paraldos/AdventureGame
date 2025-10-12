extends CanvasLayer

func _ready() -> void:
	SignalManager.scene_change_finished.connect(_on_scene_change_finished)

func _on_scene_change_finished():
	_check_for_open_dialogs()

func _check_for_open_dialogs():
	print(Utils.current_location.scene_file_path.get_file().get_basename())

func add_dialog(id: String, location: String = "") -> void:
	GameData.dialog_queue.append( { "id": id, "location": location } )
	emit_signal("dialog_requested")
