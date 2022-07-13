extends Node2D

export var weapon_id := 1
export var damage = 10
export var damage_type = 1
export var cooldown = 1

onready var _anim_player = $AnimationPlayer
onready var _timer = $Timer

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_HitArea_area_entered(area: Area2D) -> void:
	if area.get_parent():
		var target = area.get_parent()
		if target.is_in_group("enemy") and target.has_method("take_damage"):
			target.take_damage(damage, damage_type)

func _on_Timer_timeout() -> void:
	if not _anim_player.is_playing():
		_anim_player.play("attack")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		_timer.start(cooldown)
