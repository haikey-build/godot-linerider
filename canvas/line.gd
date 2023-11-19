extends Node2D

var _line: Line2D
var _body: StaticBody2D

func init(pos):
	_line = Line2D.new()
	_line.add_point(pos)
	add_child(_line)

	_body = StaticBody2D.new()
	add_child(_body)
	
		
func add_new_point(newPos):
	var prevPos = _get_last_point()
	_add_new_section(prevPos, newPos)
	

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
