extends Spatial

export var num_coins_out = 50
export var num_coins_in = 20
export var num_ghosts = 4

export(PackedScene) var coin_scene = preload("res://Coin/Coin.tscn")
export(PackedScene) var ghost_scene = preload("res://Ghost/Ghost.tscn")
var ghosts = []

func _ready():
	randomize()
	for i in range(num_coins_out):
		var coin_location = get_node("CoinSpawnOuter/CoinSpawnLocation")
		coin_location.unit_offset = randi()
		spawn_coin(coin_location.translation)
	
	for i in range(num_coins_in):
		var coin_location = get_node("CoinSpawnInner/CoinSpawnLocation")
		coin_location.unit_offset = randi()
		spawn_coin(coin_location.translation)
	
	for i in range(3):
		var ghost = ghost_scene.instance()
		ghost.translate(Vector3(0, 0 ,-4))
		ghost.scale_object_local(Vector3(2,2,2))
		ghosts.append(ghost)
		add_child(ghost)

func _process(delta):
	if Input.is_action_just_released("camera"):
		$Camera.current = !$Camera.current
		$Player.switch_movement(!$Camera.current)
	set_ghosts_chase()


func spawn_coin(location):
	var coin = coin_scene.instance()
	coin.add_to_group('Coins')
	coin.translate(location)
	coin.scale_object_local(Vector3(0.5, 0.5, 0.5))
	add_child(coin)

func set_random_ghosts_location():
	for g in ghosts:
		var rand_dir = get_node("CoinSpawnOuter/CoinSpawnLocation")
		rand_dir.unit_offset = randi()
		g.update_target(rand_dir.translation)

func set_ghosts_chase():
	for g in ghosts:
		g.update_target($Player.global_transform.origin)

func _on_Coin_destroyed():
	if get_tree().get_nodes_in_group("Coins").size() == 0:
		get_tree().change_scene("res://End.tscn")
