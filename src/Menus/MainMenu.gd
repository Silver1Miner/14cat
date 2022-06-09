extends Control

onready var Game = get_tree().get_root().get_node("Game")

func _ready() -> void:
	$SettingsMenu.visible = false

func _on_Start_pressed() -> void:
	pass

func _on_Options_pressed() -> void:
	$SettingsMenu.visible = true

func _on_Survival_pressed() -> void:
	Game.go_to_scene("res://src/World/World.tscn")
