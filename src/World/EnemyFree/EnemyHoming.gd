extends Enemy

export var steer_force = 50
var velocity := Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null
var target_groups = ["environment", "player"]

func _ready() -> void:
	add_to_group(group)
	if get_parent() and get_parent().get_parent():
		target = get_parent().get_parent().get_node("Player")
	print(target)

func seek() -> Vector2:
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func move_and_attack(delta: float) -> void:
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	position += velocity * delta
	attack_damage(delta)
