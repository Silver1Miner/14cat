extends Control

var e = 1
var m = 1
var max_e = 2
onready var Game = get_tree().get_root().get_node("Game")
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
onready var e1 = $E1
onready var e2 = $E2
onready var e3 = $E3
onready var e1m1 = $E1/E1M1
onready var e1m2 = $E1/E1M2
onready var e1m3 = $E1/E1M3
onready var e1m4 = $E1/E1M4
onready var e1m5 = $E1/E1M5
onready var e2m1 = $E2/E2M1
onready var e2m2 = $E2/E2M2
onready var e2m3 = $E2/E2M3
onready var e2m4 = $E2/E2M4
onready var e2m5 = $E2/E2M5
onready var e3m1 = $E3/E3M1
onready var e3m2 = $E3/E3M2
onready var e3m3 = $E3/E3M3
onready var e3m4 = $E3/E3M4
onready var e3m5 = $E3/E3M5
var levels = [
	["res://episodes/ep1/e1m1.tscn"],
	[],
	[],
]


func _ready() -> void:
	if e1m1.connect("pressed", self, "_on_Mission1_pressed") != OK: push_error("button connect fail")
	if e1m2.connect("pressed", self, "_on_Mission2_pressed") != OK: push_error("button connect fail")
	if e1m3.connect("pressed", self, "_on_Mission3_pressed") != OK: push_error("button connect fail")
	if e1m4.connect("pressed", self, "_on_Mission4_pressed") != OK: push_error("button connect fail")
	if e1m5.connect("pressed", self, "_on_Mission5_pressed") != OK: push_error("button connect fail")
	if e2m1.connect("pressed", self, "_on_Mission1_pressed") != OK: push_error("button connect fail")
	if e2m2.connect("pressed", self, "_on_Mission2_pressed") != OK: push_error("button connect fail")
	if e2m3.connect("pressed", self, "_on_Mission3_pressed") != OK: push_error("button connect fail")
	if e2m4.connect("pressed", self, "_on_Mission4_pressed") != OK: push_error("button connect fail")
	if e2m5.connect("pressed", self, "_on_Mission5_pressed") != OK: push_error("button connect fail")
	if e3m1.connect("pressed", self, "_on_Mission1_pressed") != OK: push_error("button connect fail")
	if e3m2.connect("pressed", self, "_on_Mission2_pressed") != OK: push_error("button connect fail")
	if e3m3.connect("pressed", self, "_on_Mission3_pressed") != OK: push_error("button connect fail")
	if e3m4.connect("pressed", self, "_on_Mission4_pressed") != OK: push_error("button connect fail")
	if e3m5.connect("pressed", self, "_on_Mission5_pressed") != OK: push_error("button connect fail")
	update_page()

func update_page() -> void:
	e1.visible = (e == 1)
	e2.visible = (e == 2)
	e3.visible = (e == 3)
	e1m1.disabled = PlayerData.levels_unlocked < 1
	e1m2.disabled = PlayerData.levels_unlocked < 2
	e1m3.disabled = PlayerData.levels_unlocked < 3
	e1m4.disabled = PlayerData.levels_unlocked < 4
	e1m5.disabled = PlayerData.levels_unlocked < 5
	e2m1.disabled = PlayerData.levels_unlocked < 6
	e2m2.disabled = PlayerData.levels_unlocked < 7
	e2m3.disabled = PlayerData.levels_unlocked < 8
	e2m4.disabled = PlayerData.levels_unlocked < 9
	e2m5.disabled = PlayerData.levels_unlocked < 10
	e3m1.disabled = PlayerData.levels_unlocked < 11
	e3m2.disabled = PlayerData.levels_unlocked < 12
	e3m3.disabled = PlayerData.levels_unlocked < 13
	e3m4.disabled = PlayerData.levels_unlocked < 14
	e3m5.disabled = PlayerData.levels_unlocked < 15

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
	print("mission e",e,"m",m)
	Game.go_to_scene(levels.levels[e-1][m-1])

func _on_Back_pressed() -> void:
	Game.go_to_scene("res://src/Hub/Hub.tscn")
