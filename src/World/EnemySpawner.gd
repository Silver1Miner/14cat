extends Node2D

export (PackedScene) var Crate = preload("res://src/World/Enemy/EnemyCrate.tscn")
export (PackedScene) var Crab = preload("res://src/World/Enemy/EnemyCrab.tscn")
export (PackedScene) var Turret = preload("res://src/World/Enemy/EnemyTurret.tscn")
export (PackedScene) var Fast = preload("res://src/World/Enemy/EnemyHoming.tscn")
var Database: Resource = preload("res://data/database.tres")
var spawn_schedule := {
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
	spawn_accumulated += 1
	if spawn_accumulated >= spawn_schedule["spawn_pace"][spawn_level]:
		spawner()

func spawner() -> void:
	if spawn_points.get_children().size() > 0 and \
	get_children().size() < spawn_schedule["spawn_limit"][spawn_level] + 1:
		randomize()
		var spawn_index = round(rand_range(0, spawn_points.get_children().size()-1))
		var spawn_position = spawn_points.get_children()[spawn_index]
		var spawn_choice = rand_range(0, 10)
		spawn_monster(spawn_position.position, spawn_choice)
	spawn_accumulated = 0

func spawn_monster(spawn_position, type) -> void:
	var monster
	if type < spawn_schedule["spawn_distribution"][spawn_level][0]:
		monster = Crate.instance()
	elif type < spawn_schedule["spawn_distribution"][spawn_level][1]:
		monster = Crab.instance()
	elif type < spawn_schedule["spawn_distribution"][spawn_level][2]:
			monster = Turret.instance()
	#elif type < spawn_schedule["spawn_distribution"][spawn_level][3]:
	else:
			monster = Fast.instance()
	monster.position = spawn_position
	add_child(monster)
