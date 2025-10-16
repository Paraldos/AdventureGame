extends CanvasLayer

@onready var list_of_quests: VBoxContainer = %ListOfQuests

func open_quest(quest_id):
	var quest = list_of_quests.get_node(quest_id)
	quest.open_quest()

func solve_quest(quest_id):
	var quest = list_of_quests.get_node(quest_id)
	quest.solve_quest()

func quit_quest(quest_id):
	var quest = list_of_quests.get_node(quest_id)
	quest.quit_quest()
