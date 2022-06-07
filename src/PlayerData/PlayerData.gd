extends Node

var music_db := 0.4
var sound_db := 0.2
var delta_time := 0.0
var total_coins := 0
var current_coins := 0
var mission_coins := 0
var total_exp := 0
var current_level := 1
var highest_level := 1
var highest_time := 0.0
var lore_collected := 0
var max_lore_entries = 6
var player_upgrades := { #upgrade_id: level,
	0: 1, # Coin
	1: 1, # Forward Gun 1
	2: 0, # 
	3: 0, #
	4: 0, # 
	5: 0, #
}
var bought_upgrades := [ #upgrade_id: level,
	0, # Max Health Bonus
	0, # Regeneration Bonus
	0, # Damage Bonus
	0, # Critical Bonus
]
var achievements := [
	0,
	0,
	0,
	0,
]
var Database: Resource = preload("res://data/database.gd")
signal player_upgraded()

func _ready() -> void:
	#load_player_data()
	pass

func upgrade(upgrade_id: int) -> void:
	if upgrade_id < 0: # coin
		PlayerData.total_coins += 1
		PlayerData.current_coins += 1
		PlayerData.mission_coins += 1
	elif player_upgrades[upgrade_id] < Database.upgrades[upgrade_id]["max_level"]:
		player_upgrades[upgrade_id] += 1
	emit_signal("player_upgraded")

func load_player_data() -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://cat.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://cat.save", File.READ)
	achievements = parse_json(save_game.get_line())
	total_coins = parse_json(save_game.get_line())
	current_coins = parse_json(save_game.get_line())
	bought_upgrades = parse_json(save_game.get_line())
	total_exp = parse_json(save_game.get_line())
	highest_level = parse_json(save_game.get_line())
	highest_time = parse_json(save_game.get_line())
	lore_collected = parse_json(save_game.get_line())
	music_db = parse_json(save_game.get_line())
	sound_db = parse_json(save_game.get_line())
	save_game.close()

func save_player_data() -> void:
	var save_game = File.new()
	save_game.open("user://cat.save", File.WRITE)
	save_game.store_line(to_json(achievements))
	save_game.store_line(to_json(total_coins))
	save_game.store_line(to_json(current_coins))
	save_game.store_line(to_json(bought_upgrades))
	save_game.store_line(to_json(total_exp))
	save_game.store_line(to_json(highest_level))
	save_game.store_line(to_json(highest_time))
	save_game.store_line(to_json(lore_collected))
	save_game.store_line(to_json(music_db))
	save_game.store_line(to_json(sound_db))
	save_game.close()

func clear_player_data() -> void:
	total_coins = 0
	current_coins = 0
	mission_coins = 0
	bought_upgrades = [0,0,0,0]
	total_exp = 0
	highest_level = 1
	highest_time = 0.0
	lore_collected = 0
	var dir = Directory.new()
	dir.remove("user://cat.save")
