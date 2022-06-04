extends Control

func _ready() -> void:
	$AchievementsMenu.visible = false
	$SettingsMenu.visible = false
	$GameOptions.visible = false

func _on_Start_pressed() -> void:
	$GameOptions.visible = true
	$Options.visible = false

func _on_Achievements_pressed() -> void:
	$AchievementsMenu.visible = true

func _on_Options_pressed() -> void:
	$SettingsMenu.visible = true

func _on_Back_pressed() -> void:
	$GameOptions.visible = false
	$Options.visible = true
