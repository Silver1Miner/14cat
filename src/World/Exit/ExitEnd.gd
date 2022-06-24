extends Area2D

export var wait_time := 120

func _ready() -> void:
	set_process(false)
	$Timer.wait_time = wait_time
	if not PlayerData.is_survival:
		$Timer.start()

func _process(delta: float) -> void:
	position.y += 40 * delta

func _on_Timer_timeout() -> void:
	set_process(true)
