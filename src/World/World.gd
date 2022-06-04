extends Node2D

onready var background = $BackgroundScroll

func _ready() -> void:
	background.set_background(preload("res://assets/Backgrounds/grass.png"))
