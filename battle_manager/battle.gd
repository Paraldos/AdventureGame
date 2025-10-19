extends Node
class_name Battle

@export var front : Array[PackedScene]
@export var middle : Array[PackedScene]
@export var back : Array[PackedScene]

var id
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	SignalManager.start_battle.connect(_on_start_battle)
	rng.randomize()
	id = name

func _on_start_battle( target_id : String ):
	if id != target_id: return
	_add_actor(3, front)
	_add_actor(4, middle)
	_add_actor(5, back)

func _add_actor(slot_index : int, array : Array):
	var actor = array.pick_random().instantiate()
	actor.slot_index = slot_index
	ActorManager.current_actors.add_child(actor)
	SignalManager.update_actor_display.emit(slot_index)
