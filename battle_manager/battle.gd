extends Node
class_name Battle

var id

func _ready() -> void:
	SignalManager.start_battle.connect(_on_start_battle)
	id = name

func _on_start_battle( target_id : String ):
	if id != target_id: return
	print(target_id)