extends Control

onready var Game = get_tree().get_root().get_node("Game")

func _ready() -> void:
	pass

func _on_Back_pressed() -> void:
	visible = false

func _on_Start_pressed() -> void:
	$Start.disabled = true
	Game.go_to_scene("res://src/World/World.tscn")

