@tool
extends Entity
class_name Enemy

@export var titel: String:
	set(value):
		titel = value
		id = Utils.string_to_id(value)
var id: String
