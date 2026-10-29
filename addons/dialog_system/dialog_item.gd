@tool
extends HBoxContainer

@onready var id_label: LineEdit = $IDLabel
@onready var content_label: TextEdit = $ContentLabel

var dialog_id: String
var dialog: DialogSegment

func _ready() -> void:
	id_label.text = dialog.id
	content_label.text = dialog.content

func _on_id_label_text_changed(new_text: String) -> void:
	dialog.id = new_text

func _on_content_label_lines_edited_from(from_line: int, to_line: int) -> void:
	dialog.content = content_label.text
