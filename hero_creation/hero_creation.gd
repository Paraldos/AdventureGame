extends CanvasLayer

@onready var role_btn: Button = %RoleBtn
@onready var roles_container: VBoxContainer = %RolesContainer
@onready var label_strength: Label = %LabelStrength
@onready var label_dex: Label = %LabelDex
@onready var label_charm: Label = %LabelCharm
@onready var label_wits: Label = %LabelWits

var bp_role_btn = preload("res://hero_creation/role_btn.tscn")
var index = 0

func _ready() -> void:
	SignalManager.update_actor.connect(_on_update_actor)
	roles_container.visible = false
	ActorManager.create_hero(
		ActorManager.hero_roles.pick_random(),
		ActorManager.hero_backgrounds.pick_random(),
		index
	)
	for role in ActorManager.hero_roles:
		var btn = bp_role_btn.instantiate()
		btn.index = index
		btn.role = role
		roles_container.add_child(btn)
	SignalManager.update_actor.emit()

func _on_update_actor(_index):
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

func _on_x_btn_pressed() -> void:
	ActorManager.remove_hero(index)
	queue_free()

func _on_accept_btn_pressed() -> void:
	queue_free()

func _on_role_btn_pressed() -> void:
	roles_container.visible = !roles_container.visible
