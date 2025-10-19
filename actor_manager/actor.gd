extends Node
class_name Actor

enum Backgrounds { NONE, STREETKID, CORPO, MUTANT }
enum Sexes { NONE, MALE, FEMALE }

@export var strength = 0
@export var dex = 0
@export var charm = 0
@export var wits = 0
@export var bp_display : PackedScene
@export var max_hp = 0
var current_hp = 0
var background = null
var actor_name = ""
var id = name
var slot_index = -1

var names = Utils.load_json("res://data/names.json")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	SignalManager.update_actor_display.connect(_on_update_actor_display)
	SignalManager.remove_actor.connect(_on_remove_actor)
	if actor_name == "":
		actor_name = _get_randome_name(Sexes.MALE)
	if not id:
		id = name

func _on_update_actor_display(target_index : int):
	if slot_index != target_index: return
	await get_tree().process_frame
	var display = bp_display.instantiate()
	display.actor = self
	display.slot_index = slot_index
	Utils.slots[slot_index].actor_container.add_child(display)

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
	var value = self[attribute]
	if background:
		value += background[attribute]
	return value

func get_max_hp() -> int:
	var value = max_hp
	return value

func get_current_hp() -> int:
	var value = current_hp
	return value
