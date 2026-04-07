extends HBoxContainer

@onready var hp: Label = %HP
@onready var attack: Label = %Attack
@onready var armor: Label = %Armor

func _ready() -> void:
	update()
	Signals.update_battle_boxes.connect(update)

func update():
	hp.text = "%s/%s" % [Database.player.hp_current, Database.player.hp_max]
	attack.text = "%s" % Database.player.attack
	armor.text = "%s" % Database.player.armor
