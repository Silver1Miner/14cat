extends Button

onready var title = $Info/Title
onready var trophy_icon = $Info/Records/TrophyIcon
onready var time_record = $Info/Records/Clock

func update_display(map_title: String, delta_time: float) -> void:
	title.text = map_title
	time_record.update_clock(delta_time)
	if delta_time >= 1800:
		trophy_icon.texture = preload("res://assets/GUI/Icons/star-gold.png")
	elif delta_time >= 1200:
		trophy_icon.texture = preload("res://assets/GUI/Icons/star.png")
	elif delta_time >= 600:
		trophy_icon.texture = preload("res://assets/GUI/Icons/star-bronze.png")
	else:
		trophy_icon.texture = null
