extends Spatial

export var num_ghosts = 1

var is_chasing = false

export(PackedScene) var ghost_scene = preload("res://Ghost/Ghost.tscn")
var ghosts = []

func _ready():
	randomize()
	spawn_ghost()

func _process(_delta):
	if Input.is_action_just_released("camera"):
		$TopDownCamera.current = !$TopDownCamera.current
		$Player.switch_movement(!$TopDownCamera.current)
		$Level.toggle_fog(!$TopDownCamera.current)
		#$DirectionalLight.visible = $TopDownCamera.current
 
func spawn_ghost():
	var ghost = ghost_scene.instance()
	ghost.translate($Level.ghost_spawn_location)
	ghost.scale_object_local(Vector3(1.7,1.7,1.7))
	ghosts.append(ghost)
	ghost.connect("ghost_chasing", self, "add_chasing_ghost", [ghost])
	ghost.connect("ghost_wandering", self, "remove_chasing_ghost", [ghost])
	add_child(ghost)

func _on_Player_player_dead():
	get_tree().change_scene("res://Lose/LoseScreen.tscn")

func _on_GhostSpawnTimer_timeout():
	if ghosts.size() < 4:
		spawn_ghost()

func add_chasing_ghost(ghost):
	$Level.level.add_chasing_ghost(ghost)

func remove_chasing_ghost(ghost):
	$Level.level.remove_chasing_ghost(ghost)
