extends ColorRect

func _ready() -> void:
	pass # Replace with function body.

func activate() -> void:
	get_tree().paused = true
	visible = true

func _on_Close_pressed() -> void:
	get_tree().paused = false
	visible = false
