extends Marker2D
class_name Slot

enum BTN_STATUS { INVISIBLE, DISABLED, ACTIVE }

@onready var button: Button = %Button
@onready var pointer: Sprite2D = %Pointer
@onready var actor_container: Node2D = %ActorContainer

@export var index = 0
var bp_hero_creation = preload('res://hero_creation/hero_creation.tscn')

func _ready() -> void:
	button.visible = false
	pointer.visible = false
	SignalManager.update_actor_template.connect(_on_update_actor)
	match GameManager.state:
		GameManager.States.NONE:
			pass
		GameManager.States.RECRUTING:
			button.visible = index <= 2

# ========================================= update actor
func _on_update_actor(target_index):
	# guard
	if not target_index == index: return
	# cleanup
	for child in actor_container.get_children():
		child.queue_free()
	# spawn new actor
	if not GameData.actors[target_index]: return
	var actor: Dictionary = GameData.actors[target_index]
	var bp: PackedScene = load(actor.role.template)
	var inst: Node2D = bp.instantiate()
	inst.index = index
	actor_container.add_child(inst)

# ========================================= btn
func _on_button_mouse_entered() -> void:
	if button.disabled: return
	pointer.visible = true

func _on_button_mouse_exited() -> void:
	pointer.visible = false

func _on_button_pressed() -> void:
	var hero_creation = bp_hero_creation.instantiate()
	hero_creation.index = index
	get_tree().current_scene.add_child(hero_creation)
