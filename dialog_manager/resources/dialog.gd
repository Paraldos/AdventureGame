extends Node
class_name Dialog

enum Speakers { SLOT1, SLOT2, SLOT3, SLOT4, SLOT5, SLOT6, NARRATOR, RANDOME_HERO, RANDOMY_ENEMY }

@export_multiline var text : String
@export var location : String

@export_group("Options")
@export var options : Array[DialogOption]
@export var target_id : String
@export var start_recruting = false

@export_group("Speaker")
@export var speaker : Speakers
@export var add_npc : PackedScene