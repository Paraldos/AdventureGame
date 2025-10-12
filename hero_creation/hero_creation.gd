extends CanvasLayer

@onready var roles_menu: OptionButton = %RolesMenu
@onready var backgrounds_menu: OptionButton = %BackgroundsMenu

@onready var label_strength: Label = %LabelStrength
@onready var label_dex: Label = %LabelDex
@onready var label_charm: Label = %LabelCharm
@onready var label_wits: Label = %LabelWits

var index = 0

func _ready() -> void:
	backgrounds_menu.get_popup().canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	ActorManager.create_hero(
		ActorManager.hero_roles.pick_random(),
		ActorManager.hero_backgrounds.pick_random(),
		index
	)
	_role_menu_setup()
	_background_menu_setup()

func _on_update_actor_hero_creation():
	_update_attributes()

func _update_attributes():
	label_strength.text = "Strength
	%s" % GameData.actors[index].strength
	label_dex.text = "Dex
	%s" % GameData.actors[index].dex
	label_charm.text = "Charm
	%s" % GameData.actors[index].charm
	label_wits.text = "Wits
	%s" % GameData.actors[index].wits

func _role_menu_setup():
	roles_menu.get_popup().canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	roles_menu.clear()
	for i in ActorManager.hero_roles.size():
		var role = ActorManager.hero_roles[i]
		roles_menu.add_item(role.name)

func _background_menu_setup():
	SignalManager.update_actor_hero_creation.connect(_on_update_actor_hero_creation)
	backgrounds_menu.clear()
	for i in ActorManager.hero_backgrounds.size():
		var background = ActorManager.hero_backgrounds[i]
		backgrounds_menu.add_item(background.name)

func _on_x_btn_pressed() -> void:
	ActorManager.remove_hero(index)
	queue_free()

func _on_accept_btn_pressed() -> void:
	queue_free()

func _on_role_btn_pressed() -> void:
	pass

func _on_roles_menu_item_selected(_index: int) -> void:
	ActorManager.create_hero(
		ActorManager.hero_roles[roles_menu.get_selected_id()],
		ActorManager.hero_backgrounds[backgrounds_menu.get_selected_id()],
		index
	)

func _on_backgrounds_menu_item_selected(_index: int) -> void:
	ActorManager.create_hero(
		ActorManager.hero_roles[roles_menu.get_selected_id()],
		ActorManager.hero_backgrounds[backgrounds_menu.get_selected_id()],
		index
	)
