extends Node

@onready var current_actors: Node = %CurrentActors
@onready var background_templates: Node = %BackgroundTemplates
@onready var role_templates: Node = %RoleTemplates

func get_actor(target_index : int):
	for actor in current_actors.get_children():
		if actor.slot_index == target_index:
			return actor
