extends Node

class_name LevelState

var change_state
var persistent_state


func setup(_change_state, _persistent_state):
	self.change_state = _change_state
	self.persistent_state = _persistent_state
