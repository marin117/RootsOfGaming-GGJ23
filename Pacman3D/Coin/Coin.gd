extends Area

signal destroyed

func pick_up():
	emit_signal("destroyed")
	queue_free()

func _physics_process(_delta):
	rotate_y(0.05)


func _on_Coin_body_entered(body):
	if body.is_in_group("player"):
		pick_up()
