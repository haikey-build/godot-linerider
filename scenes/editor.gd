extends Node2D

enum {IDLE, DRAWING}

var _canvasScene = preload("res://canvas/canvas.tscn")
var _canvas
var _mode = IDLE

func _ready():
	_canvas = _canvasScene.instantiate()
	add_child(_canvas)
	

func _physics_process(delta):
	if Input.is_action_just_pressed("mouse down"):
		_canvas.start_drawing(get_global_mouse_position())
		_mode = DRAWING
	elif Input.is_action_just_released("mouse down"):
		_mode = IDLE
		

func _input(event):
	if event is InputEventMouseMotion and _mode == DRAWING:
		_canvas.draw(get_global_mouse_position())
		
