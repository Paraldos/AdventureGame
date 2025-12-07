extends Node
class_name Battle

@export_group("Animations")
@export var enemy_idle : PackedScene
@export var enemy_attack1 : PackedScene
@export var enemy_attack2 : PackedScene
@export var enemy_defend : PackedScene
@export var enemy_hurt : PackedScene

@export_group("Actions")
@export var actions : Array[String]

@export_group("Attributes")
@export var max_hp = 40
@export var strength = 5
@export var dextertiy = 5
@export var wisdom = 5
@export var defense = 0

var current_hp = 40
