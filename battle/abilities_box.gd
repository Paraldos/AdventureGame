extends HBoxContainer

@onready var btns: GridContainer = %Btns
@onready var label: Label = %Label
var enemy : Enemy

func _ready() -> void:
	for i in btns.get_child_count():
		var btn : Button = btns.get_child(i)
		_init_btn(btn, i)
		_update_btn(btn, i)

func _init_btn(btn : Button, i : int):
	if Database.player.abilities.size() <= i: return
	var ability_id : String = Database.player.abilities[i]
	var ability : Ability = Database.ability_map[ability_id]
	btn.icon = ability.img
	btn.mouse_entered.connect(_on_mouse_entered.bind(ability.description))
	btn.pressed.connect(_on_btn_pressed.bind(ability))

func _update_btn(btn : Button, i : int):
	if Database.player.abilities.size() <= i:
		btn.disabled = true
	else:
		btn.disabled = false

func _on_mouse_entered(description):
	label.text = description

func _on_btn_pressed(ability : Ability):
	ability.use(Database.player, enemy)
