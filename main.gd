extends Node2D

enum {EDITING, RUNNING}

var _editorScene = preload("res://scenes/editor.tscn")
var _editor
var _runScene = preload("res://scenes/run.tscn")
var _run
var _canvas

var _mode = EDITING

func _physics_process(delta):
	if Input.is_action_just_pressed("escape"):
		match _mode:
			EDITING:
				get_tree().quit()
			RUNNING:
				start_editor()
	if Input.is_action_just_pressed("space"):
		match _mode:
			EDITING:
				start_runner()
			RUNNING:
				pass

func _ready():
	_editor = _editorScene.instantiate()
	add_child(_editor)
	_canvas = _editor.init_empty()
	_editor.set_run_func(start_runner)

func start_runner():
	_mode = RUNNING
	_editor.remove_child(_canvas)
	
	_run = _runScene.instantiate()
	add_child(_run)
	_run.add_child(_canvas)
	
	_editor.queue_free()

func start_editor():
	_mode = EDITING
	_run.remove_child(_canvas)
	
	_editor = _editorScene.instantiate()
	add_child(_editor)
	_editor.init_load(_canvas)
	_editor.set_run_func(start_runner)
	
	_run.queue_free()
	
