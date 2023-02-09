extends Node

class_name GhostState

var change_state
var persistent_state
var nav_agent

func setup(_change_state, _nav_agent, _persistent_state):
	self.change_state = _change_state
	self.nav_agent = _nav_agent
	self.persistent_state = _persistent_state

func get_new_position():
	pass

func update_target(location):
	nav_agent.set_target_location(location)
