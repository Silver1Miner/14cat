extends Control

onready var Game = get_tree().get_root().get_node("Game")
onready var trophies = $Trophies
onready var mission_select = $MissionSelect

func _ready() -> void:
	trophies.visible = false
	mission_select.visible = false

func _on_Back_pressed() -> void:
	Game.go_to_scene("res://src/Menus/MainMenu.tscn")

func _on_Trophies_pressed() -> void:
	trophies.update_trophies()

func _on_SelectMission_pressed() -> void:
	mission_select.visible = true

func _on_MissionSelect_go_to_mission(e, m) -> void:
	print("e",e,"m",m)
	Game.go_to_scene("res://src/World/World.tscn")
