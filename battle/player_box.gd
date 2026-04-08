extends HBoxContainer

@onready var float_marker: Control = %FloatMarker
@onready var active_sprite: TextureRect = %ActiveSprite
@onready var main_sprite: TextureRect = %MainSprite
@onready var hp: Label = %HP
@onready var attack: Label = %Attack
@onready var armor: Label = %Armor

var character : Entity
var target : Entity

func _ready() -> void:
	Signals.update_battle_boxes.connect(update)
	Signals.spawn_floating_number.connect(_on_spawn_floating_number)

func update():
	hp.text = "%s/%s" % [character.hp_current, character.hp_max]
	attack.text = "%s" % character.attack
	armor.text = "%s" % character.armor

func _on_spawn_floating_number(entity: Entity, number: int, color: Color):
	if entity != character: return
	var pos = float_marker.global_position
	Utils.spawn_floating_number(pos, number, color)
