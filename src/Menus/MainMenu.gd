extends Control

func _ready() -> void:
	$SettingsMenu.visible = false

func _on_Start_pressed() -> void:
	pass

func _on_Options_pressed() -> void:
	$SettingsMenu.visible = true

