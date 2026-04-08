extends "res://modal/modal.gd"

@onready var player_box: HBoxContainer = %PlayerBox
@onready var enemy_box: HBoxContainer = %EnemyBox
@onready var abilities_box: HBoxContainer = %AbilitiesBox

var enemy : Entity
var current = Database.player

func _ready() -> void:
	Signals.next_turn.connect(_on_next_turn)
	player_box.character = Database.player
	player_box.target = enemy
	player_box.update()
	player_box.next_turn(current)

	enemy_box.character = enemy
	enemy_box.target = Database.player
	enemy_box.update()
	enemy_box.next_turn(current)

	abilities_box.enemy = enemy
	abilities_box.next_turn(current)

func _on_next_turn():
	await get_tree().create_timer(1.0).timeout
	current = Database.player if current == enemy else enemy
	player_box.next_turn(current)
	enemy_box.next_turn(current)
	if current == enemy:
		_enemy_action()
	else:
		abilities_box.next_turn(current)

func _enemy_action():
	await get_tree().create_timer(0.5).timeout
	var ability_id : String = enemy.abilities.pick_random()
	var ability : Ability = Database.ability_map[ability_id]
	ability.use(enemy, Database.player)
	_on_next_turn()
