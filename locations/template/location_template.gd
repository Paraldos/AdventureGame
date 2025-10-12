extends Node2D

@onready var positions = [
	%Slot,
	%Slot1,
	%Slot2,
	%Slot3,
	%Slot4,
	%Slot5,
]

func _ready():
	Utils.current_location = self
	SignalManager.select_hero.emit()
