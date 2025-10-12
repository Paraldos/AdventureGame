extends Node

var game

func id_to_string(txt: String) -> String:
	var words := txt.split("_", false)
	for i in range(words.size()):
		if words[i].length() > 0:
			words[i] = words[i].substr(0, 1).to_upper() + words[i].substr(1).to_lower()
	return " ".join(words)

func string_to_id(txt: String) -> String:
	var words := txt.strip_edges().split(" ", false)
	for i in range(words.size()):
		if words[i].length() > 0:
			words[i] = words[i].to_lower()
	return "_".join(words)
