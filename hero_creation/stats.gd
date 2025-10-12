extends GridContainer

@onready var label_left: Label = %LabelLeft
@onready var label_right: Label = %LabelRight
var index = -1

func _ready() -> void:
	SignalManager.update_actor_hero_creation.connect(_update)

func _update():
	_update_left_text()
	_update_right_text()

func _update_left_text():
	var actor = GameData.actors[index]
	label_left.text = ""
	label_left.text += "HP: %s / %s\n" % [actor.max_hp, actor.current_hp]

func _update_right_text():
	var actor = GameData.actors[index]
	label_right.text += "Name: %s\n" % actor.name
	label_right.text += "Role: %s\n" % actor.role_id
	label_right.text += "Name: %s\n" % actor.background_id
