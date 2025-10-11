extends CanvasLayer

@onready var class_btn: Button = %ClassBtn
@onready var roles_container: VBoxContainer = %RolesContainer
@onready var list_of_classes = [
	'fighter'
]

var index = 0

func _ready() -> void:
	roles_container.visible = false
	for role in CreatureManager.hero_roles:
		print(role.name)

func _on_x_btn_pressed() -> void:
	queue_free()

func _on_accept_btn_pressed() -> void:
	queue_free()

func _on_class_btn_pressed() -> void:
	roles_container.visible = !roles_container.visible

func _on_race_btn_pressed() -> void:
	roles_container.visible = false

func _on_zodiac_btn_pressed() -> void:
	roles_container.visible = false
