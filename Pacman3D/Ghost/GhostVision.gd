extends RayCast

signal wall_hit(dir)
signal player_hit

func _physics_process(delta):
	if is_colliding():
		var target = get_collider()
		if target.is_in_group("walls"):
			emit_signal("wall_hit")
		
