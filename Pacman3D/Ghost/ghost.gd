extends KinematicBody

var speed = 5

var last_dir
var nav_agent

var velocity = Vector3.ZERO

var state
var state_factory

signal ghost_chasing
signal ghost_wandering

func _ready():
	#last_dir = randi() % 4
	nav_agent = $NavigationAgent
	state_factory = GhostStateFactory.new()
	change_state("wander")
	
func _physics_process(_delta):
	#update_target(get_parent().get_node("Player").global_transform.origin)
	state.get_new_position()
	var next_location = nav_agent.get_next_location()
	var dir = global_transform.origin.direction_to(next_location)
	var new_velocity = dir * speed
	look_at(transform.origin + new_velocity, Vector3.UP)
	nav_agent.set_velocity(new_velocity)

func _on_NavigationAgent_velocity_computed(safe_velocity):
	move_and_slide(safe_velocity, Vector3.UP)
	
func update_target(location):
	nav_agent.set_target_location(location)

func _on_PlayerArea_body_entered(body):
	if body.is_in_group("player"):
		set_chasing()

func _on_PlayerArea_body_exited(body):
	if body.is_in_group("player"):
		set_wandering()
		
func change_state(new_state):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state).new()
	if new_state == "chase":
		state.connect("query_position", self, "get_player_position")
	state.setup(funcref(self, "change_state"), nav_agent, self)
	state.name = "current_state"
	call_deferred("add_child", state)

func get_player_position():
	update_target(get_parent().get_node("Player").global_transform.origin)

func set_chasing():
	change_state("chase")
	emit_signal("ghost_chasing")

func set_wandering():
	change_state("wander")
	emit_signal("ghost_wandering")
