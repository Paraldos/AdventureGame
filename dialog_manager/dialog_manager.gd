extends CanvasLayer

@onready var background_btn: Button = %BackgroundBtn
var bp_dialog_bubble = preload("res://dialog_manager/dialog_bubble.tscn")
var bp_option_btn = preload("res://dialog_manager/option_btn.tscn")
var current_bubble

# ============================================ ready
func _ready() -> void:
	SignalManager.scene_change_finished.connect(_on_scene_change_finished)
	disable_background_btn()

func _on_scene_change_finished() -> void:
	var dialog_id_for_this_location = _get_dialog_id_for_this_location()
	if dialog_id_for_this_location:
		start_dialog(dialog_id_for_this_location)

func _on_background_btn_pressed() -> void:
	SignalManager.background_btn_clicked.emit()

# ============================================ API
func add_dialog_to_game_data(dialog_id: String) -> void:
	GameData.dialog_queue.append( dialog_id )

func start_dialog(dialog_id: String) -> void:
	# guard
	var dialog = get_node(dialog_id)
	if not dialog: return
	# basics
	GameManager.state = GameManager.States.DIALOG
	# inst bubble
	var bubble = bp_dialog_bubble.instantiate()
	bubble.dialog = dialog
	add_child(bubble)

func move_to_next_dialog(dialog_id: String):
	# guard
	var dialog = get_node(dialog_id)
	if not dialog: return
	# inst bubble
	var bubble = bp_dialog_bubble.instantiate()
	bubble.dialog = dialog
	add_child(bubble)

func end_dialog():
	GameManager.state = GameManager.last_state

func disable_background_btn(disable_btn = true):
	if disable_btn:
		background_btn.disabled = true
		background_btn.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		background_btn.disabled = false
		background_btn.mouse_filter = Control.MOUSE_FILTER_STOP

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
