extends CanvasLayer

var bp_dialog_bubble = preload("res://dialog_manager/dialog_bubble.tscn")
@onready var background_btn: Button = %BackgroundBtn

# ============================================ ready
func _ready() -> void:
	SignalManager.scene_change_finished.connect(_on_scene_change_finished)
	background_btn.mouse_filter = Control.MOUSE_FILTER_IGNORE

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
	GameManager.state = GameManager.States.DIALOG
	background_btn.mouse_filter = Control.MOUSE_FILTER_STOP
	var bubble = bp_dialog_bubble.instantiate()
	bubble.dialog = dialog
	add_child(bubble)

func _on_button_pressed() -> void:
	if not GameManager.state == GameManager.States.DIALOG: return
	print('bert')

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
