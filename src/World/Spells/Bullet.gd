extends Area2D

export var damage := 5.0
export var direction := Vector2.ZERO
var velocity := Vector2.ZERO
var acceleration = Vector2.ZERO
export var speed := 200.0
export var steer_force = 90000
export var lifetime := 1.0
export var piercing := false
export var homing := false
export var Explosion: PackedScene = preload("res://src/World/Effects/Explosion.tscn")
export var target_groups := [
	"enemy","environment"
]
export var damage_type := 0
var target = null

func _process(delta: float) -> void:
	if homing:
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(speed)
		rotation = velocity.angle()
		position += velocity * delta
	else:
		position += (delta * speed) * direction.normalized()

func aim_at(new_target) -> void:
	target = new_target

func seek() -> Vector2:
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _on_Timer_timeout() -> void:
	queue_free()

func _on_Bullet_area_entered(area: Area2D) -> void:
	for group in target_groups:
		if area.is_in_group(group):
			if area.get_parent().has_method("take_damage"):
				area.get_parent().take_damage(damage, damage_type)
				if !piercing:
					var explosion = Explosion.instance()
					explosion.damage = 0
					explosion.size_scale = 0.5
					explosion.global_position = global_position
					get_parent().call_deferred("add_child", explosion)
					queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
