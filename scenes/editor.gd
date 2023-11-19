extends Node2D

enum {IDLE, DRAWING}

var _canvasScene = preload("res://canvas/canvas.tscn")
var _canvas
var _mouse_mode = IDLE
var _draw_mode: Rider.DrawMode = Rider.DrawMode.STRAIGHT

func _ready():
	_canvas = _canvasScene.instantiate()
	add_child(_canvas)


func _physics_process(delta):
	if Input.is_action_just_pressed("mouse down"):
		_canvas.start_drawing(get_global_mouse_position(), _draw_mode)
		_mouse_mode = DRAWING
	elif Input.is_action_just_released("mouse down"):
		_canvas.finish_drawing(get_global_mouse_position())
		_mouse_mode = IDLE
	
	if Input.is_action_pressed("escape"):
		get_tree().quit()

func _input(event):
	if event is InputEventMouseMotion and _mouse_mode == DRAWING:
		_canvas.draw(get_global_mouse_position())

