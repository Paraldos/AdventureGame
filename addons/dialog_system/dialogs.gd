@tool
extends Resource
class_name Dialogs

const SAVE_PATH = "res://addons/dialog_system/dialogs.tres"
@export var dialogs: Dictionary[String, DialogSegment] = {}
