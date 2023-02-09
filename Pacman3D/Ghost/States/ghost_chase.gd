extends GhostState

class_name GhostChase

signal query_position

func get_new_position():
	.emit_signal("query_position")
