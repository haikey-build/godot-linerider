extends Node2D

var _lineFreehandScene = preload("res://canvas/line_freehand.tscn")
var _lineStraightScene = preload("res://canvas/line_straight.tscn")
var _lines = []
var _erasing_mode


func start_drawing(pos, draw_mode, line_type):
	match draw_mode:
		Rider.DrawMode.FREEHAND:
			_start_line(pos, _lineFreehandScene, line_type)
		Rider.DrawMode.STRAIGHT:
			_start_line(pos, _lineStraightScene, line_type)
		Rider.DrawMode.ERASER:
			_erasing_mode = true

func _start_line(pos, scene, line_type):
	_erasing_mode = false
	var line = scene.instantiate()
	line.init(pos, line_type)
	add_child(line)
	_lines.push_back(line)

func mouse_move(pos):
	if _erasing_mode:
		pass
	else:
		_lines[-1].update_draw(pos)

func finish_drawing(pos):
	_lines[-1].finish_draw(pos)

func clear_lines():
	for line in _lines:
		line.queue_free()
	_lines = []
