extends TileMap

export var grid: Resource = preload("res://src/World/Board/Grid.tres")
onready var path = $Path2D
export var start_cell := Vector2(0, 0)
export var end_cell := Vector2(0, 0)
export var spawning = true
onready var timer = $Timer

signal unit_destroyed()
signal tower_damaged(damage)

func _ready() -> void:
	find_drawn_path()
	spawn_wave("i2i1i2i1i1i1i")

const dirs = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
func find_drawn_path() -> void:
	if get_cellv(start_cell) != 0:
		push_error("start cell not set correctly")
		return
	var draw_path = []
	draw_path.append(start_cell)
	var current_cell = start_cell
	var safety_counter = 0
	while safety_counter < 4:
		for dir in dirs:
			safety_counter += 1
			var next_cell = current_cell + dir
			if not next_cell in draw_path and get_cellv(next_cell) == 0:
				current_cell = next_cell
				draw_path.append(current_cell)
				safety_counter = 0
	print(draw_path)
	path.curve.clear_points()
	for point in draw_path:
		path.curve.add_point(grid.get_map_position(point))


func _on_Timer_timeout() -> void:
	pass # Replace with function body.

# wave_schedule format
# "i1i23i1"
func spawn_wave(wave_schedule: String) -> void:
	for n in wave_schedule:
		print(n)
		if n.is_valid_float():
			timer.wait_time = float(n)
			timer.start()
			yield(timer, "timeout")
		else:
			spawn_enemy(n)
	print("wave finished")

var infantry = preload("res://src/World/EnemyUnit/EnemyUnit.tscn")
func spawn_enemy(n: String) -> void:
	var unit_instance
	match n:
		"i":
			unit_instance = infantry.instance()
	unit_instance.position = grid.get_map_position(start_cell)
	if unit_instance.connect("end_reached", self, "_on_unit_end_reached") != OK:
		push_error("unit reaching end signal connect fail")
	if unit_instance.connect("unit_destroyed", self, "_on_unit_destroyed") != OK:
		push_error("unit destruction signal connect fail")
	path.add_child(unit_instance)
	unit_instance.walk()

func _on_unit_end_reached(damage) -> void:
	emit_signal("tower_damaged", damage)

func _on_unit_destroyed() -> void:
	emit_signal("unit_destroyed")
