extends HBoxContainer

@onready var label_strength: Label = %LabelStrength
@onready var label_dex: Label = %LabelDex
@onready var label_charm: Label = %LabelCharm
@onready var label_wits: Label = %LabelWits
var index = -1

func _ready() -> void:
	SignalManager.update_actor_value.connect(_update)

func _update():
	label_strength.text = "Strength
	%s" % ActorManager.get_attribute(index, "strength")
	label_dex.text = "Dex
	%s" % ActorManager.get_attribute(index, "dex")
	label_charm.text = "Charm
	%s" % ActorManager.get_attribute(index, "charm")
	label_wits.text = "Wits
	%s" % ActorManager.get_attribute(index, "wits")
