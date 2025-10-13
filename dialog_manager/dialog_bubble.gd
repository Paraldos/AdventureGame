extends Node2D
class_name DialogBubble

@onready var panel_container: PanelContainer = %PanelContainer
@onready var content_container: VBoxContainer = %ContentContainer
@onready var label: Label = %Label
@onready var pointer_top: TextureRect = %PointerTop
@onready var pointer_bottom: TextureRect = %PointerBottom
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var dialog : Dialog
var text_length = 0
var max_text_length = 75
var amount_of_allready_shown_text = 0
var btns_instantiated = false

func _ready() -> void:
	SignalManager.background_btn_clicked.connect(_on_background_btn_clicked)
	text_length = dialog.text.length()
	_update_text()
	global_position = Utils.current_location.narrator_dialog_position.global_position
	if dialog.speaker == Dialog.Speakers.NARRATOR:
		pointer_bottom.visible = false
		panel_container.set_anchors_preset(Control.PRESET_CENTER_TOP)
	else:
		panel_container.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
		pointer_top.visible = false
		pointer_bottom.visible = false

func _on_background_btn_clicked():
	_update_text()

func _update_text():
	if text_length > amount_of_allready_shown_text:
		animation_player.play('fade_in')
		var text_to_display = dialog.text.substr(amount_of_allready_shown_text, max_text_length)
		amount_of_allready_shown_text += text_to_display.length()
		label.text = text_to_display
		if amount_of_allready_shown_text >= text_length:
			_add_options()
	else:
		if btns_instantiated: return
		if dialog.target_id:
			DialogManager.move_to_next_dialog(dialog.target_id)
			queue_free()
		else:
			DialogManager.end_dialog()
			queue_free()

func _add_options():
	for option in dialog.options:
		var btn = DialogManager.bp_option_btn.instantiate()
		btn.text = option.text
		btn.option = option
		btn.parent_bubble = self
		content_container.add_child(btn)
		btns_instantiated = true
