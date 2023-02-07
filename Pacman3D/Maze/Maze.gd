extends NavigationMeshInstance

func _ready():
	for mesh_instance in get_children():
		if mesh_instance is MeshInstance and mesh_instance.get_child_count() > 0:
			var body = mesh_instance.get_child(0)
			if body is StaticBody:
				body.add_to_group("walls")
				body.set_collision_layer_bit(0, false)
				body.set_collision_layer_bit(31, true)
