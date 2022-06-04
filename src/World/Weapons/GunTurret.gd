extends Node2D

export var gun_id := 0
export var can_turn := true
export var attack_damage := 4.0
export var attack_cooldown := 0.1
export var projectile_speed := 100.0
export var projectile_lifetime := 10.0
export var attack_radius := 20
export var projectile_blast_radius := 32

var current_level = -1
onready var _laser_sight := $Line2D
onready var _attack_radius := $AttackRange
onready var _raycast = $RayCast2D
onready var _cooldown_timer := $Timer
var Database: Resource = preload("res://data/database.tres")

func _ready() -> void:
	_laser_sight.add_point(Vector2.ZERO)
	_laser_sight.add_point(Vector2.ZERO)

func update_level(new_level: int) -> void:
	if visible:
		set_process(true)
	if visible and new_level != current_level:
		current_level = new_level
		print(new_level)

func _process(_delta: float) -> void:
	if not visible:
		return
	var targets: Array = _attack_radius.get_overlapping_areas()
	if targets.empty():
		_laser_sight.points[1] = Vector2.ZERO
		return
	var target = null
	if can_turn:
		for t in targets:
			if t.get_parent().is_in_group("enemy"):
				target = t
				break
	else:
		if _raycast.is_colliding():
			target = _raycast.get_collider()
	if target:
		if can_turn:
			$Sprite.look_at(target.global_position)
			_raycast.cast_to = target.global_position - global_position
			_raycast.force_raycast_update()
			_laser_sight.points[1] = target.global_position - global_position
		if target.get_parent() and _cooldown_timer.is_stopped():
			if target.get_global_position().y < (18 * 30) - 16 and \
			target.get_global_position().y > (4 * 30) + 16 and \
			target.get_global_position().x > 0 + 16 and \
			target.get_global_position().x < 360 - 16:
				shoot_at()
	else:
		_laser_sight.points[1] = Vector2.ZERO

func shoot_at() -> void:
	$AudioStreamPlayer2D.play()
	_cooldown_timer.start(attack_cooldown)
