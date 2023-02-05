extends KinematicBody

signal Coin_picked_up

var GRAVITY = -9.81

var speed = 8
var velocity = Vector3.ZERO

var is_moving = false
var moving_enabled = true

var camGlobal

func _ready():

	pass

func _physics_process(delta):
	handle_collision()
	move_and_rotate(delta)
	#$Pivot/CameraFollow.current = false

func move_direction():
	var dir = Vector3.ZERO
	is_moving = false
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
	return dir

func update_velocity(delta):
	var dir = move_direction().normalized()
	velocity.x = dir.x * speed
	velocity.z = dir.z * speed
	velocity.y = GRAVITY * delta

func update_position():
	velocity = move_and_slide(velocity, Vector3.UP)

func update_rotation():
	if is_moving:
		var angle = atan2(velocity.x, velocity.z)
		rotation.y = angle

func move_and_rotate(delta):
	if not moving_enabled:
		return
	update_velocity(delta)
	update_position()
	update_rotation()

func switch_movement(enabled):
	moving_enabled = enabled
	$Pivot/CameraFollow.current = moving_enabled
	
func handle_collision():
	for i in range(get_slide_count()):
		var obj = get_slide_collision(i)
		if obj.collider.is_in_group("coins"):
			var coin = obj.collider
			coin.pick_up()
			emit_signal("Coin_picked_up")
		elif obj.collider.is_in_group("enemies"):
			get_tree().change_scene("res://Loose.tscn")
			queue_free()
