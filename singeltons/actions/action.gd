extends Node
class_name Action

@export var description = ""
@export var icon : Texture2D
@export var player_animation = GlobalEnums.BattleAnimations.DEFEND
@export var npc_animation = GlobalEnums.BattleAnimations.ATTACK
@export var effects: Array[Dictionary] = [
	{"type": "dmg", "amount": 10}
]
