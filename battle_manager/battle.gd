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
	_add_enemy(3, front)
	_add_enemy(4, middle)
	_add_enemy(5, back)
	_set_ini()

func _add_enemy(slot_index : int, array : Array):
	var actor = array.pick_random().instantiate()
	actor.slot_index = slot_index
	ActorManager.current_actors.add_child(actor)
	SignalManager.update_actor_display.emit(slot_index)

func _set_ini():
	var actors = ActorManager.current_actors.get_children()
	actors.sort_custom(func(a, b): return a.get_ini() > b.get_ini())
	for index in actors.size():
		var actor = ActorManager.current_actors.get_child(index)
		actor.current_ini_position = index
	await get_tree().process_frame
	SignalManager.update_ini.emit()
