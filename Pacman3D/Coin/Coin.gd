extends KinematicBody

signal destroyed

func pick_up():
	emit_signal("destroyed")
	$ColliderCoin.disabled = true
	queue_free()

func _physics_process(delta):
	rotate_y(0.05)
