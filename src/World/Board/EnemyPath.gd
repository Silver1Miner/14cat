extends Path2D

export var grid: Resource = preload("res://src/World/Board/Grid.tres")
onready var path = $Path2D
export var start_cell := Vector2(0, 0)
export var end_cell := Vector2(0, 0)

func _ready() -> void:
	pass

func initialize_path(path_cells: Array) -> void:
	path.curve.clear_points()
	for point in path_cells:
		path.curve.add_point(grid.get_map_position(point))
