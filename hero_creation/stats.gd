extends GridContainer

@onready var label_left: Label = %LabelLeft
@onready var label_right: Label = %LabelRight
var index = -1

func _ready() -> void:
	SignalManager.update_actor_value.connect(_update)

func _update():
	_update_left_text()
	_update_right_text()

func _update_left_text():
	var actor = GameData.actors[index]
	label_left.text = ""
	label_left.text += "HP: %s / %s\n" % [actor.current_hp, ActorManager.get_max_hp(index)]

func _update_right_text():
	var actor = GameData.actors[index]
	label_right.text = ""
	label_right.text += "Name: %s\n" % actor.name
	label_right.text += "Role: %s\n" % Utils.id_to_string(actor.role.id)
	label_right.text += "Background: %s\n" % Utils.id_to_string(actor.background.id)
