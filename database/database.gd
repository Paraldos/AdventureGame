extends Node

@export var abilities: Array[Ability]
var ability_map: Dictionary = {}

@export var enemies: Array[Enemy]
var enemies_map: Dictionary = {}

func _ready():
	for ability in abilities:
		ability_map[ability.id] = ability
	for enemy in enemies:
		enemies_map[enemy.id] = enemy
