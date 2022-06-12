extends Node2D

onready var background = $BackgroundScroll
onready var gui = $UI/GUI
onready var player = $Player

func _ready() -> void:
	background.set_background(preload("res://assets/Backgrounds/grass.png"))
	if player.connect("hp_changed", self, "_on_Player_hp_changed") != OK:
		push_error("signal connect fail")
	if player.connect("xp_changed", self, "_on_Player_xp_changed") != OK:
		push_error("signal connect fail")
	if player.connect("coins_changed", self, "_on_Player_coins_changed") != OK:
		push_error("signal connect fail")
	if player.connect("level_up", self, "_on_Player_level_up") != OK:
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

func _on_Player_level_up() -> void:
	gui.level_up()
