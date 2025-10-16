extends Marker2D
class_name Slot

enum BTN_STATUS { INVISIBLE, DISABLED, ACTIVE }

@onready var button: Button = %Button
@onready var pointer: Sprite2D = %Pointer
@onready var actor_container: Node2D = %ActorContainer

@export var index = 0
var bp_hero_creation = preload('res://hero_creation/hero_creation.tscn')
var selected = false

func _ready() -> void:
	SignalManager.update_actor_template.connect(_update_actor)
	SignalManager.state_changed.connect(_update_slot_btn)
	SignalManager.remove_selected.connect(_update_slot_btn)
	_update_slot_btn()

# ========================================= update actor
func _update_slot_btn():
	button.visible = false
	pointer.visible = false
	selected = false
	match GameManager.state:
		GameManager.States.NONE:
			pass
		GameManager.States.RECRUTING:
			button.visible = index <= 2

func _update_actor(target_index):
	if not target_index == index: return
	# cleanup
	for child in actor_container.get_children():
		child.queue_free()
	# spawn new actor
	if not GameData.actors[index]: return
	var actor: Dictionary = GameData.actors[index]
	var bp: PackedScene = load(actor.role.template)
	var inst: Node2D = bp.instantiate()
	inst.index = index
	actor_container.add_child(inst)

# ========================================= btn
func _on_button_mouse_entered() -> void:
	if button.disabled: return
	pointer.visible = true

func _on_button_mouse_exited() -> void:
	if selected: return
	pointer.visible = false

func _on_button_pressed() -> void:
	match GameManager.state:
		GameManager.States.RECRUTING:
			var hero_creation = bp_hero_creation.instantiate()
			selected = true
			hero_creation.index = index
			get_tree().current_scene.add_child(hero_creation)
