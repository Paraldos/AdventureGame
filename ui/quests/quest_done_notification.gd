extends CanvasLayer

@onready var credits_label: Label = %CreditsLabel

func _ready():
	credits_label.text = "Credits: %s" % GameData.credits

func _on_background_btn_pressed() -> void:
	print('background')

func _on_btn_pressed() -> void:
	print('btn')
