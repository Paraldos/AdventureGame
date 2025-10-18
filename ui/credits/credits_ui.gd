extends MarginContainer

@onready var label: Label = %Label

func _ready() -> void:
	_on_update_credits()
	SignalManager.update_credits.connect(_on_update_credits)

func _on_update_credits():
	label.text = "%s $" % GameData.credits
