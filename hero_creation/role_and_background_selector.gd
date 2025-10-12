extends PanelContainer

@onready var roles_menu: OptionButton = %RolesMenu
@onready var backgrounds_menu: OptionButton = %BackgroundsMenu
var index = -1

func _ready() -> void:
	_start_role_menu()
	_start_background_menu()

func _start_role_menu():
	# set filter
	var popup = roles_menu.get_popup()
	popup.canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	# clear
	roles_menu.clear()
	# fill
	await get_tree().process_frame
	var selected_id = GameData.actors[index].id
	for i in ActorManager.hero_roles.size():
		var role = ActorManager.hero_roles[i]
		roles_menu.add_item(Utils.id_to_string(role.id))
		if role.id == selected_id:
			roles_menu.select(i)

func _start_background_menu():
	# set filter
	var popup = backgrounds_menu.get_popup()
	popup.canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	# clear
	backgrounds_menu.clear()
	# fill
	await get_tree().process_frame
	var selected_id = GameData.actors[index].background
	for i in ActorManager.hero_backgrounds.size():
		var background = ActorManager.hero_backgrounds[i]
		backgrounds_menu.add_item(Utils.id_to_string(background.id))
		if background.id == selected_id:
			backgrounds_menu.select(i)

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
