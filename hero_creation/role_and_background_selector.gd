extends PanelContainer

@onready var roles_menu: OptionButton = %RolesMenu
@onready var backgrounds_menu: OptionButton = %BackgroundsMenu
var index = -1

func _ready() -> void:
	_start_role_menu()
	_start_background_menu()

func _start_role_menu():
	roles_menu.get_popup().canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	roles_menu.clear()
	for i in ActorManager.hero_roles.size():
		var role = ActorManager.hero_roles[i]
		roles_menu.add_item(Utils.id_to_string(role.id))

func _start_background_menu():
	backgrounds_menu.get_popup().canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	backgrounds_menu.clear()
	for i in ActorManager.hero_backgrounds.size():
		var background = ActorManager.hero_backgrounds[i]
		backgrounds_menu.add_item(Utils.id_to_string(background.id))

func _on_roles_menu_item_selected(_index: int) -> void:
	_create_hero()

func _on_backgrounds_menu_item_selected(_index: int) -> void:
	_create_hero()

func _create_hero():
	ActorManager.create_hero(
		ActorManager.hero_roles[roles_menu.get_selected_id()],
		ActorManager.hero_backgrounds[backgrounds_menu.get_selected_id()],
		index
	)
