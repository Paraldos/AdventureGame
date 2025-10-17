extends Node
class_name Dialog

enum Speakers { SLOT1, SLOT2, SLOT3, SLOT4, SLOT5, SLOT6, NARRATOR, RANDOME_HERO, RANDOMY_ENEMY }

@export_multiline var text : String
@export var location : String
@export var speaker : Speakers
@export var add_npc : PackedScene
@export var options : Array[DialogOption]

var id
var enabled = false
var bubble
var bp_dialog_bubble = preload("res://dialogs/bubble/dialog_bubble.tscn")

# ===================================== ready
func _ready() -> void:
	id = name
	GameData.dialogs.append([id, enabled])
	SignalManager.scene_changed.connect(_on_scene_changed)
	SignalManager.enable_dialog.connect(_on_enable_dialog)
	SignalManager.dialog_option_selected.connect(_on_dialog_option_selected)
	if options.size() == 0: print_debug('dialog has no options: %s' % id)

func _on_enable_dialog(target_id : String, new_status : bool):
	if target_id != id: return
	enabled = new_status

func _on_scene_changed():
	if not enabled: return
	if not Utils.current_location: return
	var current_location = Utils.current_location.scene_file_path.get_file().get_basename()
	if current_location != location: return
	_start_dialog()

func _on_dialog_option_selected( old_dialog_id : String, selected_option : DialogOption ):
	if selected_option == null:
		_stop_dialog()
		return
	if old_dialog_id == id:
		if selected_option.next_dialog == "":
			_stop_dialog()
		if selected_option.start_quest:
			SignalManager.start_quest.emit(selected_option.start_quest)
		if selected_option.finish_quest:
			SignalManager.finish_quest.emit(selected_option.finish_quest)
		if selected_option.start_recruting:
			GameManager.state = GameManager.States.RECRUTING
	if selected_option.next_dialog == id:
		_start_dialog()

# ===================================== helper
func _start_dialog():
	_add_npc()
	_add_dialog_bubble()
	enabled = false

func _stop_dialog():
	print('bert')
	SignalManager.remove_npcs.emit()

func _add_npc():
	if not add_npc: return
	var npc = add_npc.instantiate()
	Utils.current_location.slots[speaker].actor_container.add_child(npc)

func _add_dialog_bubble():
	bubble = bp_dialog_bubble.instantiate()
	bubble.dialog = self
	Dialogs.add_child(bubble)
