extends Control

onready var hp_bar = $Status/Status/Bars/HPDisplay/HPBar
onready var xp_bar = $Status/Status/Bars/ENDisplay/ENBar
onready var level_text = $Status/Status/Status/Level
onready var clock = $Status/Status/Status/Clock
onready var coins_text = $Status/Status/Status/Coins
onready var joystick = $Joypad
onready var upgrade_screen = $UpgradeScreen
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
onready var upgrade_button = $ControlPanel/Controls/LevelUp

signal upgrade_selected()
signal quit()

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
	joystick.reset()

func _on_Pause_pressed() -> void:
	$PauseScreen.activate()

func _on_PauseScreen_quit() -> void:
	emit_signal("quit")

func activate_death() -> void:
	$PauseScreen.activate_death()

func activate_end() -> void:
	$PauseScreen.activate_end()

func upgrade_available() -> void:
	upgrade_button.disabled = false

func _on_LevelUp_pressed() -> void:
	upgrade_screen.activate()
	upgrade_button.disabled = true

func _on_UpgradeScreen_upgrade_selected() -> void:
	emit_signal("upgrade_selected")
