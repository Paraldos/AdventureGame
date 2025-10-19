extends GridContainer

@onready var label_left: Label = %LabelLeft
@onready var label_right: Label = %LabelRight
var slot_index = -1
var actor : Actor

func _ready() -> void:
	SignalManager.update_actor_value.connect(_update)

func _update():
	actor = ActorManager.get_actor(slot_index)
	_update_left_text()
	_update_right_text()

func _update_left_text():
	label_left.text = ""
	label_left.text += "HP: %s / %s\n" % [actor.get_current_hp(), actor.get_max_hp()]

func _update_right_text():
	label_right.text = ""
	label_right.text += "Name: %s\n" % actor.actor_name
	label_right.text += "Role: %s\n" % Utils.id_to_string(actor.id)
	label_right.text += "Background: %s\n" % Utils.id_to_string(actor.background.id)
