extends CanvasLayer

@onready var lifebar_player: TextureProgressBar = %LifebarPlayer
@onready var lifebar_npc: TextureProgressBar = %LifebarNPC
@onready var actions_container: GridContainer = %ActionsContainer
@onready var description: Label = %Description

var action_btn_bp = preload("res://locations/template/battle/action_btn.tscn")

func _ready() -> void:
	Signals.change_action_description.connect(_on_change_action_description)

func _on_change_action_description(new_text):
	description.text = new_text

func init_lifebars(b : Battle):
	lifebar_player.max_value = GameData.max_hp * 10
	lifebar_player.value = GameData.current_hp * 10
	lifebar_npc.max_value = b.max_hp * 10
	lifebar_npc.value = b.current_hp * 10

func update_btns():
	for child in actions_container.get_children():
		child.queue_free()
	for action_id in GameData.actions:
		_add_btn(action_id)
	_add_btn('SkipTurn')

func _add_btn(action_id : String):
	var a = Actions.get_node(action_id)
	if not a: return
	var btn = action_btn_bp.instantiate()
	btn.action = a
	actions_container.add_child(btn)
