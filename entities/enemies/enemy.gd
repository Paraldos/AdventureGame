extends "res://entities/entity.gd"

var battle_bp = preload("res://battle/battle.tscn")
@export var enemy_id : String

func _ready() -> void:
	pass

func action():
	super()
	var battle = battle_bp.instantiate()
	get_tree().current_scene.add_child(battle)
