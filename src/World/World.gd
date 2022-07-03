extends Node2D

onready var Game = get_tree().get_root().get_node("Game")
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
onready var Music = get_tree().get_root().get_node("Game").get_node("Music")
export var world_theme = preload("res://assets/Audio/music/classical-piano-by-alkan-saltarelo-112514.mp3")
onready var background = $BackgroundScroll
onready var gui = $UI/GUI
onready var player = $Player
onready var spawner = $EnemySpawner

func _ready() -> void:
	get_tree().paused = false
	Music.stream = world_theme
	Music.play()
	spawner.set_process(PlayerData.is_challenge)
	background.set_background(preload("res://assets/Backgrounds/background.png"))
	if player.connect("hp_changed", self, "_on_Player_hp_changed") != OK:
		push_error("signal connect fail")
	if player.connect("xp_changed", self, "_on_Player_xp_changed") != OK:
		push_error("signal connect fail")
	if player.connect("coins_changed", self, "_on_Player_coins_changed") != OK:
		push_error("signal connect fail")
	if player.connect("max_xp_reached", self, "_on_Player_max_xp_reached") != OK:
		push_error("signal connect fail")
	if player.connect("level_up", self, "_on_Player_level_up") != OK:
		push_error("signal connect fail")
	if player.connect("player_died", self, "_on_Player_died") != OK:
		push_error("signal connect fail")
	if gui.connect("upgrade_selected", player, "level_up") != OK:
		push_error("signal connect fail")
	PlayerData.delta_time = 0.0

var timer_accumulated = 0
func _process(delta: float) -> void:
	PlayerData.delta_time += delta
	timer_accumulated += 1
	if timer_accumulated >= 60:
		gui.update_clock(PlayerData.delta_time)
		timer_accumulated = 0

func _on_Player_coins_changed() -> void:
	gui.update_coins(PlayerData.mission_coins)

func _on_Player_hp_changed(hp, max_hp) -> void:
	gui.update_hp(hp, max_hp)

func _on_Player_xp_changed(xp, max_xp, level) -> void:
	gui.update_xp(xp, max_xp, level)

func _on_Player_max_xp_reached() -> void:
	gui.upgrade_available()

func _on_Player_level_up() -> void:
	gui.level_up()

func _on_Player_died() -> void:
	gui.activate_death()

func _on_GUI_quit() -> void:
	get_tree().paused = false
	PlayerData.fresh_restart()
	Game.go_to_scene("res://src/Hub/Hub.tscn")

func _on_GUI_rotation_toggled(is_rotating) -> void:
	player.weapon_rotation = is_rotating

func _on_ExitEnd_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		gui.activate_end()
