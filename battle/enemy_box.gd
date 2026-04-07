extends HBoxContainer

@onready var texture_rect: TextureRect = %TextureRect
@onready var hp: Label = %HP
@onready var attack: Label = %Attack
@onready var armor: Label = %Armor
var enemy : Enemy

func _ready() -> void:
	Signals.update_battle_boxes.connect(update)

func update():
	if texture_rect.texture == null:
		texture_rect.texture = enemy.img
	hp.text = "%s/%s" % [enemy.hp_current, enemy.hp_max]
	attack.text = "%s" % enemy.attack
	armor.text = "%s" % enemy.armor
