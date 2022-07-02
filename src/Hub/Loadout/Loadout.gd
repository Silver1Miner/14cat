extends Control

onready var Game = get_tree().get_root().get_node("Game")
onready var Music = Game.get_node("Music")

func _ready() -> void:
	pass

func _on_Back_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Hub.tscn")
