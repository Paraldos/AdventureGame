extends "res://modal/modal.gd"

@onready var player_box: HBoxContainer = %PlayerBox
@onready var enemy_box: HBoxContainer = %EnemyBox
@onready var abilities_box: HBoxContainer = %AbilitiesBox

var enemy : Enemy

func _ready() -> void:
	player_box.character = Database.player
	player_box.target = enemy
	player_box.update()

	enemy_box.character = enemy
	enemy_box.target = Database.player
	enemy_box.update()

	abilities_box.enemy = enemy
