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

func use(user: Entity, target: Entity):
	if dmg > 0.0:
		var value = Utils.d6()
		value += round(user.attack * dmg)
		target.hp_current -= int(value)
		Signals.spawn_floating_number.emit(target, value, Color("#a53030"))
	if heal > 0.0:
		var value = Utils.d6()
		value += round(user.magic * heal)
		user.hp_current += int(value)
		Signals.spawn_floating_number.emit(user, value, Color("#75a743"))
	target.hp_current = max(0, target.hp_current)
	user.hp_current = min(user.hp_current, user.hp_max)
	Signals.update_battle_boxes.emit()
