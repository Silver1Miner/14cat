extends Control

onready var hp_bar = $Status/Bars/HPDisplay/HPBar
onready var en_bar = $Status/Bars/ENDisplay/ENBar
onready var level_text = $Status/Bars/Status/Level
onready var clock = $Status/Bars/Clock
onready var joystick = $Joypad

func _ready() -> void:
	pass

func _on_Player_hp_changed(new_hp) -> void:
	hp_bar.value = new_hp

func _on_Player_en_changed(new_en) -> void:
	en_bar.value = new_en

func _on_Player_level_changed() -> void:
	level_text.text = "Level: " + str(PlayerData.current_level)
	joystick.reset()
