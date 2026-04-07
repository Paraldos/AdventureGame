extends HBoxContainer

@onready var btns: GridContainer = %Btns
@onready var label: Label = %Label

func _ready() -> void:
	for i in btns.get_child_count():
		var btn : Button = btns.get_child(i)
		_update_btn(btn, i )

func _update_btn(btn : Button, i : int):
	if Game.abilities.size() <= i:
		btn.disabled = true
		return
	var ability_id : String = Game.abilities[i]
	var ability : Ability = Database.ability_map[ability_id]
	btn.icon = ability.img
	btn.mouse_entered.connect(_on_mouse_entered.bind(ability.description))

func _on_mouse_entered(description):
	label.text = description
