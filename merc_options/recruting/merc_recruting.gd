extends CanvasLayer

@onready var role_and_background_selector: HBoxContainer = %RoleAndBackgroundSelector
@onready var attributes: HBoxContainer = %Attributes
@onready var stats: GridContainer = %Stats
@onready var x_btn: TextureButton = %XBtn
@onready var return_btn: TextureButton = %ReturnBtn
@onready var accept_btn: TextureButton = %AcceptBtn
var slot_index = 0
var old_actor = null

func _ready() -> void:
	# create new actor
	var new_actor = ActorManager.role_templates.get_child(0).duplicate()
	new_actor.slot_index = slot_index
	new_actor.background = ActorManager.background_templates.get_child(0)
	ActorManager.current_actors.add_child(new_actor)
	# role and background selector
	role_and_background_selector.slot_index = slot_index

func _on_x_btn_pressed() -> void:
	if old_actor:
		GameData.actors[slot_index] = old_actor
	else:
		GameData.actors[slot_index] = null
	close()

func _on_accept_btn_pressed() -> void:
	SignalManager.update_quest.emit()
	close()

func _on_return_btn_pressed() -> void:
	GameData.actors[slot_index] = old_actor.duplicate()
	SignalManager.update_actor_value.emit()

func close() -> void:
	SignalManager.update_actor_template.emit(slot_index)
	SignalManager.deselect_slot_btn.emit()
	queue_free()
