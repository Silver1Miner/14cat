extends ColorRect

signal quit()

func activate() -> void:
	get_tree().paused = true
	visible = true

func activate_death() -> void:
	$Buttons/Close.visible = false
	activate()

func activate_end() -> void:
	$Buttons/Close.visible = false
	activate()

func _on_Close_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_Quit_pressed() -> void:
	#get_tree().paused = false
	emit_signal("quit")
