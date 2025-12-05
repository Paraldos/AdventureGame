extends Node2D

@onready var icon: Sprite2D = %Icon
@onready var frame: Sprite2D = %Frame

func _ready():
	frame.visible = false

func _on_area_2d_mouse_entered() -> void:
	frame.visible = true

func _on_area_2d_mouse_exited() -> void:
	frame.visible = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Left click!")
