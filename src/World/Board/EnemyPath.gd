extends TileMap

export var grid: Resource = preload("res://src/World/Board/Grid.tres")
onready var path = $Path2D
export var start_cell := Vector2(0, 0)
export var end_cell := Vector2(0, 0)

func _ready() -> void:
	find_line_cells()
	find_drawn_path()
	initialize_path(draw_path)

var line_cells = []
func find_line_cells() -> void:
	line_cells.clear()
	for x in 9:
		for y in 16:
			if get_cell(x, y) == 0:
				line_cells.append(Vector2(x, y))
	print(line_cells)

func initialize_path(path_cells: Array) -> void:
	path.curve.clear_points()
	for point in path_cells:
		path.curve.add_point(grid.get_map_position(point))

var draw_path = []
var dirs = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
func find_drawn_path() -> void:
	if get_cellv(start_cell) != 0:
		push_error("start cell not set correctly")
		return
	draw_path.clear()
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
