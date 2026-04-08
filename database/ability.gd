@tool
extends Resource
class_name Ability

@export var img: Texture
@export var titel: String:
	set(value):
		titel = value
		if id == "":
			id = Utils.string_to_id(value)
var id: String
@export var description: String
@export var dmg = 1.0
@export var heal = 0.0
@export var user_animation := Enums.battle_animations.ATTACK
@export var target_animation := Enums.battle_animations.SHAKE

func use(user: Entity, target: Entity):
	_dmg(user, target)
	_heal(user)
	Signals.play_battle_animation.emit(user, user_animation)
	Signals.play_battle_animation.emit(target, target_animation)
	Signals.update_battle_boxes.emit()

func _dmg(user: Entity, target: Entity):
	if dmg <= 0.0: return
	var value = Utils.d6()
	value += round(user.attack * dmg)
	target.hp_current -= int(value)
	target.hp_current = max(0, target.hp_current)
	Signals.spawn_floating_number.emit(target, value, Color("#a53030"))

func _heal(user: Entity):
	if heal <= 0.0: return
	var value = Utils.d6()
	value += round(user.magic * heal)
	user.hp_current += int(value)
	user.hp_current = min(user.hp_current, user.hp_max)
	Signals.spawn_floating_number.emit(user, value, Color("#75a743"))
