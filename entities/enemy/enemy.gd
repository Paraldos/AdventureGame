extends "res://entities/entity.gd"

@export var enemy_id : String
var battle_bp = preload("res://battle/battle.tscn")
var enemy : Enemy

func _ready() -> void:
	if not enemy_id: queue_free()
	enemy = Database.enemies_map[enemy_id].duplicate()
	main_sprite.texture = enemy.img

func action():
	super()
	var battle = battle_bp.instantiate()
	battle.enemy = enemy
	get_tree().current_scene.add_child(battle)
