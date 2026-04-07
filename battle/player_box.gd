extends HBoxContainer

@onready var hp: Label = %HP
@onready var attack: Label = %Attack
@onready var armor: Label = %Armor

func _ready() -> void:
	update()

func update():
	hp.text = "%s/%s" % [Game.hp_current, Game.hp_max]
	attack.text = "%s" % Game.attack
	armor.text = "%s" % Game.armor
