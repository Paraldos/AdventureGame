extends Node
class_name Dialog

enum Speakers { RANDOME_HERO, RANDOME_ENEMY, NARRATOR, BOSS, SLOT3, SLOT4, SLOT5 }

@export_multiline var text : String
@export var location : Array[String]

@export_group("Options")
@export var target_id : String
@export var options : Array[DialogOption]

@export_group("Speaker")
@export var speaker : Speakers
@export var add_npc : PackedScene