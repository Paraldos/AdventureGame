extends Node

enum ATTRIBUTES { STRENGTH, DEX, CHARM, WITS }

var rng = RandomNumberGenerator.new()
var roles = Utils.load_json("res://data/roles.json")
var hero_roles = [ roles.brawler, roles.hacker ]
var backgrounds = Utils.load_json("res://data/backgrounds.json")
var hero_backgrounds = [ backgrounds.streetkid, backgrounds.corpo, backgrounds.mutant ]
var names = Utils.load_json("res://data/names.json")
var hero_template = { name = "", current_hp = 0, level = 1, role = {}, background = {} }

# =============================================== ready
func _ready() -> void:
	rng.randomize()

# =============================================== helper
func _get_randome_name(sex : String):
	if sex == "male":
		names.male.shuffle()
		return names.male[0]
	else:
		names.female.shuffle()
		return names.female[0]

func create_hero(role, background, index) -> void:
	var hero = hero_template.duplicate()
	hero.name = _get_randome_name(role.sex)
	hero.role = role.duplicate()
	hero.background = background.duplicate()
	GameData.actors[index] = hero
	hero.current_hp = get_max_hp(index)

func get_attribute(index : int, attribute : String) -> int:
	var value = 0
	value += GameData.actors[index].role[attribute]
	value += GameData.actors[index].background[attribute]
	return value

func get_max_hp(index : int) -> int:
	var value = 0
	value += GameData.actors[index].role.max_hp
	return value

func get_current_hp(index : int) -> int:
	var value = 0
	value += GameData.actors[index].current_hp
	return value
