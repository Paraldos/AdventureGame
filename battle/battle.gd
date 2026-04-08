extends "res://modal/modal.gd"

@onready var player_box: HBoxContainer = %PlayerBox
@onready var enemy_box: HBoxContainer = %EnemyBox
@onready var abilities_box: HBoxContainer = %AbilitiesBox

var enemy : Entity
var current_character = Database.player

func _ready() -> void:
	player_box.character = Database.player
	player_box.target = enemy
	player_box.update()
	player_box.next_turn(current_character)

	enemy_box.character = enemy
	enemy_box.target = Database.player
	enemy_box.update()
	enemy_box.next_turn(current_character)

	abilities_box.enemy = enemy
	abilities_box.next_turn(current_character)

	Signals.next_turn.connect(_on_next_turn)

func _on_next_turn():
	current_character = Database.player if current_character == enemy else enemy
	player_box.next_turn(current_character)
	enemy_box.next_turn(current_character)
	abilities_box.next_turn(current_character)
