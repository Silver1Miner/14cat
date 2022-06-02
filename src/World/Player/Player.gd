extends Node2D

export var speed := 100
var velocity := Vector2.ZERO
var active := true

func _ready() -> void:
	pass # Replace with function body.

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
	if active:
		get_input()
		position += velocity * delta
		if position.x < 0 + 16:
			position.x = 0 + 16
		if position.x > 360 - 16:
			position.x = 360 - 16
		if position.y < 0 + 16:
			position.y = 0 + 16
		if position.y > (640 - 150) - 16:
			position.y = (640 - 150) - 16
	
