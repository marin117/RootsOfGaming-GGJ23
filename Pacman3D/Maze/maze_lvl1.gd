extends BaseMaze

func _ready():
	ghost_spawn_location = $GhostSpawn.transform.origin
	coin_path = get_node("CoinSpawn/CoinSpawnLocation")
	environment = $WorldEnvironment.get_environment()
	generate_coins()
