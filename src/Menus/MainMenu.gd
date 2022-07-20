extends Control

onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
onready var quit_button = $Quit
var nonquit = ["Android", "iOS", "HTML5"]

func _ready() -> void:
	if OS.get_name() in nonquit:
		quit_button.visible = false
	$SettingsMenu.visible = false
	$MissionMenu.visible = false

func _on_Options_pressed() -> void:
	$SettingsMenu.visible = true

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _on_Start_pressed() -> void:
	$MissionMenu.visible = true

func _on_Store_pressed() -> void:
	pass # Replace with function body.

func _on_Home_pressed() -> void:
	$SettingsMenu.visible = false
	$MissionMenu.visible = false

func _on_Trophies_pressed() -> void:
	print("go to trophy room")

func _on_Slots_pressed() -> void:
	print("go to slots")
