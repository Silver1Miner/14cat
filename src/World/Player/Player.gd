extends KinematicBody2D

export var hp := 100.0 setget _set_hp
export var max_hp := 100.0
export var xp := 0
export var max_xp := 2
export var speed := 100
var target_position = null
var velocity := Vector2.ZERO
var active := true
var invincible = false

signal hp_changed(hp, max_hp)
signal player_died()
onready var damage_timer = $DamageTimer
onready var hitbox = $HitBox
onready var gun1 = $Pivot/GunTurret
onready var gun2 = $Pivot/GunTurret2
onready var gun3 = $Pivot/GunTurret3
onready var gun4 = $Pivot/GunTurret4
onready var pivot = $Pivot
onready var PlayerData = get_tree().get_root().get_node("Game").get_node("PlayerData")

func _ready() -> void:
	PlayerData.current_level = 1
	if PlayerData.connect("player_upgraded", self, "_on_player_upgraded") != OK:
		push_error("player upgrade signal connect fail")
	_on_player_upgraded()
	emit_signal("hp_changed", hp, max_hp)
	add_to_group("player")
	hitbox.add_to_group("player")

func _input(event: InputEvent) -> void:
	if not active:
		return
	if event.is_action_pressed('click'):
		if event.position.y > 80 and event.position.y < 640 - 80:
			target_position = event.position

func get_input() -> void:
	if not active:
		return
	if not target_position:
		velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		target_position = null
		velocity.x += 1
	elif Input.is_action_pressed('ui_left'):
		target_position = null
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		target_position = null
		velocity.y += 1
	elif Input.is_action_pressed('ui_up'):
		target_position = null
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	if velocity != Vector2.ZERO:
		$Sprite.rotation = velocity.angle() + PI/2

func _physics_process(_delta: float) -> void:
	if not active:
		return
	if target_position:
		$Sprite.look_at(target_position)
		velocity = $Sprite.transform.x * speed/2
		if position.distance_to(target_position) > 5:
			velocity = move_and_slide(velocity)
	if active:
		get_input()
		velocity = move_and_slide(velocity)
		if position.x < 0 + 32:
			position.x = 0 + 32
		if position.x > 360 - 32:
			position.x = 360 - 32
		if position.y < 0 + 32:
			position.y = 0 + 32
		if position.y > (640 - 80) + 32:
			position.y = (640 - 80) + 32

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
	active = false
	emit_signal("player_died")

func increase_xp(xp_amount: int) -> void:
	xp += xp_amount
	print(xp)
	PlayerData.total_xp += xp_amount

func _on_player_upgraded() -> void:
	gun1.update_level()
	gun2.update_level()
	gun3.update_level()
	gun4.update_level()
	emit_signal("hp_changed", hp, max_hp)

func _on_PickupBox_area_entered(area: Area2D) -> void:
	if area.is_in_group("pickup"):
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
