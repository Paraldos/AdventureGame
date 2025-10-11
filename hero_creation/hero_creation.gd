extends CanvasLayer

@onready var class_btn: Button = %ClassBtn
@onready var roles_container: VBoxContainer = %RolesContainer

var bp_role_btn = preload("res://hero_creation/role_btn.tscn")
var index = 0

func _ready() -> void:
	roles_container.visible = false
	for role in CreatureManager.hero_roles:
		var btn = bp_role_btn.instantiate()
		btn.role = role
		roles_container.add_child(btn)

func _on_x_btn_pressed() -> void:
	queue_free()

func _on_accept_btn_pressed() -> void:
	queue_free()

func _on_role_btn_pressed() -> void:
	roles_container.visible = !roles_container.visible

func _on_race_btn_pressed() -> void:
	roles_container.visible = false

func _on_zodiac_btn_pressed() -> void:
	roles_container.visible = false
