extends Camera

export var camDistance = 8.0

export var camHeight = 5.0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	set_as_toplevel(true)

func _physics_process(delta):
	var target = get_parent().global_transform.origin
	var pos = global_transform.origin
	
	var offset = pos - target
	offset = offset.normalized() * camDistance
	
	offset.y = camHeight
	
	pos = target + offset
	look_at_from_position(pos, target, Vector3.UP)