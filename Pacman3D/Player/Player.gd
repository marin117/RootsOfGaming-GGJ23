extends KinematicBody

var speed = 8
var velocity = Vector3.ZERO

var camGlobal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var is_moving = false
	var dir = Vector3.ZERO
	camGlobal = $Pivot/CameraFollow.global_transform
	if Input.is_action_pressed("forward"):
		dir -= camGlobal.basis[2]
		is_moving = true
	if Input.is_action_pressed("back"):
		dir += camGlobal.basis[2]
		is_moving = true
	if Input.is_action_pressed("left"):
		dir -= camGlobal.basis[0]
		is_moving = true
	if Input.is_action_pressed("right"):
		dir += camGlobal.basis[0]
		is_moving = true
	
	dir = dir.normalized()
	velocity.x = dir.x * speed
	velocity.z = dir.z * speed

	velocity = move_and_slide(velocity, Vector3.UP)
	
	if is_moving:
		var angle = atan2(velocity.x, velocity.z)
		rotation.y = angle


	
