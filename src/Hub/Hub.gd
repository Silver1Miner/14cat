extends Control

onready var Game = get_tree().get_root().get_node("Game")
onready var Music = Game.get_node("Music")
onready var challenge_select = $ChallengeSelect
export var hub_theme = preload("res://assets/Audio/music/inspiring-emotional-uplifting-piano-112623.mp3")

onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")

func _ready() -> void:
	if Music.stream != hub_theme:
		Music.stream = hub_theme
		Music.play()
	challenge_select.visible = false

func _on_Back_pressed() -> void:
	Game.go_to_scene("res://src/Menus/MainMenu.tscn")

func _on_ChallengeSelect_go_to_challenge(e, m) -> void:
	print("challenge e",e,"m",m)
	Game.go_to_scene("res://src/World/Board/Board.tscn")

func _on_Campaign_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Campaign/MissionSelect.tscn")

func _on_Challenges_pressed() -> void:
	challenge_select.visible = true

func _on_Library_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Library/Library.tscn")

func _on_Shop_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Shop/Shop.tscn")

func _on_Loadout_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Loadout/Loadout.tscn")
