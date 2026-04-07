extends HBoxContainer

@onready var hp: Label = %HP
@onready var attack: Label = %Attack
@onready var armor: Label = %Armor

func _ready() -> void:
	update()

func update():
	hp.text = "%s/%s" % [5, 10]
	attack.text = "%s" % 1
	armor.text = "%s" % 1
