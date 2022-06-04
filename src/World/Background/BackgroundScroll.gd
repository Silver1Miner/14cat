extends ParallaxBackground

export var camera_velocity := Vector2(0, 20)

func _process(delta: float) -> void:
	var new_offset: Vector2 = get_scroll_offset() + camera_velocity * delta
	set_scroll_offset(new_offset)

func set_background(new_background: Texture) -> void:
	$ParallaxLayer/Sprite.texture = new_background
