extends CanvasLayer

@onready var role_and_background_selector: PanelContainer = %RoleAndBackgroundSelector
@onready var attributes: HBoxContainer = %Attributes
@onready var stats: GridContainer = %Stats
var index = 0

func _ready() -> void:
	role_and_background_selector.index = index
	attributes.index = index
	stats.index = index
	ActorManager.create_hero(
		ActorManager.hero_roles.pick_random(),
		ActorManager.hero_backgrounds.pick_random(),
		index
	)

func _on_x_btn_pressed() -> void:
	ActorManager.remove_hero(index)
	queue_free()

func _on_accept_btn_pressed() -> void:
	queue_free()
