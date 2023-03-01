extends BaseMaze

func _ready():
	ghost_spawn_location = $GhostSpawn.transform.origin
	coin_path = get_node("CoinSpawn/CoinSpawnLocation")
	environment = $WorldEnvironment.get_environment()
	level = Level.new()
	add_child(level)
	generate_coins()
