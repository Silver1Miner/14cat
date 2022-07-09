extends Node2D

onready var Game = get_tree().get_root().get_node("Game")
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
onready var Music = get_tree().get_root().get_node("Game").get_node("Music")
onready var gui = $UI/GUI
onready var player = $Player

func _ready() -> void:
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
	get_tree().paused = false
	PlayerData.fresh_restart()
	Game.go_to_scene("res://src/Hub/Hub.tscn")
