extends Node2D

export var random_spawning = false
export var spawn_schedule = ""
var spawning_finished = false
var units_added = 0
var units_removed = 0
onready var timer = $Timer

func spawn_wave(wave_schedule: String) -> void:
	for n in wave_schedule:
		print(n)
		if n.is_valid_float():
			timer.wait_time = float(n)
			timer.start()
			yield(timer, "timeout")
		else:
			spawn_enemy(n)
			units_added += 1
	spawning_finished = true
	print("wave finished")

func spawn_enemy(n: String) -> void:
	print(n)

func _on_unit_end_reached(damage) -> void:
	emit_signal("tower_damaged", damage)
	units_removed += 1
	check_if_wave_over()

func _on_unit_destroyed() -> void:
	emit_signal("unit_destroyed")
	units_removed += 1
	check_if_wave_over()

func check_if_wave_over() -> void:
	if spawning_finished and units_added == units_removed:
		emit_signal("wave_ended")

export (PackedScene) var Crab = preload("res://src/World/Enemy/Enemy.tscn")
var Database: Resource = preload("res://data/database.tres")
var random_spawn_schedule := {
	"max_level": 6,
	"spawn_limit": [10, 12, 14, 16, 18, 20],
	"spawn_points": [4, 4, 6, 8, 12, 12],
	"spawn_pace": [200, 150, 150, 100, 80, 60],
	"spawn_distribution": [
		[1, 9, 10, 10], # Crate, Base, Turret, Fast
		[1, 7, 9, 10],
		[1, 3, 7, 8],
		[1, 3, 5, 7],
		[1, 3, 4, 5],
		[1, 3, 4, 5],
	]
}
var spawn_level = 0
onready var spawn_points = $SpawnPoints

var spawn_accumulated = 0
func _process(_delta: float) -> void:
	if random_spawning:
		spawn_accumulated += 1
		if spawn_accumulated >= random_spawn_schedule["spawn_pace"][spawn_level]:
			random_spawner()

func random_spawner() -> void:
	if spawn_points.get_children().size() > 0 and \
	get_children().size() < random_spawn_schedule["spawn_limit"][spawn_level] + 1:
		randomize()
		var spawn_index = round(rand_range(0, spawn_points.get_children().size()-1))
		var spawn_position = spawn_points.get_children()[spawn_index]
		var spawn_choice = rand_range(0, 10)
		spawn_monster(spawn_position.position, spawn_choice)
	spawn_accumulated = 0

func spawn_monster(spawn_position, type) -> void:
	var monster
	if type < spawn_schedule["spawn_distribution"][spawn_level][0]:
		monster = Crab.instance()
	elif type < spawn_schedule["spawn_distribution"][spawn_level][1]:
		monster = Crab.instance()
	elif type < spawn_schedule["spawn_distribution"][spawn_level][2]:
			monster = Crab.instance()
	#elif type < spawn_schedule["spawn_distribution"][spawn_level][3]:
	else:
			monster = Crab.instance()
	monster.position = spawn_position
	add_child(monster)
