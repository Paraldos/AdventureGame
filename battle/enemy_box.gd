extends HBoxContainer

@onready var active_sprite: TextureRect = %ActiveSprite
@onready var main_sprite: TextureRect = %MainSprite
@onready var hp: Label = %HP
@onready var attack: Label = %Attack
@onready var armor: Label = %Armor
var enemy : Enemy

func _ready() -> void:
	active_sprite.visible = false
	Signals.update_battle_boxes.connect(update)

func update():
	main_sprite.texture = enemy.img
	hp.text = "%s/%s" % [enemy.hp_current, enemy.hp_max]
	attack.text = "%s" % enemy.attack
	armor.text = "%s" % enemy.armor
