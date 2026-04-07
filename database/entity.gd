@tool
extends Resource
class_name Entity

@export var img: Texture
@export var hp_max = 20:
	set(value):
		hp_max = value
		hp_current = value
var hp_current = 20
@export var attack = 0
@export var magic = 0
@export var armor = 0
@export var abilities : Array[String]
