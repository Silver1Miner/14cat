extends Node2D

export var gun_id := 1
export var damage_type := 0
export var direction :Vector2 = Vector2.UP
export var can_turn := true # true for turret, false for auto fire
export var attack_damage := 10.0
export var attack_cooldown := 0.1
export var projectile_speed := 100.0
export var projectile_lifetime := 10.0
export var attack_radius := 20
export var projectile_blast_radius := 32
export var bullet: PackedScene = preload("res://src/World/Weapons/Bullet.tscn")

var current_level = -1
onready var _laser_sight := $Aim/Line2D
onready var _raycast = $Aim/RayCast2D
onready var _attack_radius := $Pivot/AttackRange
onready var _attack_range := $Pivot/AttackRange/CollisionShape2D
onready var _cooldown_timer := $Timer
var Database: Resource = preload("res://data/database.tres")

onready var effects = get_parent().get_parent().get_parent().get_node_or_null("Effects")

func _ready() -> void:
	_laser_sight.add_point(Vector2.ZERO)
	_laser_sight.add_point(Vector2.ZERO)

func update_level() -> void:
	var new_level = PlayerData.player_upgrades[gun_id]
	if new_level != current_level:
		current_level = new_level
		visible = current_level > 0
		if current_level < len(Database.upgrades[gun_id]["damage"]):
			attack_damage = Database.upgrades[gun_id]["damage"][PlayerData.player_upgrades[gun_id]]
		if current_level < len(Database.upgrades[gun_id]["cooldown"]):
			attack_cooldown = Database.upgrades[gun_id]["cooldown"][PlayerData.player_upgrades[gun_id]]
		if current_level < len(Database.upgrades[gun_id]["attack_range"]):
			_attack_range.shape.radius = Database.upgrades[gun_id]["attack_range"][PlayerData.player_upgrades[gun_id]]
		print("upgrade ", Database.upgrades[gun_id]["name"], " to level ", new_level)
	if visible:
		set_process(true)

func _process(_delta: float) -> void:
	if not visible:
		return
	if !can_turn:
		if _cooldown_timer.is_stopped():
			shoot_at()
		return
	var targets: Array = _attack_radius.get_overlapping_areas()
	if targets.empty():
		_laser_sight.points[1] = Vector2.ZERO
		return
	var target = null
	for t in targets:
		if t.get_parent().is_in_group("enemy"):
			target = t
			break
	if target:
		$Sprite.look_at(target.global_position)
		_raycast.cast_to = target.global_position - global_position
		_raycast.force_raycast_update()
		_laser_sight.points[1] = target.global_position - global_position
		if target.get_parent() and _cooldown_timer.is_stopped():
			if target.get_global_position().y < (18 * 30) - 16 and \
			target.get_global_position().y > (1 * 30) + 16 and \
			target.get_global_position().x > 0 + 16 and \
			target.get_global_position().x < 360 - 16:
				shoot_at()
	else:
		_laser_sight.points[1] = Vector2.ZERO

func shoot_at() -> void:
	$AudioStreamPlayer2D.play()
	var bullet_instance = bullet.instance()
	effects.add_child(bullet_instance)
	bullet_instance.speed = projectile_speed
	bullet_instance.lifetime = projectile_lifetime
	bullet_instance.damage = attack_damage
	bullet_instance.global_position = global_position
	bullet_instance.damage_type = damage_type
	var angle = _raycast.cast_to.angle()
	bullet_instance.rotation = angle
	bullet_instance.direction = direction.rotated(deg2rad(angle))
	_cooldown_timer.start(attack_cooldown)
