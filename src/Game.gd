extends Node

var loader
var wait_frames
var time_max = 100 #msec
onready var current_scene = $MainMenu
onready var animator = $CanvasLayer/Loading/AnimationPlayer
onready var loading = $CanvasLayer/Loading

func _ready() -> void:
	loading.visible = false

func go_to_scene(path) -> void:
	loader = ResourceLoader.load_interactive(path)
	if loader == null:
		push_error("no scene to load")
		return
	animator.play("fade-in")
	yield(animator, "animation_finished")
	set_process(true)
	current_scene.queue_free()
	wait_frames = 1

func _process(_delta: float) -> void:
	if loader == null:
		loading.visible = false
		set_process(false)
		return
	if wait_frames > 0:
		wait_frames -= 1
		return
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			update_progress()
		else:
			push_error("loading fail")
			loader = null
			break

func update_progress() -> void:
	loading.visible = true

func set_new_scene(scene_resource) -> void:
	current_scene = scene_resource.instance()
	add_child(current_scene)
