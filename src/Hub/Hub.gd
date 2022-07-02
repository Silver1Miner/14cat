extends Control

onready var Game = get_tree().get_root().get_node("Game")
onready var Music = Game.get_node("Music")
onready var survival_select = $SurvivalSelect
export var hub_theme = preload("res://assets/Audio/music/inspiring-emotional-uplifting-piano-112623.mp3")
var levels = preload("res://episodes/levels.tres")
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")

func _ready() -> void:
	if Music.stream != hub_theme:
		Music.stream = hub_theme
		Music.play()
	survival_select.visible = false

func _on_Back_pressed() -> void:
	Game.go_to_scene("res://src/Menus/MainMenu.tscn")

func _on_MissionSelect_go_to_mission(e, m) -> void:
	print("mission e",e,"m",m)
	PlayerData.is_survival = false
	Game.go_to_scene(levels.levels[e-1][m-1])

func _on_SurvivalSelect_go_to_survival(e, m) -> void:
	print("survival e",e,"m",m)
	PlayerData.is_survival = true
	Game.go_to_scene("res://src/World/World.tscn")

func _on_Campaign_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Campaign/MissionSelect.tscn")

func _on_Survival_pressed() -> void:
	survival_select.visible = true

func _on_Library_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Library/Library.tscn")

func _on_Shop_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Shop/Shop.tscn")

func _on_Loadout_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Loadout/Loadout.tscn")
