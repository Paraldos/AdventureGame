extends CanvasLayer

@onready var lifebar_player: TextureProgressBar = %LifebarPlayer
@onready var lifebar_npc: TextureProgressBar = %LifebarNPC
@onready var actions_container: GridContainer = %ActionsContainer
@onready var description: Label = %Description

var action_btn_bp = preload("res://locations/template/battle/action_btn.tscn")

func init_lifebars(b : Battle):
	lifebar_player.max_value = GameData.max_hp * 10
	lifebar_player.value = GameData.current_hp * 10
	lifebar_npc.max_value = b.max_hp * 10
	lifebar_npc.value = b.current_hp * 10

func update_btns():
	pass
