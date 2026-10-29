@tool
extends EditorPlugin

var EDITOR = preload("res://addons/dialog_system/editor.tscn")
var editor: Control

func _enter_tree() -> void:
	editor = EDITOR.instantiate()
	editor.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor.size_flags_vertical = Control.SIZE_EXPAND_FILL
	EditorInterface.get_editor_main_screen().add_child(editor)
	editor.hide()

func _exit_tree() -> void:
	if editor:
		editor.queue_free()

func _has_main_screen() -> bool:
	return true

func _make_visible(visible: bool) -> void:
	if editor:
		editor.visible = visible

func _get_plugin_name() -> String:
	return "Dialog Editor"

func _get_plugin_icon() -> Texture2D:
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
