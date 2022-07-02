extends Control

func _ready() -> void:
	pass

func update_trophies() -> void:
	# update trophy view
	visible = true

func _on_Close_pressed() -> void:
	visible = false
