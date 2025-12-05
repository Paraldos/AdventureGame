extends CanvasLayer

@onready var player_container: Panel = %PlayerContainer
@onready var npc_container: Panel = %NPCContainer
@onready var player_label: Label = %PlayerLabel
@onready var npc_label: Label = %NPCLabel
@onready var btns_container: VBoxContainer = %BtnsContainer
var dialog_btn_bp = preload("res://locations/template/dialog_btn.tscn")

func update_label(d: DialogNode):
	player_container.modulate = Color("ffffff00") if d.speaker_name else Color("ffffff")
	npc_container.modulate = Color("ffffff") if d.speaker_name else Color("ffffff00")
	var label = npc_label if d.speaker_name else player_label
	var speaker = d.speaker_name if d.speaker_name else "Player"
	label.text = "%s: %s" % [speaker, d.text]

func update_options(d: DialogNode):
	for option in d.options:
		var btn = dialog_btn_bp.instantiate()
