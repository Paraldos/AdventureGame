extends CanvasLayer

@onready var role_and_background_selector: PanelContainer = %RoleAndBackgroundSelector
@onready var attributes: HBoxContainer = %Attributes
@onready var stats: GridContainer = %Stats
@onready var x_btn: TextureButton = %XBtn
@onready var return_btn: TextureButton = %ReturnBtn
@onready var accept_btn: TextureButton = %AcceptBtn
var index = 0
var old_actor = null

func _ready() -> void:
	role_and_background_selector.index = index
	attributes.index = index
	stats.index = index
	if GameData.actors[index]:
		old_actor = GameData.actors[index].duplicate()
	else:
		return_btn.disabled = true
		ActorManager.create_hero(
			ActorManager.hero_roles.pick_random(),
			ActorManager.hero_backgrounds.pick_random(),
			index
		)
		SignalManager.update_actor_template.emit(index)
	SignalManager.update_actor_value.emit()

func _on_x_btn_pressed() -> void:
	if old_actor:
		GameData.actors[index] = old_actor
	else:
		GameData.actors[index] = null
	SignalManager.update_actor_value.emit()
	queue_free()

func _on_accept_btn_pressed() -> void:
	queue_free()

func _on_return_btn_pressed() -> void:
	GameData.actors[index] = old_actor.duplicate()
	SignalManager.update_actor_value.emit()
