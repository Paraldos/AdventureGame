extends CanvasLayer

@onready var roles_menu: OptionButton = %RolesMenu
@onready var backgrounds_menu: OptionButton = %BackgroundsMenu

@onready var label_strength: Label = %LabelStrength
@onready var label_dex: Label = %LabelDex
@onready var label_charm: Label = %LabelCharm
@onready var label_wits: Label = %LabelWits

var index = 0

func _ready() -> void:
	SignalManager.update_actor_hero_creation.connect(_on_update_actor_hero_creation)
	ActorManager.create_hero(
		ActorManager.hero_roles.pick_random(),
		ActorManager.hero_backgrounds.pick_random(),
		index
	)
	SignalManager.update_actor_hero_creation.emit()

func _on_update_actor_hero_creation():
	_update_attributes()
	_update_role_menu()

func _update_attributes():
	label_strength.text = "Strength
	%s" % GameData.actors[index].strength
	label_dex.text = "Dex
	%s" % GameData.actors[index].dex
	label_charm.text = "Charm
	%s" % GameData.actors[index].charm
	label_wits.text = "Wits
	%s" % GameData.actors[index].wits

func _update_role_menu():
	roles_menu.clear()
	for i in ActorManager.hero_roles.size():
		var role = ActorManager.hero_roles[i]
		roles_menu.add_item(role.name)
		if GameData.actors[i] == role:
			roles_menu.select(i)

func _on_x_btn_pressed() -> void:
	ActorManager.remove_hero(index)
	queue_free()

func _on_accept_btn_pressed() -> void:
	queue_free()

func _on_role_btn_pressed() -> void:
	pass
