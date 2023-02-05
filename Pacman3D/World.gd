extends Spatial

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_released("camera"):
		$Camera.current = !$Camera.current
		$Player.switch_movement(!$Camera.current)
