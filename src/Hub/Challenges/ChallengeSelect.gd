extends Control

var e = 1
var m = 1
var max_e = 3
onready var episode = $Buttons/Label
onready var miss1 = $Buttons/Mission1
onready var miss2 = $Buttons/Mission2
onready var miss3 = $Buttons/Mission3
signal go_to_challenge(e, m)
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")

func _ready() -> void:
	update_page()

var challenge_names := ["",
"","","",
"","","",
"","","",]
func update_page() -> void:
	episode.text = "Episode " + str(e)
	miss1.update_display("e" + str(e) + "m1", PlayerData.challenge_records[(e-1)*3+1])
	miss2.update_display("e" + str(e) + "m2", PlayerData.challenge_records[(e-1)*3+2])
	miss3.update_display("e" + str(e) + "m3", PlayerData.challenge_records[(e-1)*3+3])
	miss1.disabled = PlayerData.challenges_unlocked < (e-1)*3 + 1
	miss2.disabled = PlayerData.challenges_unlocked < (e-1)*3 + 2
	miss3.disabled = PlayerData.challenges_unlocked < (e-1)*3 + 3

func _on_Close_pressed() -> void:
	visible = false

func go_to_challenge() -> void:
	emit_signal("go_to_challenge", e, m)

func _on_Mission1_pressed() -> void:
	m = 1
	go_to_challenge()

func _on_Mission2_pressed() -> void:
	m = 2
	go_to_challenge()

func _on_Mission3_pressed() -> void:
	m = 3
	go_to_challenge()

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
