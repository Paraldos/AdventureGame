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
var npc

func _ready() -> void:
	SignalManager.background_btn_clicked.connect(_update_content)
	pointer_top.visible = false
	pointer_bottom.visible = false
	await _create_chunks()
	_update_content()
	_add_npc()
	_update_position()

func _add_npc():
	if not dialog.npc_slot or not dialog.npc: return
	npc = dialog.npc.instantiate()
	npc.global_position = Vector2(0, 40)
	add_child(npc)

func _update_position():
	if dialog.npc_slot && dialog.npc:
		var pos = Utils.current_location.slots[dialog.npc_slot].global_position
		panel_container.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
		pointer_bottom.visible = true
		global_position = pos + Vector2(0, -40)
	elif dialog.speaker == Dialog.Speakers.NARRATOR:
		global_position = Utils.current_location.narrator_dialog_position.global_position
		pointer_bottom.visible = false
		panel_container.set_anchors_preset(Control.PRESET_CENTER_TOP)
	else:
		pass

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
