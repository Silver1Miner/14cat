extends KinematicBody2D
class_name Enemy

export var group = "enemy"
export var max_hp := 20.0
export var hp := 20.0 setget _set_hp
export var y_limit_top := 64
export var y_limit_bottom := 256
export var ignore_collision = false
export var weaknesses = [3]
var hit_bottom = false
var hit_side = false
export var aim_at_player = false
export var speed := 100
export var direction := Vector2(2, 1)
export var attack := 50
var invulnerable = true
var entered_screen = false
var can_attack = false

export var Explosion: PackedScene = preload("res://src/World/Effects/Explosion.tscn")
export var FCT: PackedScene = preload("res://src/World/Effects/FCT.tscn")
export var Drop: PackedScene = preload("res://src/World/Pickups/Pickup.tscn")
onready var damage_timer = $DamageTimer
onready var attack_timer = $AttackTimer
onready var effects = get_parent().get_parent().get_node_or_null("Effects")
onready var player = get_parent().get_parent().get_node_or_null("Player")

func _ready() -> void:
	add_to_group(group)

func _physics_process(delta: float) -> void:
	if entered_screen:
		move_and_attack(delta)
	else:
		position.y += 30

func move_and_attack(delta: float) -> void:
	var velocity = speed * direction.normalized()
	var collision = move_and_collide(velocity * delta)
	if collision and not ignore_collision:
		direction.x = -direction.x
		if direction.y < 0:
			direction.y = -direction.y
	if global_position.x < 32 or global_position.x > 360 - 32:
		direction.x = -direction.x
	if hit_bottom and global_position.y <= y_limit_top and not ignore_collision:
		direction.y = -direction.y
	if global_position.y > y_limit_bottom:
		hit_bottom = true
		direction.y = -direction.y
	if aim_at_player:
		$Gun.look_at(player.global_position)
	shoot()
	#attack_damage(delta)

func attack_damage(delta: float) -> void:
	for a in $Hitbox.get_overlapping_areas():
		if a.is_in_group("player"):
			a.get_parent()._set_hp(a.get_parent().hp - attack * delta)

func shoot() -> void:
	if not can_attack:
		return
	print("shoot")
	# TODO: add shooting
	can_attack = false
	attack_timer.start()

func _on_VisibilityNotifier2D_screen_entered() -> void:
	entered_screen = true
	invulnerable = false
	can_attack = true

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func take_damage(damage_value: float, damage_type: int) -> void:
	if invulnerable:
		return
	var fct = FCT.instance()
	get_parent().add_child(fct)
	fct.rect_position = get_global_position() + Vector2(0, -16)
	#print(damage_value)
	#print(str(round(damage_value)))
	if damage_type in weaknesses:
		fct.show_value(str(round(damage_value * 3))+"!", Vector2(0,-8), 1, PI/2,true)
		_set_hp(hp - damage_value * 3)
	else:
		fct.show_value(str(round(damage_value)), Vector2(0,-8), 1, PI/2)
		_set_hp(hp - damage_value)
	damage_timer.wait_time = 0.05
	damage_timer.start()

func _set_hp(new_hp: float) -> void:
	hp = clamp(new_hp, 0.0, max_hp)
	if hp <= 0:
		die()

func die() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$Hitbox.set_deferred("disabled", true)
	create_explosion()
	var drop_instance = Drop.instance()
	effects.call_deferred("add_child", drop_instance)
	drop_instance.global_position = get_global_position()
	queue_free()

func create_explosion() -> void:
	var explosion_instance = Explosion.instance()
	effects.call_deferred("add_child", explosion_instance)
	explosion_instance.global_position = get_global_position()

func _on_DamageTimer_timeout() -> void:
	invulnerable = false

func _on_AttackTimer_timeout() -> void:
	can_attack = true
