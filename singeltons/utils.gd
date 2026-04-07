extends Node

var debug_map = false
var world

func string_to_id(text: String):
	var id = text.to_lower()
	id = id.replace(" ", "_")
	return id
