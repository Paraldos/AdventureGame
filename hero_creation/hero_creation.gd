extends CanvasLayer

@onready var role_btn: Button = %RoleBtn
@onready var roles_container: VBoxContainer = %RolesContainer

var bp_role_btn = preload("res://hero_creation/role_btn.tscn")
var index = 0

func _ready() -> void:
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

func _on_x_btn_pressed() -> void:
	ActorManager.remove_hero(index)
	queue_free()

func _on_accept_btn_pressed() -> void:
	queue_free()

func _on_role_btn_pressed() -> void:
	roles_container.visible = !roles_container.visible
