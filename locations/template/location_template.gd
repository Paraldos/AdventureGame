extends Node2D
class_name Location

@onready var slots = [
	%Slot,
	%Slot1,
	%Slot2,
	%Slot3,
	%Slot4,
	%Slot5,
]
@onready var narrator_dialog_position: Marker2D = %NarratorDialogPosition

func _ready():
	Utils.current_location = self
	SignalManager.select_hero.emit()
