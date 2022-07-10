extends KinematicBody2D

export var hp := 100.0 setget _set_hp
export var max_hp := 100.0
export var xp := 0
export var max_xp := 2
export var speed := 100
var velocity := Vector2.ZERO
var active := true
var weapon_rotation := false
var invincible = false

signal hp_changed(hp, max_hp)
signal xp_changed(xp, max_xp, level)
signal max_xp_reached()
signal level_up()
signal coins_changed()
signal player_died()
onready var damage_timer = $DamageTimer
onready var hitbox = $HitBox
onready var gun2 = $Pivot/GunTurretFireball
onready var gun3 = $Pivot/GunTurretBolt
onready var gun4 = $Pivot/GunTurretScatter
onready var gun5 = $Pivot/GunTurretHoming
onready var pivot = $Pivot
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")

func _ready() -> void:
	PlayerData.current_level = 1
	if PlayerData.connect("player_upgraded", self, "_on_player_upgraded") != OK:
		push_error("player upgrade signal connect fail")
	_on_player_upgraded()
	emit_signal("hp_changed", hp, max_hp)
	emit_signal("coins_changed")
	add_to_group("player")
	hitbox.add_to_group("player")

func get_input() -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _process(delta: float) -> void:
	if weapon_rotation:
		pivot.rotation += PI/4 * delta
		gun2.get_node("Aim").global_rotation = 0
		gun3.get_node("Aim").global_rotation = 0
		gun4.get_node("Aim").global_rotation = 0
		gun5.get_node("Aim").global_rotation = 0
	if active:
		get_input()
		var _collision = move_and_collide(velocity * delta)
		if position.x < 0 + 32:
			position.x = 0 + 32
		if position.x > 360 - 32:
			position.x = 360 - 32
		if position.y < 0 + 32:
			position.y = 0 + 32
		if position.y > (640 - 128 - 64) - 32:
			position.y = (640 - 128 - 64) - 32

func take_damage(damage_value: float) -> void:
	#if invincible:
	#	return
	_set_hp(hp - damage_value)
	#invincible = true
	#damage_timer.start()

func _set_hp(new_hp: float) -> void:
	if new_hp > hp:
		print("heal")
		# play heal animation/sound
	elif new_hp < hp:
		pass
		# play damage animation/sound
	hp = clamp(new_hp, 0.0, max_hp)
	emit_signal("hp_changed", hp, max_hp)
	if hp <= 0.0:
		player_death()

func player_death() -> void:
	emit_signal("player_died")
	#active = false

func increase_xp(xp_amount: int) -> void:
	xp += xp_amount
	PlayerData.total_xp += xp_amount
	if xp >= max_xp:
		emit_signal("max_xp_reached")
	emit_signal("xp_changed", xp, max_xp, PlayerData.current_level)

func level_up() -> void:
	PlayerData.current_level += 1
	emit_signal("level_up")
	xp -= max_xp
	max_xp = PlayerData.current_level * 3
	emit_signal("xp_changed", xp, max_xp, PlayerData.current_level)

func _on_player_upgraded() -> void:
	gun2.update_level()
	gun3.update_level()
	gun4.update_level()
	gun5.update_level()
	emit_signal("hp_changed", hp, max_hp)
	emit_signal("coins_changed")

func _on_PickupBox_area_entered(area: Area2D) -> void:
	if area.is_in_group("pickup"):
		if area.pickup_id == 0 and xp >= max_xp:
			return
		area.activate(self)

func pickup_effect(pickup_id: int) -> void:
	match pickup_id:
		0: # xp gem
			increase_xp(1)
		1: # coin
			PlayerData.total_coins += 1
			PlayerData.current_coins += 1
			PlayerData.mission_coins += 1
			emit_signal("coins_changed")
	#print("picked up ", pickup_id)

func _on_DamageTimer_timeout() -> void:
	invincible = false
