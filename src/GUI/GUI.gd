extends Control

onready var hp_bar = $Status/Status/Bars/HPDisplay/HPBar
onready var xp_bar = $Status/Status/Bars/ENDisplay/ENBar
onready var level_text = $Status/Status/Status/Level
onready var clock = $Status/Status/Status/Clock
onready var coins_text = $Status/Status/Status/Coins
onready var joystick = $Joypad
onready var upgrade_screen = $UpgradeScreen

func _ready() -> void:
	pass

func update_hp(new_hp, max_hp) -> void:
	hp_bar.value = new_hp
	hp_bar.max_value = max_hp

func update_xp(xp, max_xp, level) -> void:
	xp_bar.value = xp
	xp_bar.max_value = max_xp
	level_text.text = "Level: " + str(level)

func update_coins(new_value: int) -> void:
	coins_text.text = "Coins: " + str(new_value)

func update_clock(delta_time) -> void:
	clock.update_clock(delta_time)

func level_up() -> void:
	level_text.text = "Level: " + str(PlayerData.current_level)
	upgrade_screen.activate()
	joystick.reset()

func _on_Pause_pressed() -> void:
	$PauseScreen.activate()
