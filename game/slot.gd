extends Marker2D
class_name Slot

enum BTN_STATUS { INVISIBLE, DISABLED, ACTIVE }

@onready var button: Button = %Button
@onready var pointer: Sprite2D = %Pointer

@export var index = 0
var bp_hero_creation = preload('res://hero_creation/hero_creation.tscn')

func _ready() -> void:
	_on_update_slot_btn()
	SignalManager.update_slot_btn.connect(_on_update_slot_btn)
	pointer.visible = false

func _on_button_mouse_entered() -> void:
	if button.disabled: return
	pointer.visible = true

func _on_button_mouse_exited() -> void:
	pointer.visible = false

func _on_update_slot_btn():
	match  GameData.slots[index]:
		BTN_STATUS.INVISIBLE:
			button.visible = false
			button.disabled = true
		BTN_STATUS.DISABLED:
			button.visible = true
			button.disabled = true
		BTN_STATUS.ACTIVE:
			button.visible = true
			button.disabled = false

func _on_button_pressed() -> void:
	var hero_creation = bp_hero_creation.instantiate()
	hero_creation.index = index
	get_tree().current_scene.add_child(hero_creation)
