extends PathFollow2D

export var grid: Resource = preload("res://src/World/Board/Grid.tres")
export var FCT: PackedScene = preload("res://src/World/Effects/FCT.tscn")
export var move_speed := 100 #pixels per second
export var max_hp := 20
var cell := Vector2.ZERO setget set_cell
var invulnerable = false
var _is_walking := false setget _set_is_walking
export var resistances := [0]
export var weaknesses := [0]
export var hp = 20 setget set_hp
onready var _hp_bar: TextureProgress = $TextureProgress
onready var _sprite: Sprite = $Sprite
onready var _anim_player: AnimationPlayer = $AnimationPlayer
onready var effects = get_node_or_null("../Effects")

signal end_reached(hp)
signal unit_destroyed()

func _ready() -> void:
	add_to_group("enemy")
	set_process(false)
	cell = grid.get_cell_coordinates(position)
	position = grid.get_map_position(cell)
	_hp_bar.max_value = max_hp
	_hp_bar.value = hp

var _last_cell := cell
var _position_last_frame := Vector2()
var _cardinal_direction := 0
var _cardinal_direction_last_frame := 0
func _process(delta: float) -> void:
	offset += move_speed * delta
	if grid.get_cell_coordinates(position) != _last_cell:
		_last_cell = grid.get_cell_coordinates(position)
	if unit_offset >= 1.0:
		self._is_walking = false
		emit_signal("end_reached", hp)
		queue_free()
	var motion = position - _position_last_frame
	if motion.length() > 0.01:
		_cardinal_direction = int(4.0 * (motion.rotated(PI/4.0).angle() + PI) / TAU)
	if _cardinal_direction != _cardinal_direction_last_frame:
		match _cardinal_direction:
			0:
				_sprite.set_flip_h(false)
				_anim_player.play("unitwalk_left")
			1:
				_anim_player.play("unitwalk_up")
			2:
				_sprite.set_flip_h(true)
				_anim_player.play("unitwalk_left")
			3:
				_anim_player.play("unitwalk_down")
	_position_last_frame = position
	_cardinal_direction_last_frame = _cardinal_direction

func set_cell(value: Vector2) -> void:
	cell = grid.clamp_to_board(value)

func _set_is_walking(value: bool) -> void:
	_is_walking = value
	set_process(_is_walking)

func walk() -> void:
	_set_is_walking(true)

func set_hp(new_hp) -> void:
	hp = new_hp
	if hp <= 0:
		print("unit died")
		emit_signal("unit_destroyed")
		queue_free()

func take_damage(damage_amount) -> void:
	if invulnerable:
		return
	#$damage_flash.frame = 0
	#$damage_flash.play()
	if effects:
		var fct = FCT.instance()
		effects.add_child(fct)
		fct.rect_position = get_global_position() + Vector2(0,-16)
		fct.show_value(str(damage_amount), Vector2(0,-8), 1, PI/2)
	set_hp(clamp(hp - damage_amount, 0, max_hp))
