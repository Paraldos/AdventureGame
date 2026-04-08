extends HBoxContainer

@onready var btns: GridContainer = %Btns
@onready var label: Label = %Label
var enemy : Enemy

func _ready() -> void:
	_init_btns()
	Signals.disable_battle_btns.connect(_on_disable_battle_btns)

func _init_btns():
	_on_disable_battle_btns()
	for i in btns.get_child_count():
		if Database.player.abilities.size() <= i: return
		var btn : Button = btns.get_child(i)
		var ability : Ability = _get_index_ability(i)
		btn.icon = ability.img
		btn.mouse_entered.connect(_on_mouse_entered.bind(ability.description))
		btn.pressed.connect(_on_btn_pressed.bind(ability))

func _on_disable_battle_btns():
	for btn in btns.get_children():
		btn.disabled = true

func next_turn(next_character : Entity):
	for i in btns.get_child_count():
		var player_turn = next_character == Database.player
		if not player_turn: return
		var ability = _get_index_ability(i)
		if not ability: return
		var btn : Button = btns.get_child(i)
		btn.disabled = false

func _get_index_ability(i : int):
	if Database.player.abilities.size() <= i: return null
	var ability_id : String = Database.player.abilities[i]
	var ability : Ability = Database.ability_map[ability_id]
	return ability

func _on_mouse_entered(description):
	label.text = description

func _on_btn_pressed(ability: Ability):
	Signals.disable_battle_btns.emit()
	ability.use(Database.player, enemy)
	Signals.next_turn.emit()
