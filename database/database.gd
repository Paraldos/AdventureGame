extends Node

@export var abilities: Array[Ability]
var ability_map: Dictionary = {}

func _ready():
	for ability in abilities:
		ability_map[ability.id] = ability
