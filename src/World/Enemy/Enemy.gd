extends KinematicBody2D

export var max_hp = 20
export var hp = 20
export var speed := 100
export var direction := Vector2(2, 1)
var invincible = false
var entered_screen = false

func _ready() -> void:
	add_to_group("enemy")

func _physics_process(delta: float) -> void:
	if entered_screen:
		var velocity = speed * direction.normalized()
		var collision = move_and_collide(velocity * delta)
		if collision:
			direction.x = - direction.x
		if global_position.x < 32 or global_position.x > 360 - 32:
			direction.x = -direction.x

func _on_VisibilityNotifier2D_screen_entered() -> void:
	entered_screen = true
	invincible = false

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
