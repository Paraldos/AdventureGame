extends CanvasLayer

@onready var background_btn: Button = %BackgroundBtn
var bp_dialog_bubble = preload("res://dialog_manager/bubble/dialog_bubble.tscn")
var bp_option_btn = preload("res://dialog_manager/bubble/option_btn.tscn")
var current_dialog
var current_bubble

# ============================================ ready
func _ready() -> void:
	SignalManager.scene_change_finished.connect(_check_location_for_valid_dialog)
	_disable_background_btn()

# ============================================ background btn
func _on_background_btn_pressed() -> void:
	if current_dialog.options:
		return
	else:
		next_step( current_dialog )

# ============================================ api
func add_dialog_to_game_data(dialog_id: String) -> void:
	GameData.dialog_queue.append( dialog_id )
	_check_location_for_valid_dialog()

func start_dialog(dialog_id: String) -> void:
	current_dialog = get_node(dialog_id)
	if not current_dialog: return
	_disable_background_btn(false)
	_add_npc()
	_add_dialog_bubble()

func next_step( dialog ):
	current_bubble.queue_free()
	if dialog.open_quest:
		QuestManager.open_quest(dialog.open_quest)
	if dialog.start_recruting:
		start_recurting()
	if dialog.target_id:
		start_dialog(dialog.target_id)
	else:
		end_dialog()

func end_dialog():
	SignalManager.remove_npcs.emit()
	_disable_background_btn()

func start_recurting():
	end_dialog()
	GameManager.state = GameManager.States.RECRUTING

# ============================================ helper
func _check_location_for_valid_dialog():
	if not Utils.current_location: return
	var dialog_id_for_this_location = _get_dialog_id_for_this_location()
	if dialog_id_for_this_location:
		start_dialog(dialog_id_for_this_location)
		GameData.dialog_queue.erase( dialog_id_for_this_location )

func _disable_background_btn(disable_btn = true):
	if disable_btn:
		background_btn.disabled = true
		background_btn.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		background_btn.disabled = false
		background_btn.mouse_filter = Control.MOUSE_FILTER_STOP

func _add_npc():
	if not current_dialog.add_npc: return
	if current_dialog.speaker < 2 or current_dialog.speaker > 5: return
	var npc = current_dialog.add_npc.instantiate()
	if current_dialog.speaker <= 5:
		Utils.current_location.slots[current_dialog.speaker].actor_container.add_child(npc)

func _add_dialog_bubble():
	current_bubble = bp_dialog_bubble.instantiate()
	current_bubble.dialog = current_dialog
	add_child(current_bubble)
	if current_dialog.speaker <= 5:
		current_bubble.global_position = Utils.current_location.slots[current_dialog.speaker].global_position
		current_bubble.position.y -= 16

func _get_dialog_id_for_this_location() -> String:
	var current_location = Utils.current_location.scene_file_path.get_file().get_basename()
	for dialog_id in GameData.dialog_queue:
		var dialog = get_node(dialog_id)
		if not dialog: continue
		if not dialog.location: continue
		if dialog.location.find(current_location):
			return dialog_id
	return ""
