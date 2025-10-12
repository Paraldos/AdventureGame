extends Node

var game_state
var actors : Array
var selected_actor = 0
var dialog = { id = "", location = "" }
var slots = [
	Slot.BTN_STATUS.ACTIVE,
	Slot.BTN_STATUS.ACTIVE,
	Slot.BTN_STATUS.ACTIVE,
	Slot.BTN_STATUS.INVISIBLE,
	Slot.BTN_STATUS.INVISIBLE,
	Slot.BTN_STATUS.INVISIBLE ]
