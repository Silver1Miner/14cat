extends Node2D

onready var Game = get_tree().get_root().get_node("Game")
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
onready var Music = get_tree().get_root().get_node("Game").get_node("Music")
onready var gui = $UI/GUI
onready var player = $Player
onready var timer = $Timer
var units_destroyed = 0
var mini_waves_ended = 0
var total_mini_waves = 1
var wave_number = 0
var total_waves = 1

func _ready() -> void:
	get_tree().paused = false
	if player.connect("hp_changed", gui, "update_hp") != OK:
		push_error("signal connect fail")
	if player.connect("xp_changed", gui, "update_xp") != OK:
		push_error("signal connect fail")
	if player.connect("coins_changed", self, "_on_Player_coins_changed") != OK:
		push_error("signal connect fail")
	if player.connect("max_xp_reached", gui, "upgrade_available") != OK:
		push_error("signal connect fail")
	if player.connect("level_up", gui, "level_up") != OK:
		push_error("signal connect fail")
	if player.connect("player_died", gui, "activate_death") != OK:
		push_error("signal connect fail")
	if gui.connect("upgrade_selected", player, "level_up") != OK:
		push_error("signal connect fail")
	PlayerData.delta_time = 0.0

func _on_EnemyPath_tower_damaged(damage) -> void:
	print("tower damaged ", damage)
	player.take_damage(damage)

func _on_Player_coins_changed() -> void:
	gui.update_coins(PlayerData.mission_coins)

func _on_GUI_quit() -> void:
	PlayerData.fresh_restart()
	#get_tree().paused = false
	Game.go_to_scene("res://src/Hub/Hub.tscn")

func _on_EnemyPath_unit_destroyed() -> void:
	units_destroyed += 1

func _on_EnemyPath_wave_ended() -> void:
	mini_waves_ended += 1
	check_if_wave_over()

func check_if_wave_over() -> void:
	if mini_waves_ended == total_mini_waves:
		wave_number += 1
		timer.start(1)
		yield(timer, "timeout")
		print("wave over")
		if wave_number < total_waves:
			gui._on_LevelUp_pressed()
		else:
			print("level over")

func _on_GUI_upgrade_selected() -> void:
	print("start next wave")
