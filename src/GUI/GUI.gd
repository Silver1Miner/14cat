extends Control

onready var hp_bar = $StatusPanel/Status/CenterContainer2/Display/Fuel/HPBar
onready var prog_count = $StatusPanel/Status/CenterContainer2/Display/WaveLeft/WaveContents
onready var prog_bar = $StatusPanel/Status/CenterContainer2/Display/WaveProgress/ENBar
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
signal quit()

func _ready() -> void:
	$EndPanel.visible = false
	$ToolsPanel/PowerUps.visible = false
	$ToolsPanel/Settings.visible = false

func update_hp(new_hp, max_hp) -> void:
	hp_bar.value = new_hp
	hp_bar.max_value = max_hp

func update_spawn_status(counts: Dictionary) -> void:
	var count = ""
	for n in counts:
		count += n + "x" + str(counts[n]) + " "
	prog_count.text = count

func update_progress_bar(new_progress: float) -> void:
	prog_bar.value += new_progress

func activate_death() -> void:
	$EndPanel.visible = true

func activate_end() -> void:
	$EndPanel.visible = true

func activate_victory() -> void:
	$EndPanel.visible = true

func _on_Settings_toggled(button_pressed: bool) -> void:
	$ToolsPanel/Settings.visible = button_pressed
	$ToolsPanel/PowerUps.visible = false

func _on_UsePower_pressed() -> void:
	$ToolsPanel/PowerUps.visible = true

func _on_Back_pressed() -> void:
	$ToolsPanel/PowerUps.visible = false

func _on_Quit_pressed() -> void:
	$ToolsPanel/Settings/Options/Quit.disabled = true
	emit_signal("quit")

func _on_Continue_pressed() -> void:
	$EndPanel/Continue.disabled = true
	emit_signal("quit")
