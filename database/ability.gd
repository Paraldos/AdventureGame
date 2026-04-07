@tool
extends Resource
class_name Ability

@export var titel: String:
    set(value):
        titel = value
        if id == "":
            id = Utils.string_to_id(value)
var id: String
@export var description: String
@export var img: Texture
@export var rune = true