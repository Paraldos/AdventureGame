extends Node

signal select_hero
signal update_actor_value
signal update_actor_template(index)
signal scene_changed
signal remove_npcs
signal state_changed
signal deselect_slot_btn

signal remove_actor(index : int)

signal start_quest(quest_id : String)
signal update_quest
signal finish_quest(quest_id : String)
signal quest_finished

signal update_credits

signal enable_dialog(id : String, new_status : bool, timer : float )

signal dialog_option_selected( old_dialog_id : String, selected_option : DialogOption )
signal remove_dialog_bubbles()