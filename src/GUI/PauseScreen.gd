extends ColorRect

signal quit()

func activate() -> void:
	get_tree().paused = true
	visible = true

func activate_death() -> void:
	$Buttons/Quit.text = "Quit"
	$Buttons/Close.visible = false
	get_tree().paused = true
	visible = true

func _on_Close_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_Quit_pressed() -> void:
	get_tree().paused = false
	print("quit")
	emit_signal("quit")
