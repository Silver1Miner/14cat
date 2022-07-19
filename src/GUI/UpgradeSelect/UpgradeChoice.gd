extends Button

var upgrade_id := 0
onready var title = $Info/Header/Title
onready var level = $Info/Header/Level
onready var description = $Info/Description
onready var upgrade_icon = $Info/Header/Icon
var Database: Resource = preload("res://data/database.tres")
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")

func populate_data(new_id) -> void:
	upgrade_id = new_id
	if upgrade_id in Database.upgrades:
		title.text = Database.upgrades[upgrade_id]["name"]
		var l = PlayerData.player_upgrades[upgrade_id]
		level.text = str(l+1)
		if l < Database.upgrades[upgrade_id]["descriptions"].size():
			description.text = Database.upgrades[upgrade_id]["descriptions"][l]
		else:
			description.text = Database.upgrades[upgrade_id]["descriptions"][0]
		upgrade_icon.set_texture(Database.upgrades[upgrade_id]["icon"])
