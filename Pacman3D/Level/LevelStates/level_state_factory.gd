extends Node

class_name LevelStateFactory

var states

func _init():
	states = {
		"normal": LevelNormal,
		"danger": LevelDanger
	}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
