extends Node
class_name Battle

@export var enemy_idle : PackedScene
@export var enemy_attack1 : PackedScene
@export var enemy_attack2 : PackedScene
@export var enemy_hurt : PackedScene

var max_hp = 50
var current_hp = 10