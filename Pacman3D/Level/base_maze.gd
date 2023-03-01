extends Node

const Util = preload("res://Utils/utils.gd")
export(PackedScene) var coin_scene = preload("res://Coin/Coin.tscn")

class_name BaseMaze

var coin_path
export var num_coins = 50
var environment
var ghost_spawn_location
var level

func generate_coins():
	var coins = Util.linspace(0, 1, num_coins)
	for _i in coins:
		coin_path.unit_offset = _i
		spawn_coin(coin_path.translation)

func spawn_coin(location):
	var coin = coin_scene.instance()
	coin.translate(location)
	coin.scale_object_local(Vector3(0.4, 0.4, 0.4))
	coin.connect("destroyed", self, "_on_Player_coin_pick")
	add_child(coin)

func _on_Player_coin_pick():
	num_coins -= 1
	if num_coins == 0:
		get_tree().change_scene("res://Win/WinScene.tscn")

func toggle_fog(is_enabled):
	environment.fog_enabled = is_enabled
