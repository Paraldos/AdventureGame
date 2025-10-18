extends Node
class_name Background

@export var strength = 0
@export var dex = 0
@export var charm = 0
@export var wits = 0
var id = name

func _ready() -> void:
	id = name