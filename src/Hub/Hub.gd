extends Control

onready var Game = get_tree().get_root().get_node("Game")
onready var trophies = $Trophies
onready var mission_select = $MissionSelect
onready var survival_select = $SurvivalSelect
var levels = preload("res://episodes/levels.tres")

func _ready() -> void:
	trophies.visible = false
	mission_select.visible = false
	survival_select.visible = false

func _on_Back_pressed() -> void:
	Game.go_to_scene("res://src/Menus/MainMenu.tscn")

func _on_Trophies_pressed() -> void:
	trophies.update_trophies()

func _on_MissionSelect_go_to_mission(e, m) -> void:
	print("mission e",e,"m",m)
	PlayerData.is_survival = false
	Game.go_to_scene(levels.levels[e-1][m-1])

func _on_SurvivalSelect_go_to_survival(e, m) -> void:
	print("survival e",e,"m",m)
	PlayerData.is_survival = true
	Game.go_to_scene("res://src/World/World.tscn")

func _on_Campaign_pressed() -> void:
	mission_select.visible = true

func _on_Survival_pressed() -> void:
	survival_select.visible = true
