extends Button

onready var title = $Info/Records/Title
onready var run_count = $Info/Runs

func update_display(map_title: String, numbers_run: int) -> void:
	title.text = map_title
	run_count.text = "Runs: " + str(numbers_run)
