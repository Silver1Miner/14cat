extends Control

onready var Game = get_tree().get_root().get_node("Game")
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
onready var quit_button = $Options/Quit
var nonquit = ["Android", "iOS", "HTML5"]

func _ready() -> void:
	if OS.get_name() in nonquit:
		quit_button.visible = false
	$SettingsMenu.visible = false

func _on_Options_pressed() -> void:
	$SettingsMenu.visible = true

func _on_Survival_pressed() -> void:
	PlayerData.is_survival = true
	Game.go_to_scene("res://src/World/World.tscn")

func _on_Campaign_pressed() -> void:
	PlayerData.is_survival = false
	Game.go_to_scene("res://src/Hub/Hub.tscn")

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _on_Start_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Hub.tscn")
