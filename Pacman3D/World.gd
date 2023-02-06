extends Spatial

export var num_coins_out = 50
export var num_coins_in = 20
export var num_ghosts = 1

var is_chasing = false
var music_position = 0
var music_position_1 = 0

var num_coins_total = num_coins_in + num_coins_out

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
	ghosts.append($Ghost)

func _process(delta):
	if Input.is_action_just_released("camera"):
		$Camera.current = !$Camera.current
		$Player.switch_movement(!$Camera.current)

func spawn_coin(location):
	var coin = coin_scene.instance()
	coin.translate(location)
	coin.scale_object_local(Vector3(0.5, 0.5, 0.5))
	add_child(coin)

func set_random_ghosts_location():
	var rand_dir = get_node("CoinSpawnOuter/CoinSpawnLocation")
	rand_dir.unit_offset = randi()
	return rand_dir.translation

func _on_GhostRandomTimer_timeout():
	for g in ghosts:
		if not g.is_chasing:
			g.update_target(set_random_ghosts_location())

func _on_Player_coin_pick():
	num_coins_total -= 1
	if num_coins_total == 0:
		get_tree().change_scene("res://WinScene/End.tscn")

func _on_GhostChaseTimer_timeout():
	for g in ghosts:
		if g.is_chasing:
			g.update_target($Player.global_transform.origin)

func _on_NewGhostTimer_timeout():
	$NewGhostTimer.stop()
	if ghosts.size() == 4:
		return
	#create_ghost()

func create_ghost():
	var ghost = ghost_scene.instance()
	ghost.translate(Vector3(0, 0 ,-4))
	ghost.scale_object_local(Vector3(2,2,2))
	ghosts.append(ghost)
	ghost.connect("chasing", ghost,
		"update_target" , [self.set_player_chasing_location()])
	ghost.connect("wandering", ghost,
		"update_target" , [self.random_movement()])
	add_child(ghost)

func set_player_chasing_location():
	return $Player.global_transform.origin

func random_movement():
	print("pocinjem random")
	return set_random_ghosts_location()
