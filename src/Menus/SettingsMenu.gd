extends Control

var start = false

func _ready() -> void:
	$Settings/Confirm.disabled = true
	$Settings/AudioSettings/MusicVolume.set_value(0.4)
	$Settings/AudioSettings/SoundVolume.set_value(0.4)
	start = true

func _on_MusicVolume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"), linear2db(value)
	)

func _on_SoundVolume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Sound"), linear2db(value)
	)
	if start:
		$AudioStreamPlayer.play(0)

func _on_SetDeletion_toggled(button_pressed: bool) -> void:
	$Settings/Confirm.disabled = !button_pressed

func _on_Confirm_pressed() -> void:
	$Settings/SetDeletion.pressed = false

func _on_Cancel_pressed() -> void:
	visible = false





