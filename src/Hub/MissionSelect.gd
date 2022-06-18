extends Control

var e = 1
var m = 1
var max_e = 2
onready var episode = $Buttons/Label
onready var miss1 = $Buttons/Mission1
onready var miss2 = $Buttons/Mission2
onready var miss3 = $Buttons/Mission3
onready var miss4 = $Buttons/Mission4
onready var miss5 = $Buttons/Mission5

signal go_to_mission(e, m)

func _ready() -> void:
	update_page()

func update_page() -> void:
	episode.text = "Episode " + str(e)
	miss1.text = "e" + str(e) + "m1"
	miss2.text = "e" + str(e) + "m2"
	miss3.text = "e" + str(e) + "m3"
	miss4.text = "e" + str(e) + "m4"
	miss5.text = "e" + str(e) + "m5"
	miss1.disabled = PlayerData.levels_unlocked < (e-1)*5 + 1
	miss2.disabled = PlayerData.levels_unlocked < (e-1)*5 + 2
	miss3.disabled = PlayerData.levels_unlocked < (e-1)*5 + 3
	miss4.disabled = PlayerData.levels_unlocked < (e-1)*5 + 4
	miss5.disabled = PlayerData.levels_unlocked < (e-1)*5 + 5

func _on_Close_pressed() -> void:
	visible = false

func _on_Mission1_pressed() -> void:
	m = 1
	go_to_mission()

func _on_Mission2_pressed() -> void:
	m = 2
	go_to_mission()

func _on_Mission3_pressed() -> void:
	m = 3
	go_to_mission()

func _on_Mission4_pressed() -> void:
	m = 4
	go_to_mission()

func _on_Mission5_pressed() -> void:
	m = 4
	go_to_mission()

func _on_Left_pressed() -> void:
	e -= 1
	if e <= 0:
		e = max_e
	update_page()

func _on_Right_pressed() -> void:
	e += 1
	if e > max_e:
		e = 1
	update_page()

func go_to_mission() -> void:
	emit_signal("go_to_mission", e, m)
