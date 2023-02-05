extends Spatial

export var num_coins_out = 50
export var num_coins_in = 20

export(PackedScene) var coin_scene = preload("res://Coin/Coin.tscn")

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

func _process(delta):
	if Input.is_action_just_released("camera"):
		$Camera.current = !$Camera.current
		$Player.switch_movement(!$Camera.current)

func spawn_coin(location):
	var coin = coin_scene.instance()
	coin.translate(location)
	coin.scale_object_local(Vector3(0.5, 0.5, 0.5))
	add_child(coin)
