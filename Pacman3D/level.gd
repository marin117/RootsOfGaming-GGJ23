extends Spatial

export var num_coins_out = 50
export var num_coins_in = 20
export var num_ghosts = 1

var is_chasing = false
var music_position = 0
var music_position_1 = 0

var player_pos_func

var num_coins_total = num_coins_in + num_coins_out

export(PackedScene) var coin_scene = preload("res://Coin/Coin.tscn")
export(PackedScene) var ghost_scene = preload("res://Ghost/Ghost.tscn")
var ghosts = []

func _ready():
	randomize()
	player_pos_func = funcref(self, "get_player_location")
	for _i in range(num_coins_out):
		var coin_location = get_node("CoinSpawnOuter/CoinSpawnLocation")
		coin_location.unit_offset = randi()
		spawn_coin(coin_location.translation)
	
	for _i in range(num_coins_in):
		var coin_location = get_node("CoinSpawnInner/CoinSpawnLocation")
		coin_location.unit_offset = randi()
		spawn_coin(coin_location.translation)
	spawn_ghost()

func _process(_delta):
	if Input.is_action_just_released("camera"):
		$Camera.current = !$Camera.current
		$Player.switch_movement(!$Camera.current)

func spawn_coin(location):
	var coin = coin_scene.instance()
	coin.translate(location)
	coin.scale_object_local(Vector3(0.5, 0.5, 0.5))
	coin.connect("destroyed", self, "_on_Player_coin_pick")
	add_child(coin)

func _on_Player_coin_pick():
	num_coins_total -= 1
	if num_coins_total == 0:
		get_tree().change_scene("res://Win/WinScene.tscn")

func spawn_ghost():
	var ghost = ghost_scene.instance()
	ghost.translate(Vector3(0, 0, -4))
	ghost.scale_object_local(Vector3(2,2,2))
	ghosts.append(ghost)
	add_child(ghost)


func _on_Player_player_dead():
	get_tree().change_scene("res://Lose/LoseScreen.tscn")
