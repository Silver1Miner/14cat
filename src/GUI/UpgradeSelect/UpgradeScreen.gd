extends ColorRect

onready var decide = $Decide
onready var choices = $Choices
onready var choice1 = $Choices/Choice1
onready var choice2 = $Choices/Choice2
onready var choice3 = $Choices/Choice3
var available_upgrades = [0,1,2,3,4,5]
var Database: Resource = preload("res://data/database.tres")

func _ready() -> void:
	pass # Replace with function body.

func activate() -> void:
	#decide.visible = false
	#choices.visible = true
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
	decide.visible = false
	choices.visible = true
	
func deactivate() -> void:
	get_tree().paused = false
	visible = false

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

func _on_Unleash_pressed() -> void:
	print("chose to unleash")
	deactivate()

func _on_Upgrade_pressed() -> void:
	print("chose to upgrade")
	prepare_upgrade_screen()
