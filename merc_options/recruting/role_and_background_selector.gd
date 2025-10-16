extends HBoxContainer

@onready var roles_menu: OptionButton = %RolesMenu
@onready var backgrounds_menu: OptionButton = %BackgroundsMenu
var index = -1
var disabled = true

func _ready() -> void:
	await _start_role_menu()
	await _start_background_menu()
	SignalManager.update_actor_value.connect(_udpate_selected)
	disabled = false

func _start_role_menu():
	# set filter
	var popup = roles_menu.get_popup()
	popup.canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	# clear
	roles_menu.clear()
	# fill
	await get_tree().process_frame
	for i in ActorManager.hero_roles.size():
		var role = ActorManager.hero_roles[i]
		roles_menu.add_item(Utils.id_to_string(role.id))
	await _update_role()
	return

func _start_background_menu():
	# set filter
	var popup = backgrounds_menu.get_popup()
	popup.canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	# clear
	backgrounds_menu.clear()
	# fill
	await get_tree().process_frame
	for i in ActorManager.hero_backgrounds.size():
		var background = ActorManager.hero_backgrounds[i]
		backgrounds_menu.add_item(Utils.id_to_string(background.id))
	await _update_background()
	return

func _udpate_selected():
	disabled = true
	await _update_role()
	await _update_background()
	disabled = false

func _update_role():
	var selected_role = GameData.actors[index].role.id
	for i in ActorManager.hero_roles.size():
		var role = ActorManager.hero_roles[i]
		if role.id == selected_role:
			roles_menu.select(i)
			return

func _update_background():
	var selected_background = GameData.actors[index].background.id
	for i in ActorManager.hero_backgrounds.size():
		var background = ActorManager.hero_backgrounds[i]
		if background.id == selected_background:
			backgrounds_menu.select(i)
			return

func _on_roles_menu_item_selected(_index: int) -> void:
	if disabled: return
	GameData.actors[index].role = ActorManager.hero_roles[roles_menu.get_selected_id()].duplicate()
	SignalManager.update_actor_value.emit()

func _on_backgrounds_menu_item_selected(_index: int) -> void:
	if disabled: return
	GameData.actors[index].background = ActorManager.hero_backgrounds[backgrounds_menu.get_selected_id()].duplicate()
	SignalManager.update_actor_value.emit()
