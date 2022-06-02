extends Control

func _ready() -> void:
	$AchievementsMenu.visible = false
	$SettingsMenu.visible = false

func _on_Start_pressed() -> void:
	pass # Replace with function body.

func _on_Achievements_pressed() -> void:
	$AchievementsMenu.visible = true

func _on_Options_pressed() -> void:
	$SettingsMenu.visible = true
