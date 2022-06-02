extends Node2D

const inactive_index = -1
onready var ball = $Ball
onready var half_size = $Back.texture.get_size()/4
var direction := Vector2.ZERO
var center_point := Vector2.ZERO
var current_force := Vector2.ZERO
var ball_position := Vector2.ZERO
var squared_half_size_length = 0
var current_pointer_index = inactive_index

func _ready() -> void:
	map_analog_to_dpad()
	set_process_input(true)
	squared_half_size_length = half_size.x * half_size.y

func get_force() -> Vector2:
	return current_force

func extract_pointer_index(event: InputEvent) -> int:
	var touch = event is InputEventScreenTouch
	var drag = event is InputEventScreenDrag
	var mouse_button = event is InputEventMouseButton
	var mouse_move = event is InputEventMouseMotion
	if touch or drag:
		return event.index
	elif mouse_button or mouse_move:
		return 0
	else:
		return inactive_index

func _input(event: InputEvent) -> void:
	var incoming_pointer = extract_pointer_index(event)
	if incoming_pointer == inactive_index:
		display_move(event)
		return
	if need_to_change_pointer(event):
		if (current_pointer_index != incoming_pointer) and event.is_pressed():
			current_pointer_index = incoming_pointer;
	var same_pointer = (current_pointer_index == incoming_pointer)
	if (current_pointer_index != inactive_index) and same_pointer:
		process_input(event)

func display_move(event: InputEvent) -> void:
	if event.is_action_released('ui_up') or event.is_action_released('ui_down'):
		direction.y = 0
	if event.is_action_released('ui_left') or event.is_action_released('ui_right'):
		direction.x = 0
	if event.is_action_pressed('ui_right'):
		direction.x += 1
	elif event.is_action_pressed('ui_left'):
		direction.x -= 1
	if event.is_action_pressed('ui_down'):
		direction.y += 1
	elif event.is_action_pressed('ui_up'):
		direction.y -= 1
	direction = direction.normalized()
	ball_position.x = half_size.x * direction.x
	ball_position.y = half_size.y * direction.y
	ball.position = Vector2(ball_position.x, ball_position.y)

func need_to_change_pointer(event: InputEvent) -> bool:
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		var length = (global_position - event.position).length_squared()
		return length < squared_half_size_length
	return false

func process_input(event: InputEvent) -> void:
	calculate_force(event.position - global_position)
	update_ball_position()
	if is_released(event):
		reset()

func calculate_force(input: Vector2) -> void:
	current_force.x = (input.x - center_point.x)/half_size.x
	current_force.y = -(input.y - center_point.y)/half_size.y
	if current_force.length_squared() > 1:
		current_force = current_force / current_force.length()
	send_signal_to_listener()

func send_signal_to_listener() -> void:
	get_tree().call_group("JoyStick", "analog_signal_change", current_force, self.get_name())
	map_analog_to_dpad()

func update_ball_position():
	ball_position.x = half_size.x * current_force.x
	ball_position.y = half_size.y * -current_force.y
	ball.position = Vector2(ball_position.x, ball_position.y)

func is_pressed(event: InputEvent) -> bool:
	if event is InputEventMouseMotion:
		return (InputEventMouse.button_mask == 1)
	elif event is InputEventScreenTouch:
		return event.is_pressed()
	return false

func is_released(event: InputEvent) -> bool:
	if event is InputEventScreenTouch:
		return !event.is_pressed()
	elif event is InputEventMouseButton:
		return !event.is_pressed()
	return false

func reset() -> void:
	current_pointer_index = inactive_index
	calculate_force(Vector2(0,0))
	update_ball_position()

func map_analog_to_dpad() -> void:
	if current_force.x < -0.2:
		Input.action_press('ui_left')
	else:
		Input.action_release('ui_left')
	if current_force.x > 0.2:
		Input.action_press('ui_right')
	else:
		Input.action_release('ui_right')
	if current_force.y < -0.2:
		Input.action_press('ui_down')
	else:
		Input.action_release('ui_down')
	if current_force.y > 0.2:
		Input.action_press('ui_up')
	else:
		Input.action_release('ui_up')
