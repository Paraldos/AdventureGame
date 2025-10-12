extends Button

var index
var role

func _ready() -> void:
	text = role.name

func _on_pressed() -> void:
	var background = GameData.actors[index].background
	ActorManager.create_hero(role, background, index)
