extends CanvasLayer

@onready var player_container: Panel = %PlayerContainer
@onready var npc_container: Panel = %NPCContainer
@onready var player_label: Label = %PlayerLabel
@onready var npc_label: Label = %NPCLabel
@onready var btns_container: VBoxContainer = %BtnsContainer
var dialog_btn_bp = preload("res://locations/template/dialog/dialog_btn.tscn")

func update_label(d: DialogNode):
	player_container.modulate = Color("ffffff00") if d.speaker_name else Color("ffffff")
	npc_container.modulate = Color("ffffff") if d.speaker_name else Color("ffffff00")
	var label = npc_label if d.speaker_name else player_label
	var speaker = d.speaker_name if d.speaker_name else "Player"
	label.text = "%s: %s" % [speaker, d.text]

func update_options(d: DialogNode):
	for child in btns_container.get_children():
		child.queue_free()
	for option in d.get_children():
		var btn = dialog_btn_bp.instantiate()
		btn.option = option
		btns_container.add_child(btn)
	if d.get_child_count() == 0:
		var btn = dialog_btn_bp.instantiate()
		btns_container.add_child(btn)
