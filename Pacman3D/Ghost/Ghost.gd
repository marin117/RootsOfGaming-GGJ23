extends KinematicBody

var speed = 5

var last_dir
var nav_agent

var targetNode

var velocity = Vector3.ZERO
var movement_delta : float

signal chasing
signal wandering

var is_chasing = false

func _ready():
	#last_dir = randi() % 4
	nav_agent = $NavigationAgent
	
func _physics_process(delta):
	#update_target(get_parent().get_node("Player").global_transform.origin)
	var current_position = global_transform.origin
	var next_location = nav_agent.get_next_location()
	var dir = global_transform.origin.direction_to(next_location)
	var new_velocity = dir * speed
	nav_agent.set_velocity(new_velocity)

func _on_NavigationAgent_velocity_computed(safe_velocity):
	move_and_slide(safe_velocity, Vector3.UP)

func set_movement_target(movement_target : Vector3):
	nav_agent.set_target_position(movement_target)
	
func update_target(location):
	nav_agent.set_target_location(location)

func _on_PlayerArea_body_entered(body):
	if body.is_in_group("player"):
		is_chasing = true
		emit_signal("chasing")

func _on_PlayerArea_body_exited(body):
	if body.is_in_group("player"):
		is_chasing = false
		emit_signal("wandering")
