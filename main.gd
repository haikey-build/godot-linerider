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
				return_to_editor()
	if Input.is_action_just_pressed("space"):
		match _mode:
			EDITING:
				run()
			RUNNING:
				pass

func _ready():
	_editor = _editorScene.instantiate()
	add_child(_editor)
	_canvas = _editor.init_empty()
	_editor.set_run_func(run)

func run():
	_mode = RUNNING
	_editor.remove_child(_canvas)
	
	_run = _runScene.instantiate()
	add_child(_run)
	_run.add_child(_canvas)
	
	_editor.queue_free()

func return_to_editor():
	_mode = EDITING
	_run.remove_child(_canvas)
	
	_editor = _editorScene.instantiate()
	add_child(_editor)
	_editor.init_load(_canvas)
	_editor.set_run_func(run)
	
	_run.queue_free()
	
