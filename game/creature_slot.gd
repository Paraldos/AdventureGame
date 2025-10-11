extends Marker2D

@onready var button: Button = %Button
@onready var pointer: Sprite2D = %Pointer

func _ready() -> void:
	pointer.visible = false

func _on_button_mouse_entered() -> void:
	if button.disabled: return
	pointer.visible = true

func _on_button_mouse_exited() -> void:
	pointer.visible = false
