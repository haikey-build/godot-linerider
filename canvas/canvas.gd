extends Node2D

var _lineFreehandScene = preload("res://canvas/line_freehand.tscn")
var _lineStraightScene = preload("res://canvas/line_straight.tscn")
var _lines = []


func start_drawing(pos, draw_mode):
	var line
	match draw_mode:
		Rider.DrawMode.FREEHAND:
			line = _lineFreehandScene.instantiate()
		Rider.DrawMode.STRAIGHT:
			line = _lineStraightScene.instantiate()
	line.init(pos)
	add_child(line)
	_lines.push_back(line)
	
func draw(pos):
	_lines[-1].update_draw(pos)

func finish_drawing(pos):
	_lines[-1].finish_draw(pos)

func clear_lines():
	for line in _lines:
		line.queue_free()
	_lines = []
