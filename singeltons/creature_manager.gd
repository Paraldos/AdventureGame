extends Node

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
var fighter = {
	name = "",
	max_hp = 50,
	current_hp = 50,
	strength = 1,
	dex = 1,
	wits = 1,
	charm = 1,
	level = 1,
	template = 'res://creatures/fighter/fighter.tscn'
}
var hero_roles = [
	fighter
]

func _ready() -> void:
	rng.randomize()

func create_hero():
	var hero = fighter
	list_of_female_names.shuffle()
	hero.name = list_of_female_names[0]
	return hero

func add_creature_to_screen(hero : Dictionary, target_position : Vector2, index : int):
	var template = load(hero.template)
	var creature = template.instantiate()
	creature.position = target_position
	creature.index = index
	get_tree().current_scene.add_child(creature)
