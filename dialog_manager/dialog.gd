extends Node
class_name Dialog

enum Speakers { RANDOME_HERO, RANDOME_ENEMY, NARRATOR, BOSS }

@export var text : String
@export var speaker : Speakers
@export var location : Array[String]
@export var option : Array[DialogOption]