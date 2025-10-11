extends Node2D

@onready var positions = [
	%pos1,
	%pos2,
	%pos3,
	%pos4,
	%pos5,
	%pos6,
]

func _ready():
	Utils.game = self
	for index in GameData.creatures.size():
		var hero = GameData.creatures[index]
		CreatureManager.add_creature_to_screen(hero, positions[index].global_position, index)
	SignalManager.select_hero.emit()
