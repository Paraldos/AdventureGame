extends HBoxContainer

@onready var roles_menu: OptionButton = %RolesMenu
@onready var backgrounds_menu: OptionButton = %BackgroundsMenu
var slot_index = 0
var disabled = true

func _ready() -> void:
	_set_filter_for_popups()
	_clear_menus()
	await get_tree().process_frame
	_fill_menus()
	disabled = false

func _set_filter_for_popups():
	var popup1 = roles_menu.get_popup()
	var popup2 = backgrounds_menu.get_popup()
	popup1.canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	popup2.canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST

func _clear_menus():
	roles_menu.clear()
	backgrounds_menu.clear()

func _fill_menus():
	for role in ActorManager.role_templates.get_children():
		roles_menu.add_item(Utils.id_to_string(role.id))
	for background in ActorManager.background_templates.get_children():
		backgrounds_menu.add_item(Utils.id_to_string(background.id))

func _on_roles_menu_item_selected(index: int) -> void:
	if disabled: return
	# save old background
	var current_actor = ActorManager.current_actors.get_child(slot_index)
	var old_name = current_actor.actor_name
	var old_background = current_actor.background
	# remove old actor
	SignalManager.remove_actor.emit(slot_index)
	# set new role
	var new_actor = ActorManager.role_templates.get_child(index).duplicate()
	new_actor.actor_name = old_name
	new_actor.slot_index = slot_index
	new_actor.background = old_background
	ActorManager.current_actors.add_child(new_actor)

func _on_backgrounds_menu_item_selected(index: int) -> void:
	if disabled: return
	var current_actor = ActorManager.current_actors.get_child(slot_index)
	var new_background = ActorManager.background_templates.get_child(index)
	current_actor.background = new_background
