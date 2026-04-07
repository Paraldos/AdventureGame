@tool
extends Resource
class_name Ability

@export var titel: String:
	set(value):
		titel = value
		if id == "":
			id = Utils.string_to_id(value)
var id: String
@export var description: String
@export var img: Texture
@export var rune = true

@export var dmg = 1.0
@export var heal = 0.0

func target_enemy(target : Enemy):
	if dmg > 0.0:
		var value = Utils.d6()
		value += round(Game.attack * dmg)
		target.hp_current -= int(value)
	if heal > 0.0:
		var value = Utils.d6()
		value += round(Game.magic * heal)
		Game.hp_current += int(value)
	target.hp_current = max(0, target.hp_current)
	Signals.update_battle_boxes.emit()

func target_player():
	pass
