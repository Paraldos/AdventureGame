extends Node2D

@onready var content_container: VBoxContainer = %ContentContainer
@onready var label: Label = %Label
var dialog : Dialog
var text_length = 0
var max_text_length = 75
var amount_of_allready_shown_text = 0
var btns_instantiated = false

func _ready() -> void:
	SignalManager.background_btn_clicked.connect(_on_background_btn_clicked)
	text_length = dialog.text.length()
	_update_text()

func _on_background_btn_clicked():
	_update_text()

func _update_text():
	if text_length > amount_of_allready_shown_text:
		var text_to_display = dialog.text.substr(amount_of_allready_shown_text, max_text_length)
		amount_of_allready_shown_text += text_to_display.length()
		label.text = text_to_display
	if amount_of_allready_shown_text >= text_length:
		if btns_instantiated:
			pass
		elif dialog.options:
			_add_options()
			btns_instantiated = true
		else:
			print('done')

func _add_options():
	for option in dialog.options:
		var btn = DialogManager.bp_option_btn.instantiate()
		btn.text = option.text
		btn.option = option
		content_container.add_child(btn)
