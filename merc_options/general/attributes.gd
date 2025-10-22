extends GridContainer

@onready var label_strength: Label = %LabelStrength
@onready var label_dex: Label = %LabelDex
@onready var label_charm: Label = %LabelCharm
@onready var label_wits: Label = %LabelWits
var slot_index = -1

func _ready() -> void:
	SignalManager.update_actor_value.connect(_update)

func _update():
	var actor = ActorManager.get_actor(slot_index)
	label_strength.text = "Strength %s" % actor.get_attribute("strength")
	label_dex.text = "Dex %s" % actor.get_attribute("dex")
	label_charm.text = "Charm %s" % actor.get_attribute("charm")
	label_wits.text = "Wits %s" % actor.get_attribute("wits")
