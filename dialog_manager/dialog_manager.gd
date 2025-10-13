extends CanvasLayer

# ============================================ ready
func _ready() -> void:
	SignalManager.scene_change_finished.connect(_on_scene_change_finished)

func _on_scene_change_finished() -> void:
	var dialog_id_for_this_location = _get_dialog_id_for_this_location()
	if dialog_id_for_this_location:
		start_dialog(dialog_id_for_this_location)

# ============================================ API
func add_dialog_to_game_data(id: String) -> void:
	GameData.dialog_queue.append( id )

func start_dialog(dialog_id: String) -> void:
	var dialog = get_node(dialog_id)
	if not dialog: return
	print(dialog_id)

# ============================================ helper
func _get_dialog_id_for_this_location() -> String:
	var current_location = Utils.current_location.scene_file_path.get_file().get_basename()
	for dialog_id in GameData.dialog_queue:
		var dialog = get_node(dialog_id)
		if not dialog: continue
		if not dialog.location: continue
		if dialog.location.find(current_location):
			return dialog_id
	return ""
