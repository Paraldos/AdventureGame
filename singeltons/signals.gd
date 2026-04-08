extends Node

signal set_camera_rect(rect : Rect2)
signal update_battle_boxes
signal disable_battle_btns
signal next_turn
signal spawn_floating_number(target, number, color)
signal play_battle_animation(target_character : Entity, animation_id : Enums.battle_animations)