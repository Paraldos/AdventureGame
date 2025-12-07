extends Node

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func roll_d100():
	return roll_dice(100, 1)

func roll_dice(dice_sides: int = 6, amount_of_dice: int = 2) -> int:
	var result := 0
	for i in range(amount_of_dice):
		result += rng.randi_range(1, dice_sides)
	return result

func get_player_attribute(attribute : int):
	match attribute:
		GlobalEnums.Attributes.STR:
			return GameData.strength
		GlobalEnums.Attributes.DEX:
			return GameData.dextertiy
		GlobalEnums.Attributes.WIS:
			return GameData.wisdom

func get_battle_attribute(attribute : int, battle : Battle):
	match attribute:
		GlobalEnums.Attributes.STR:
			return battle.strength
		GlobalEnums.Attributes.DEX:
			return battle.dextertiy
		GlobalEnums.Attributes.WIS:
			return battle.wisdom
