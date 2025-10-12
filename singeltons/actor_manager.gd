extends Node

enum ATTRIBUTES { STRENGTH, DEX, CHARM, WITS }

var rng = RandomNumberGenerator.new()

var list_of_female_names = [
	"Nyx",
	"Rin",
	"Sable",
	"Kaori",
	"Juno",
	"Vera",
	"Ash",
	"Nara",
	"Eve",
	"Mira",
	"Tess",
	"Aya",
	"Lira",
	"Nova",
	"Skye",
	"Iona",
	"Raze",
	"Synn",
	"Echo",
	"Rhea",
	"Tara",
	"Zira",
	"Kira",
	"Lux",
	"Hana",
	"Mako",
	"Rox",
	"Aiko",
	"Zhen",
	"Selene",
	"Cass",
	"Vex",
	"Jade",
	"Irina",
	"Nixie",
	"Orla",
	"Suki",
	"Dara",
	"Rei",
	"Lunara",
	"Yuna",
	"Tessia",
	"Vanya",
	"Kora",
	"Lirael",
	"Noa",
	"Seris",
	"Mina",
	"Trix",
    "Zyra"
]
var list_of_male_names = [
	"Rex",
	"Kane",
	"Dax",
	"Arin",
	"Viktor",
	"Ryo",
	"Blade",
	"Talon",
	"Hiro",
	"Cassian",
	"Nash",
	"Zero",
	"Drake",
	"Axel",
	"Jin",
	"Kael",
	"Soren",
	"Lex",
	"Niko",
	"Marek",
	"Rook",
	"Vance",
	"Orion",
	"Riot",
	"Silas",
	"Kiro",
	"Zane",
	"Luther",
	"Dante",
	"Cade",
	"Hale",
	"Orren",
	"Taro",
	"Riven",
	"Ashen",
	"Jarek",
	"Talonis",
	"Mako",
	"Troy",
	"Cass",
	"Riddick",
	"Vyn",
	"Kai",
	"Ezek",
	"Storm",
	"Seth",
	"Dorian",
	"Kade",
	"Lucan",
    "Neo"
]
var brawler = {
	id = "brawler",
	sex = "male",
	# attributes
	charm = 0,
	dex = 1,
	strength = 2,
	wits = 0,
	# hp
	max_hp = 50,
	# template
	template = 'res://actors/fighter/fighter.tscn'
}
var hacker = {
	id = "hacker",
	sex = "female",
	# attributes
	charm = 0,
	dex = 1,
	strength = 0,
	wits = 2,
	# hp
	max_hp = 50,
	# template
	template = 'res://actors/fighter/fighter.tscn'
}
var hero_roles = [ brawler, hacker ]

var streetkid = {
	id = "streetkid",
	charm = 1,
	dex = 1,
	strength = 0,
	wits = 0,
}
var corpo = {
	id = "corpo", 
	charm = 1,
	dex = 0,
	strength = 0,
	wits = 1
}
var mutant = {
	id = "mutant",
	charm = 0,
	dex = 1,
	strength = 1,
	wits = 0,
}
var hero_backgrounds = [ streetkid, corpo, mutant ]

func _ready() -> void:
	rng.randomize()

# =============================================== helper
var hero_template = {
	name = "",
	current_hp = 0,
	level = 1,
	role = {},
	background = {}
}

func create_hero(role, background, index) -> void:
	var hero = hero_template.duplicate()
	# name
	if role.sex == "male":
		list_of_male_names.shuffle()
		hero.name = list_of_male_names[0]
	else:
		list_of_female_names.shuffle()
		hero.name = list_of_female_names[0]
	if index >= GameData.actors.size():
		GameData.actors.resize(index + 1)
	hero.role = role.duplicate()
	hero.background = background.duplicate()
	# final touch
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
