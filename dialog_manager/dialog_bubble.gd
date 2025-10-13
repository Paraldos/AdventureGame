extends Node2D

@onready var label: Label = %Label
var dialog : Dialog
var max_length = 50

func _ready() -> void:
	label.text = dialog.text.substr(0, max_length)
