extends HBoxContainer

@onready var btns: GridContainer = %Btns
@onready var label: Label = %Label
var enemy : Enemy

func _ready() -> void:
	_init_btns()
	_update_btns()
	Signals.disable_battle_btns.connect(_disable_btns)
	Signals.enable_battle_btns.connect(_update_btns)

func _init_btns():
	for i in btns.get_child_count():
		if Database.player.abilities.size() <= i: return
		var btn : Button = btns.get_child(i)
		var ability_id : String = Database.player.abilities[i]
		var ability : Ability = Database.ability_map[ability_id]
		btn.icon = ability.img
		btn.mouse_entered.connect(_on_mouse_entered.bind(ability.description))
		btn.pressed.connect(_on_btn_pressed.bind(ability))

func _disable_btns():
	for btn in btns.get_children():
		btn.disabled = true

func _update_btns():
	for i in btns.get_child_count():
		var btn : Button = btns.get_child(i)
		if Database.player.abilities.size() <= i:
			btn.disabled = true
		else:
			btn.disabled = false

func _on_mouse_entered(description):
	label.text = description

func _on_btn_pressed(ability: Ability):
	Signals.disable_battle_btns.emit()
	ability.use(Database.player, enemy)
