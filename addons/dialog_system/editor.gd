@tool
extends Control

@onready var dialog_segments_container: VBoxContainer = %DialogSegmentsContainer

const DIALOG_ITEM = preload("uid://df5lg0cjqql7u")
const SAVE_PATH = "res://addons/dialog_system/dialogs.tres"
var dialogs : Dialogs = load(SAVE_PATH)

func _ready() -> void:
	load_dialogs()

func load_dialogs() -> void:
	for child in dialog_segments_container.get_children():
		child.queue_free()
		
	var keys = dialogs.dialogs.keys()
	keys.sort()

	for key in keys:
		var item = DIALOG_ITEM.instantiate()
		item.dialog_id = key
		item.dialog = dialogs.dialogs[key]
		dialog_segments_container.add_child(item)

func _on_save_btn_pressed() -> void:
	dialogs.dialogs.clear()
	for item in dialog_segments_container.get_children():
		dialogs.dialogs[item.dialog_id] = item.dialog
	var error := ResourceSaver.save(dialogs, SAVE_PATH)
	if error != OK:
		push_error("Failed to save dialogs")

func _on_add_btn_pressed() -> void:
	var segment : DialogSegment = DialogSegment.new()
	dialogs.dialogs[segment.id] = segment
	load_dialogs()
