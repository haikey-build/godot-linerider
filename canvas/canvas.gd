extends Node2D

var _lineScene = preload("res://canvas/line.tscn")
var _lines = []
var _draw_mode

func start_drawing(pos, draw_mode):
	_draw_mode = draw_mode
	var line = _lineScene.instantiate()
	line.init(pos, _draw_mode)
	add_child(line)
	_lines.push_back(line)
	
func draw(pos):
	match _draw_mode:
		Rider.DrawMode.FREEHAND:
			_lines[-1].add_new_point(pos)
		Rider.DrawMode.STRAIGHT:
			_lines[-1].update_last_point(pos)

func finish_drawing(pos):
	match _draw_mode:
		Rider.DrawMode.STRAIGHT:
			_lines[-1].finish_straight_line(pos)

func stop_drawing():
	# check if line empty and delete
	pass
