extends Node2D

enum {IDLE, DRAWING, PANNING}

var _canvasScene = preload("res://canvas/canvas.tscn")
var _canvas
@onready var _camera = $Camera2D
@onready var _gui = $gui

var _mouse_mode = IDLE
var _draw_mode: Rider.DrawMode = Rider.DrawMode.STRAIGHT
var _run_func

func init_empty():
	_canvas = _canvasScene.instantiate()
	add_child(_canvas)
	return _canvas

func init_load(canvas):
	_canvas = canvas
	add_child(_canvas)

func set_run_func(fun):
	_run_func = fun

func _mouse_in_gui(pos):
	return pos.y < 40 and pos.x < 250

func _physics_process(delta):
	if Input.is_action_just_pressed("mouse primary"):
		if !_mouse_in_gui(get_viewport().get_mouse_position()):
			_canvas.start_drawing(get_global_mouse_position(), _draw_mode)
			_mouse_mode = DRAWING
	elif Input.is_action_just_released("mouse primary") and _mouse_mode != IDLE:
		_canvas.finish_drawing(get_global_mouse_position())
		_mouse_mode = IDLE
	elif Input.is_action_just_pressed("pan"):
		_mouse_mode = PANNING
	elif Input.is_action_just_released("pan"):
		_mouse_mode = IDLE

func _input(event):
	if event is InputEventMouseMotion:
		match _mouse_mode:
			DRAWING:
				_canvas.draw(get_global_mouse_position())
			PANNING:
				_camera.position -= event.relative / _camera.zoom.x
	elif event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				_camera.zoom *= 1.1
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				_camera.zoom /= 1.1
				

func _on_straight_pressed():
	_draw_mode = Rider.DrawMode.STRAIGHT

func _on_freehand_pressed():
	_draw_mode = Rider.DrawMode.FREEHAND

func _on_run_pressed():
	_run_func.call()

func _on_clear_pressed():
	_canvas.clear_lines()
