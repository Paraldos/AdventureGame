extends HBoxContainer

@onready var float_marker: Control = %FloatMarker
@onready var active_sprite: TextureRect = %ActiveSprite
@onready var main_sprite: TextureRect = %MainSprite
@onready var hp: Label = %HP
@onready var attack: Label = %Attack
@onready var armor: Label = %Armor

var character : Entity
var target : Entity
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	Signals.update_battle_boxes.connect(update)
	Signals.spawn_floating_number.connect(_on_spawn_floating_number)
	Signals.play_battle_animation.connect(_on_play_battle_animation)

func update():
	hp.text = "%s/%s" % [character.hp_current, character.hp_max]
	attack.text = "%s" % character.attack
	armor.text = "%s" % character.armor

func next_turn(next_character : Entity):
	active_sprite.visible = next_character == character

func _on_spawn_floating_number(entity: Entity, number: int, color: Color):
	if entity != character: return
	var pos = float_marker.global_position
	Utils.spawn_floating_number(pos, number, color)

func _on_play_battle_animation(target_character : Entity, animation_id : Enums.battle_animations):
	if target_character != character: return
	match animation_id:
		Enums.battle_animations.ATTACK:
			_attack_animation()
		Enums.battle_animations.SHAKE:
			_shake_animation()

func _attack_animation():
	var base_pos := main_sprite.position
	var offset = Vector2(15,0) if character == Database.player else Vector2(-15,0)
	var tween := create_tween()
	var duration := 0.5
	main_sprite.position = base_pos + offset
	tween.tween_property(main_sprite, "position", base_pos, duration)

func _shake_animation():
	var base_pos := main_sprite.position
	var tween := create_tween()
	var strength := 5.0
	var half_strengt := strength / 2
	var duration := 0.05
	for i in range(5):
		var offset := Vector2(
			randf_range(-strength, strength),
			randf_range(-half_strengt, half_strengt)
		)
		tween.tween_property(main_sprite, "position", base_pos + offset, duration)
	tween.tween_property(main_sprite, "position", base_pos, duration)
