extends Control

@onready var name_label: Label = %NameLabel
@onready var class_label: Label = %ClassLabel

func _ready() -> void:
	return
	SignalManager.select_hero.connect(_on_select_hero)

func _on_select_hero():
	name_label.text = "%s" % GameData.actors[GameData.selected_actor].name
	class_label.text = "%s (%s)" % [GameData.actors[GameData.selected_actor].archetype, GameData.actors[GameData.selected_actor].level]
