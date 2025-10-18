extends Node
class_name Actor

enum Backgrounds { STREETKID, CORPO, MUTANT }

@export var strength = 0
@export var dex = 0
@export var charm = 0
@export var wits = 0
@export var max_hp = 0
var current_hp = 0
@export var background : Backgrounds
@export var display : PackedScene
var actor_name = ""
var id = ""
var position = 0

var roles = Utils.load_json("res://data/roles.json")
var backgrounds = Utils.load_json("res://data/backgrounds.json")
var names = Utils.load_json("res://data/names.json")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	id = name

func get_attribute( attribute : String ) -> int:
	var value = [attribute]
	value += background[attribute]
	return value

func get_max_hp() -> int:
	var value = [max_hp]
	return value

func get_current_hp() -> int:
	var value = [current_hp]
	return value
