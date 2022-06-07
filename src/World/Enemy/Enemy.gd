extends KinematicBody2D

export var max_hp := 20.0
export var hp := 20.0 setget _set_hp
export var speed := 100
export var direction := Vector2(2, 1)
export var attack := 10
var invulnerable = false
var entered_screen = false

export var Explosion: PackedScene = preload("res://src/World/Effects/Explosion.tscn")
export var FCT: PackedScene = preload("res://src/World/Effects/FCT.tscn")

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
		attack_damage(delta)

func attack_damage(delta: float) -> void:
	for a in $Hitbox.get_overlapping_areas():
		if a.is_in_group("player"):
			a.set_hp(a.hp - attack * delta)

func _on_VisibilityNotifier2D_screen_entered() -> void:
	entered_screen = true
	invulnerable = false

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func take_damage(damage_value: float) -> void:
	if invulnerable:
		return
	var fct = FCT.instance()
	get_parent().add_child(fct)
	fct.rect_position = get_global_position() + Vector2(0, -16)
	fct.show_value(str(round(damage_value)), Vector2(0,-8), 1, PI/2)
	_set_hp(hp - damage_value)

func _set_hp(new_hp: float) -> void:
	hp = clamp(new_hp, 0.0, max_hp)
	if hp <= 0:
		die()

func die() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$Hitbox.set_deferred("disabled", true)
	create_explosion()
	queue_free()

func create_explosion() -> void:
	var explosion_instance = Explosion.instance()
	get_parent().call_deferred("add_child", explosion_instance)
	explosion_instance.global_position = get_global_position()
