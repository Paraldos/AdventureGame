extends Node
class_name Actor

enum Backgrounds { NONE, STREETKID, CORPO, MUTANT }
enum Sexes { NONE, MALE, FEMALE }

@export var strength = 0
@export var dex = 0
@export var charm = 0
@export var wits = 0
@export var display : PackedScene
@export var max_hp = 0
var current_hp = 0
var background = null
var actor_name = ""
var id = name
var slot_index = -1

var names = Utils.load_json("res://data/names.json")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	SignalManager.remove_actor.connect(_on_remove_actor)
	actor_name = _get_randome_name(Sexes.MALE)
	if not id:
		id = name
	print("id: ", id)

func _get_randome_name(sex : Sexes):
	if sex == Sexes.MALE:
		names.male.shuffle()
		return names.male[0]
	else:
		names.female.shuffle()
		return names.female[0]

func _on_remove_actor(target_slot_index : int):
	if slot_index == target_slot_index:
		queue_free()

func get_attribute( attribute : String ) -> int:
	var value = [attribute]
	if not background == null:
		value += background[attribute]
	return value

func get_max_hp() -> int:
	var value = [max_hp]
	return value

func get_current_hp() -> int:
	var value = [current_hp]
	return value
