extends Node2D
class_name DialogBubble

@onready var panel_container: PanelContainer = %PanelContainer
@onready var content_container: VBoxContainer = %ContentContainer
@onready var label: Label = %Label
@onready var pointer_top: TextureRect = %PointerTop
@onready var pointer_bottom: TextureRect = %PointerBottom
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var dialog : Dialog

func _ready() -> void:
	_add_content()

func _add_content():
	_add_text()
	_add_options()

func _add_text():
	animation_player.play('fade_in')
	label.text = dialog.text

func _add_options():
	for option in dialog.options:
		var btn = DialogManager.bp_option_btn.instantiate()
		btn.text = option.text
		btn.option = option
		btn.parent_bubble = self
		content_container.add_child(btn)
