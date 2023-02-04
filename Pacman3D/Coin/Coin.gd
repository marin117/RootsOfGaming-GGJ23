extends KinematicBody

signal destroyed

func pick_up():
	emit_signal("destroyed")
	$ColliderCoin.disabled = true
	queue_free()
