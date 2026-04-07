@tool
extends Resource
class_name Enemy

@export var titel: String:
	set(value):
		titel = value
		id = Utils.string_to_id(value)
var id: String
@export var img: Texture
@export var hp_max = 20:
	set(value):
		hp_max = value
		hp_current = value
var hp_current = 20
@export var attack = 1
@export var armor = 0
