extends Control

@onready var name_label: Label = %NameLabel
@onready var class_label: Label = %ClassLabel

func _ready() -> void:
	SignalManager.select_hero.connect(_on_select_hero)

func _on_select_hero():
	name_label.text = "%s" % GameData.creatures[GameData.selected_hero].name
	class_label.text = "%s" % GameData.creatures[GameData.selected_hero].class
