extends CanvasLayer

@onready var player_container: Panel = %PlayerContainer
@onready var npc_container: Panel = %NPCContainer
@onready var player_label: Label = %PlayerLabel
@onready var npc_label: Label = %NPCLabel

func update_label(d: DialogOption):
	player_container.modulate = Color("ffffff00") if d.speaker_name else Color("ffffff")
	npc_container.modulate = Color("ffffff") if d.speaker_name else Color("ffffff00")
	var label = npc_label if d.speaker_name else player_label
	var speaker = d.speaker_name if d.speaker_name else "Player"
	label.text = "%s: %s" % [speaker, d.text]

func update_options(d: DialogOption):
	pass
