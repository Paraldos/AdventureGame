extends CanvasLayer

@onready var class_btn: Button = %ClassBtn
@onready var list_of_classes: VBoxContainer = %ListOfClasses

var index = 0

func _ready() -> void:
	list_of_classes.visible = false

func _on_x_btn_pressed() -> void:
	queue_free()

func _on_accept_btn_pressed() -> void:
	queue_free()

func _on_class_btn_pressed() -> void:
	list_of_classes.visible = !list_of_classes.visible

func _on_race_btn_pressed() -> void:
	list_of_classes.visible = false

func _on_zodiac_btn_pressed() -> void:
	list_of_classes.visible = false
