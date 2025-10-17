extends CanvasLayer
class_name DialogBubble

@onready var marker: Marker2D = %Marker
@onready var panel_container: PanelContainer = %PanelContainer
@onready var content_container: VBoxContainer = %ContentContainer
@onready var label: Label = %Label
@onready var pointer_top: TextureRect = %PointerTop
@onready var pointer_bottom: TextureRect = %PointerBottom
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var bp_option_btn = preload("res://dialogs/bubble/option_btn.tscn")
var dialog : Dialog

func _ready() -> void:
	SignalManager.remove_dialog_bubbles.connect(queue_free)
	animation_player.play('fade_in')
	_set_position()
	_add_text()
	_add_options()

func _on_remove_dialog_bubbles():
	await get_tree().create_timer(0.1).timeout
	queue_free()

func _set_position():
	if dialog.speaker <= 5:
		var target_slot = Utils.current_location.slots[dialog.speaker]
		var target_pos = target_slot.global_position
		target_pos.y -= 16
		marker.global_position = target_pos

func _add_text():
	label.text = dialog.text
	animation_player.play('fade_in')

func _add_options():
	if dialog.options.size() <= 1: return
	for option in dialog.options:
		var btn = bp_option_btn.instantiate()
		btn.option = option
		btn.parent_dialog = dialog
		content_container.add_child(btn)

func _on_background_btn_pressed() -> void:
	if dialog.options.size() > 1: return
	SignalManager.remove_dialog_bubbles.emit()
	if dialog.options.size() == 0:
		SignalManager.dialog_option_selected.emit( dialog.id, null )
	else:
		SignalManager.dialog_option_selected.emit( dialog.id, dialog.options[0] )
