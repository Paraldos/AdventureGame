extends Node

signal change_dialog_node(new_node : DialogNode)
signal end_dialog

signal start_battle(battle_id : String)
signal start_player_turn
signal start_npc_turn
signal change_action_description(new_text : String)
signal action_btn_clicked(a: Action)
