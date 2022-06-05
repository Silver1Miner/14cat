extends Area2D

export var pickup_id := 0
export var FCT: PackedScene = preload("res://src/World/Effects/FCT.tscn")

func _ready() -> void:
	add_to_group("pickup")

func _process(delta: float) -> void:
	position.y += 20 * delta
	if position.y > 720:
		queue_free()
