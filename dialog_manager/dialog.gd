extends Node
class_name Dialog

enum Speakers { RANDOME_HERO, RANDOME_ENEMY, NARRATOR, BOSS }

@export_multiline var text : String
@export var target_id : String
@export var speaker : Speakers
@export var location : Array[String]
@export var options : Array[DialogOption]