extends Area2D

export var pickup_id := 0
export var FCT: PackedScene = preload("res://src/World/Effects/FCT.tscn")
export var steer_force := 50.0
export var speed := 400
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null

func _ready() -> void:
	add_to_group("pickup")

func _process(delta: float) -> void:
	if target:
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(speed)
		#rotation = velocity.angle()
		position += velocity * delta
	else:
		position.y += 20 * delta
	if position.y > 720:
		queue_free()

func activate(new_target) -> void:
	target = new_target

func seek() -> Vector2:
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _on_Pickup_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.pickup_effect(pickup_id)
		queue_free()
