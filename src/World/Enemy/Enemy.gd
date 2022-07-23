extends KinematicBody2D
class_name Enemy

export var group = "enemy"
export var enemy_type := "i"
export var max_hp := 20.0
export var hp := 20.0 setget _set_hp
export var weaknesses = []
var moving := true
var velocity := Vector2.ZERO
export var speed := 100
export var attack := 50
var invulnerable = false
var active = true
export var Explosion: PackedScene = preload("res://src/World/Effects/Explosion.tscn")
export var FCT: PackedScene = preload("res://src/World/Effects/FCT.tscn")
export var Drop: PackedScene = preload("res://src/World/Pickups/Pickup.tscn")
onready var damage_timer = $DamageTimer
onready var hitbox = $Hitbox
onready var effects = get_parent().get_parent().get_node_or_null("Effects")
onready var player = get_parent().get_parent().get_node_or_null("Player")
onready var navigator = get_parent().get_parent().get_node_or_null("Navigation2D")
var target_position := Vector2.ZERO
var direction := Vector2.ZERO
var path := PoolVector2Array() setget set_path
signal destroyed()

func _ready() -> void:
	add_to_group(group)
	hitbox.add_to_group(group)
	find_target()

func find_target() -> void:
	if player and navigator:
		target_position = player.position
		direction = (target_position - position).normalized()
		set_path(navigator.get_simple_path(position, target_position))
	else:
		print("no target")

func set_path(value: PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	moving = true

var move_accumulated = 0
var cooldown = 0.5
func _physics_process(delta: float) -> void:
	if active:
		if moving:
			var move_distance := speed * delta
			move_along_path(move_distance)
			move_accumulated += delta
			if move_accumulated > cooldown:
				find_target()
				move_accumulated = 0
		attack_damage(delta)

func move_along_path(distance: float) -> void:
	var start_point = position
	for _i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance > 0.0:
			#position = start_point.linear_interpolate(path[0], distance/distance_to_next)
			velocity = (path[0]-start_point).normalized() * speed + Vector2(0,20)
			velocity = move_and_slide(velocity)
			look_at(path[0])
			break
		elif distance < 0.0:
			position = path[0]
			moving = false
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func attack_damage(delta: float) -> void:
	for a in $Hitbox.get_overlapping_areas():
		if a.is_in_group("player"):
			a.get_parent()._set_hp(a.get_parent().hp - attack * delta)

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
	emit_signal("destroyed")
	queue_free()

func create_explosion() -> void:
	var explosion_instance = Explosion.instance()
	effects.call_deferred("add_child", explosion_instance)
	explosion_instance.global_position = get_global_position()

func _on_DamageTimer_timeout() -> void:
	invulnerable = false
