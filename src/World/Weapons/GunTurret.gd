extends Node2D

export var gun_id := 1
export var damage_type := 0
export var direction :Vector2 = Vector2.UP
export var can_turn := true # true for turret, false for single direction
export var homing := false # whether fire homing bullet
export var instant := false
export var attack_damage := 10.0
export var attack_cooldown := 0.1
export var projectile_speed := 100.0
export var projectile_lifetime := 10.0
export var attack_radius := 20
export var projectile_blast_radius := 32
export var number_bullets := 1
export var offset := 15
export var bullet: PackedScene = preload("res://src/World/Weapons/Bullets/Bullet.tscn")

onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")
var current_level = -1
onready var _laser_sight := $Aim/Line2D
onready var _raycast = $Aim/RayCast2D
onready var _attack_radius := $Pivot/AttackRange
onready var _attack_range := $Pivot/AttackRange/CollisionShape2D
onready var _cooldown_timer := $Timer
onready var _bolt = $Aim/Bolt
onready var _bolt_timer = $Aim/Bolt/BoltTimer
var Database: Resource = preload("res://data/database.tres")

onready var effects = get_parent().get_parent().get_parent().get_node_or_null("Effects")

func _ready() -> void:
	_laser_sight.add_point(Vector2.ZERO)
	_laser_sight.add_point(Vector2.ZERO)
	_bolt.add_point(Vector2.ZERO)
	_bolt.add_point(Vector2.ZERO)

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
			shoot_at(null)
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
				shoot_at(target)
	else:
		_laser_sight.points[1] = Vector2.ZERO

func shoot_at(target) -> void:
	$AudioStreamPlayer2D.play()
	if instant:
		fire_bolt(target)
	else:
		var angle = _raycast.cast_to.angle()
		for n in range(number_bullets):
			var b1 = bullet.instance()
			fire_bullet(b1, n, angle, target)
			if n > 0 and (n * offset < 180):
				var b2 = bullet.instance()
				fire_bullet(b2, -n, angle, target)
	_cooldown_timer.start(attack_cooldown)

func fire_bolt(target) -> void:
	_bolt.points[1] = target.global_position - global_position
	if target.get_parent().has_method("take_damage"):
		target.get_parent().take_damage(attack_damage, damage_type)
	_bolt_timer.start(0.1)

func fire_bullet(b, n, angle, target) -> void:
	effects.add_child(b)
	b.speed = projectile_speed
	b.lifetime = projectile_lifetime
	b.damage = attack_damage
	b.global_position = global_position
	b.damage_type = damage_type
	b.rotation = angle + (n*deg2rad(offset))
	b.direction = direction.rotated(angle+PI/2+(n*deg2rad(offset)))
	if homing:
		b.aim_at(target)


func _on_BoltTimer_timeout() -> void:
	_bolt.points[1] = Vector2.ZERO
