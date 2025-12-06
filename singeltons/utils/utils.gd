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
