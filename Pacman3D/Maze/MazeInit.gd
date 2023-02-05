extends StaticBody

func _ready():
	for c in get_children():
		if typeof(c) == typeof(StaticBody):
			c.add_to_group("walls")

