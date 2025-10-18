extends Node
class_name Actor

enum Attributes { STRENGTH, DEX, CHARM, WITS }
enum Roles { BRAWLER, HACKER }
enum Backgrounds { STREETKID, CORPO, MUTANT }

@export var strength = 0
@export var dex = 0
@export var charm = 0
@export var wits = 0
@export var role : Roles
@export var background : Backgrounds
var actor_name = ""
var current_hp
var id = ""

var roles = Utils.load_json("res://data/roles.json")
var backgrounds = Utils.load_json("res://data/backgrounds.json")
var names = Utils.load_json("res://data/names.json")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	if id == "":
		id = name

func get_attribute( attribute : String ) -> int:
	var value = [attribute]
	value += role[attribute]
	value += background[attribute]
	return value

func get_max_hp(index : int) -> int:
	var value = 0
	value += GameData.actors[index].role.max_hp
	return value

func get_current_hp(index : int) -> int:
	var value = 0
	value += GameData.actors[index].current_hp
	return value
