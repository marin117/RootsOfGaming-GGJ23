extends Node

class_name GhostStateFactory

var states

func _init():
	states = {
		"wander": GhostWander,
		"chase": GhostChase
	}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
