extends Sprite

export var hp = 10
export var speed = 300
export var steer_force = 50
var velocity := Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null
var target_groups = ["environment", "player"]

func start(new_target) -> void:
	target = new_target

func seek() -> Vector2:
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _physics_process(delta: float) -> void:
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	position += velocity * delta

func take_damage(damage_value) -> void:
	hp -= damage_value
	if hp <= 0:
		explode()

func explode() -> void:
	queue_free()
