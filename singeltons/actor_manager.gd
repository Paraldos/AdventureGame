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
	max_hp = 50,
	current_hp = 50,
	charm = 0,
	dex = 1,
	strength = 2,
	wits = 0,
	level = 1,
	template = 'res://actors/fighter/fighter.tscn'
}
var hacker = {
	id = "hacker",
	sex = "female",
	max_hp = 50,
	current_hp = 50,
	charm = 0,
	dex = 1,
	strength = 0,
	wits = 2,
	level = 1,
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
func remove_hero(index) -> void:
	GameData.actors[index] = null
	SignalManager.update_actor.emit(index)

func create_hero(role, background, index) -> void:
	# role
	var hero = role.duplicate()
	# background
	hero.background = background.id
	hero.charm += background.charm
	hero.dex += background.dex
	hero.strength += background.strength
	hero.wits += background.wits
	# name
	if role.sex == "male":
		list_of_male_names.shuffle()
		hero.name = list_of_male_names[0]
	else:
		list_of_female_names.shuffle()
		hero.name = list_of_female_names[0]
	if index >= GameData.actors.size():
		GameData.actors.resize(index + 1)
	# final touch
	GameData.actors[index] = hero
	SignalManager.update_actor.emit(index)
	SignalManager.update_actor_hero_creation.emit()
