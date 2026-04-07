extends "res://modal/modal.gd"

@onready var player_box: HBoxContainer = %PlayerBox
@onready var enemy_box: HBoxContainer = %EnemyBox
@onready var abilities_box: HBoxContainer = %AbilitiesBox

var enemy : Enemy

func _ready() -> void:
	enemy_box.enemy = enemy
	enemy_box.update()
	abilities_box.enemy = enemy
