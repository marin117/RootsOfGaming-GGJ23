extends GhostState

class_name GhostWander

func get_new_position():
	if self.nav_agent.is_navigation_finished():
		.update_target(get_random_pos())
	
func get_random_pos():
	var radius = 30
	var random_position = Vector3(rand_range(-radius, radius), 0, 
		rand_range(-radius, radius))
	return random_position
