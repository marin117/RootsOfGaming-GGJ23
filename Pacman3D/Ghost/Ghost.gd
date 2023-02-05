extends KinematicBody

var speed = 10

var last_dir

"""
0 - left
1 - right
2 - forward
3 - backward
"""
func _ready():
	last_dir = randi() % 4
	pass # Replace with function body
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func handle_wall():
	pass
	
func chase_player():
	pass
	
func get_new_dir():
	pass

func _on_RayCast_player_hit():
	print("Vidim igraca lovi") # Replace with function body.


func _on_RayCast_wall_hit():
	print("Vidim zid")
