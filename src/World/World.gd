extends Node2D

onready var Game = get_tree().get_root().get_node("Game")
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
onready var Music = get_tree().get_root().get_node("Game").get_node("Music")
export var world_theme = preload("res://assets/Audio/music/classical-piano-by-alkan-saltarelo-112514.mp3")
onready var gui = $UI/GUI
onready var player = $Player
onready var spawner = $EnemySpawner
var enemy_count = {}

func _ready() -> void:
	enemy_count.clear()
	Music.stream = world_theme
	Music.play()
	parse_wave("i1,1,i3,1,i6,0.5,i2")
	if gui:
		gui.update_spawn_status(enemy_count)
	spawner.spawn_wave("i1,1,i3,1,i6,0.5,i2")

func _on_Player_hp_changed(hp, max_hp) -> void:
	if gui:
		gui.update_hp(hp, max_hp)

func _on_Player_player_died() -> void:
	if gui:
		gui.activate_death()

func _on_GUI_quit() -> void:
	PlayerData.fresh_restart()
	Game.go_to_scene("res://src/Menus/MainMenu.tscn")

func _on_EnemySpawner_wave_defeated() -> void:
	yield(get_tree().create_timer(0.5), "timeout")
	player.active = false
	for n in $Effects.get_children():
		if n.is_in_group("pickup"):
			n.activate(player)
	yield(get_tree().create_timer(1.0), "timeout")
	if gui:
		gui.activate_victory()
	print("wave defeated, player victory")

func parse_wave(wave_schedule: String) -> void:
	var schedule = wave_schedule.split(",")
	for n in schedule:
		print(n)
		if n.is_valid_float():
			pass
		else:
			if len(n) > 2:
				push_error("invalid data")
			if len(n) == 1:
				if n in enemy_count:
					enemy_count[n] += 1
				else:
					enemy_count[n] = 1
			else:
				if n[0] in enemy_count:
					enemy_count[n[0]] += int(n[1])
				else:
					enemy_count[n[0]] = int(n[1])

func _on_EnemySpawner_unit_destroyed(enemy_type: String, max_hp: float) -> void:
	if enemy_type in enemy_count:
		enemy_count[enemy_type] -= 1
	gui.update_spawn_status(enemy_count)
	gui.update_progress_bar(max_hp)
