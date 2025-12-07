extends Node
class_name Action

@export_multiline var description = ""
@export var icon : Texture2D
@export var player_animation = GlobalEnums.BattleAnimations.DEFEND
@export var npc_animation = GlobalEnums.BattleAnimations.ATTACK

@export_group("Basic Effects")
@export var attribute = GlobalEnums.Attributes.STR
@export var attack: float = 0.0
@export var heal: float = 0.0

@export_group("Status Effects")
