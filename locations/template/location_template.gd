extends Node2D

@onready var player_display: Marker2D = %PlayerDisplay
@onready var npc_display: Marker2D = %NPCDisplay
@onready var dialog_ui: CanvasLayer = %DialogUi
@export var dialogs : Array[String] = []
@export var player_display_bp : PackedScene

func _ready() -> void:
	player_display.update(player_display_bp)
	for dialog_id in dialogs:
		_update_dialog(dialog_id)

func _update_dialog(dialog_id):
	var d: DialogOption = Dialogs.get_node(dialog_id)
	dialog_ui.update_label(d)
	dialog_ui.update_options(d)
	if d.player_display:
		player_display.update(d.player_display)
	if d.npc_display:
		npc_display.update(d.npc_display)
