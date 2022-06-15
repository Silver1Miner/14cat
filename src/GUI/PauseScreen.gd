extends ColorRect

signal quit_early()

func activate() -> void:
	get_tree().paused = true
	visible = true

func _on_Close_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_Quit_pressed() -> void:
	get_tree().paused = false
	emit_signal("quit_early")
