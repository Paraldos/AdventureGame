extends Node2D

@onready var player_display: Marker2D = %PlayerDisplay
@onready var npc_display: Marker2D = %NPCDisplay
@onready var dialog_ui: CanvasLayer = %DialogUi
@export var dialogs : Array[String] = []
@export var player_display_bp : PackedScene

func _ready() -> void:
	player_display.update(player_display_bp)
	for dialog_id in dialogs:
		_start_dialog(dialog_id)
	Signals.change_dialog_node.connect(_change_dialog_node)
	Signals.end_dialog.connect(_end_dialog)

# battle system

# dialog system
func _start_dialog(dialog_id : String) -> void:
	dialog_ui.visible = true
	var d: DialogNode = Dialogs.get_node(dialog_id)
	_change_dialog_node(d)

func _change_dialog_node(d : DialogNode):
	dialog_ui.update_label(d)
	dialog_ui.update_options(d)
	if d.player_display:
		player_display.update(d.player_display)
	if d.npc_display:
		npc_display.update(d.npc_display)

func _end_dialog():
	dialog_ui.visible = false
	npc_display.remove_display()
	player_display.update(player_display_bp)
