extends Node

@onready var parent: Node2D = $".."
@onready var player_display: Marker2D = %PlayerDisplay
@onready var npc_display: Marker2D = %NPCDisplay
@onready var dialog_ui: CanvasLayer = %DialogUi
@onready var battle_system: Node = %BattleSystem
@onready var dialog_system: Node = %DialogSystem

func _ready() -> void:
	Signals.change_dialog_node.connect(_change_dialog_node)
	Signals.end_dialog.connect(_end_dialog)

func _start_dialog(dialog_id : String) -> void:
	var d: DialogNode = Dialogs.get_node(dialog_id)
	if not d: return
	parent.reset_ui()
	dialog_ui.visible = true
	_change_dialog_node(d)

func _change_dialog_node(d : DialogNode):
	dialog_ui.update_label(d)
	dialog_ui.update_options(d)
	if d.player_display:
		player_display.update(d.player_display)
	if d.npc_display:
		npc_display.update(d.npc_display)

func _end_dialog():
	parent.reset_ui()
	npc_display.remove_display()
	player_display.update(parent.player_idle)
