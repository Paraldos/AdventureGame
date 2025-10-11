extends Node2D

@onready var positions = [
	%Slot,
	%Slot1,
	%Slot2,
	%Slot3,
	%Slot4,
	%Slot5,
]

func _ready():
	Utils.game = self
	for index in GameData.creatures.size():
		var hero = GameData.creatures[index]
		CreatureManager.add_creature_to_screen(hero, positions[index].global_position, index)
	SignalManager.select_hero.emit()
