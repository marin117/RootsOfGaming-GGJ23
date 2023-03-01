extends Node

class_name Level

signal no_coins

var ghosts = []
var ghosts_chasing = []

var max_ghosts = 4
var num_coins = 50 # default number

var state
var state_factory

func _ready():
	state_factory = LevelStateFactory.new()
	change_state("normal")

func add_ghost(ghost):
	if ghosts.size() < max_ghosts:
		ghosts.append(ghost)

func add_chasing_ghost(ghost):
	if !ghosts_chasing.has(ghost):
		ghosts_chasing.append(ghost)
		change_state("danger")

func remove_chasing_ghost(ghost):
	if ghosts_chasing.has(ghost):
		ghosts_chasing.erase(ghost)
	if ghosts_chasing.empty():
		change_state("normal")

func coin_picked_up():
	if num_coins == 0:
		emit_signal("no_coins")
		return
	num_coins -= 1
	
func change_state(new_state):
	if state != null and new_state == state.name:
		return
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state).new()
	state.setup(funcref(self, "change_state"), self)
	state.name = "current_state"
	call_deferred("add_child", state)
