extends Node2D

var _lineScene = preload("res://canvas/line.tscn")
var _lines = []

func start_drawing(pos):
	var line = _lineScene.instantiate()
	line.init(pos)
	add_child(line)
	_lines.push_back(line)
	
func draw(pos):
	_lines[-1].add_new_point(pos)

func stop_drawing():
	# check if line empty and delete
	pass
