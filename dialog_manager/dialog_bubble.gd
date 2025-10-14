extends Node2D
class_name DialogBubble

@onready var panel_container: PanelContainer = %PanelContainer
@onready var content_container: VBoxContainer = %ContentContainer
@onready var label: Label = %Label
@onready var pointer_top: TextureRect = %PointerTop
@onready var pointer_bottom: TextureRect = %PointerBottom
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var dialog : Dialog
var chunks = []
var max_chunk_length = 150
var current_chunk = 0

func _ready() -> void:
	SignalManager.background_btn_clicked.connect(_update_content)
	await _create_chunks()
	_update_content()
	_update_position()

func _update_position():
	global_position = Utils.current_location.narrator_dialog_position.global_position
	if dialog.speaker == Dialog.Speakers.NARRATOR:
		pointer_bottom.visible = false
		panel_container.set_anchors_preset(Control.PRESET_CENTER_TOP)
	else:
		panel_container.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
		pointer_top.visible = false
		pointer_bottom.visible = false

func _update_content():
		if current_chunk >= chunks.size():
			if dialog.options:
				return
			elif dialog.target_id:
				DialogManager.move_to_next_dialog(dialog.target_id)
				queue_free()
			else:
				DialogManager.end_dialog()
				queue_free()
		elif current_chunk == chunks.size() -1:
			_add_text()
			_add_options()
		else:
			_add_text()

func _add_text():
	animation_player.play('fade_in')
	label.text = chunks[current_chunk]
	current_chunk += 1

func _add_options():
	for option in dialog.options:
		var btn = DialogManager.bp_option_btn.instantiate()
		btn.text = option.text
		btn.option = option
		btn.parent_bubble = self
		content_container.add_child(btn)

# ====================================== helper
func _create_chunks():
	var txt_array = dialog.text.split(" ")
	var chunk = ""
	for word in txt_array:
		if chunk.length() == 0:
			chunk += word
		elif (chunk.length() + word.length() + 1) <= max_chunk_length:
			chunk += " " + word
		else:
			chunks.push_back(chunk)
			chunk = word
	if chunk != "":
		chunks.push_back(chunk)
	return
