class_name Line
extends Node2D

var _line: Line2D
var _body: StaticBody2D
var _type: Rider.LineType

func init(pos):
	_line = Line2D.new()
	_line.joint_mode = Line2D.LINE_JOINT_ROUND
	_line.width = 5
	_line.add_point(pos)
	add_child(_line)

	_body = StaticBody2D.new()
	add_child(_body)
	
	_type = Rider.LineType.ACCELERATE

func get_type():
	return _type

func _add_new_section(startPos, endPos):
	_line.add_point(endPos)
	
	var col = CollisionShape2D.new()
	var shape = SegmentShape2D.new()
	shape.a = startPos
	shape.b = endPos
	col.shape = shape
	_body.add_child(col)

	
func _get_last_point():
	var idx = _line.get_point_count() - 1
	return _line.get_point_position(idx)
