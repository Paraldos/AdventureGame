extends Node2D

@onready var player_marker: Marker2D = %PlayerMarker
@onready var enemy_marker: Marker2D = %EnemyMarker
@onready var dialog_ui: CanvasLayer = %DialogUi
@export var dialogs : Array[String] = []

func _ready() -> void:
	for dialog in dialogs:
		dialog_ui.start_dialog(dialog)
		return
