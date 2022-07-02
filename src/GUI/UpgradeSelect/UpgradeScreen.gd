extends ColorRect

onready var choices = $Choices
onready var choice1 = $Choices/Choice1
onready var choice2 = $Choices/Choice2
onready var choice3 = $Choices/Choice3
var available_upgrades = [0,1,2,3,4,5]
# 0 Coin 1 Colorless 2 Red 3 Yellow 4 Blue 5 Green
var Database: Resource = preload("res://data/database.tres")
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")

signal upgrade_selected()

func _ready() -> void:
	pass # Replace with function body.

func activate() -> void:
	prepare_upgrade_screen()
	visible = true
	get_tree().paused = true

func prepare_upgrade_screen() -> void:
	if len(available_upgrades) < 3:
		available_upgrades.append(0)
	randomize()
	available_upgrades.shuffle()
	choice1.populate_data(available_upgrades[0])
	choice2.populate_data(available_upgrades[1])
	choice3.populate_data(available_upgrades[2])
	choices.visible = true
	
func deactivate() -> void:
	get_tree().paused = false
	visible = false
	emit_signal("upgrade_selected")

func _on_Choice1_pressed() -> void:
	PlayerData.upgrade(choice1.upgrade_id)
	check_limits(choice1.upgrade_id)
	deactivate()

func _on_Choice2_pressed() -> void:
	PlayerData.upgrade(choice2.upgrade_id)
	check_limits(choice2.upgrade_id)
	deactivate()

func _on_Choice3_pressed() -> void:
	PlayerData.upgrade(choice3.upgrade_id)
	check_limits(choice3.upgrade_id)
	deactivate()

func check_limits(upgrade_id) -> void:
	if PlayerData.player_upgrades[upgrade_id] >= Database.upgrades[upgrade_id]["max_level"]:
		available_upgrades.erase(upgrade_id)
		print(Database.upgrades[upgrade_id]["name"] + " maxed out")
