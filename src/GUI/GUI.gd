extends Control

onready var hp_bar = $StatusPanel/Status/Display/Fuel/HPBar
onready var upgrade_screen = $UpgradeScreen
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
signal upgrade_selected()
signal quit()

func update_hp(new_hp, max_hp) -> void:
	hp_bar.value = new_hp
	hp_bar.max_value = max_hp

func update_xp(xp, max_xp, level) -> void:
	print(xp, max_xp, level)

func update_coins(new_value: int) -> void:
	print(new_value)

func _on_PauseScreen_quit() -> void:
	emit_signal("quit")

func activate_death() -> void:
	$PauseScreen.activate_death()

func activate_end() -> void:
	$PauseScreen.activate_end()

func _on_LevelUp_pressed() -> void:
	upgrade_screen.activate()

func _on_UpgradeScreen_upgrade_selected() -> void:
	emit_signal("upgrade_selected")


func _on_Settings_pressed() -> void:
	$PauseScreen.activate()
