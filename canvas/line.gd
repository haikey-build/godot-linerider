extends Node2D

var _line: Line2D
var _body: StaticBody2D
var _draw_mode: Rider.DrawMode

func init(pos, draw_mode):
	_draw_mode = draw_mode
	_line = Line2D.new()
	_line.joint_mode = Line2D.LINE_JOINT_ROUND
	_line.width = 5
	_line.add_point(pos)
	add_child(_line)

	_body = StaticBody2D.new()
	add_child(_body)
	
		
func add_new_point(newPos):
	var prevPos = _get_last_point()
	_add_new_section(prevPos, newPos)

func update_last_point(newPos):
	if _line.get_point_count() == 1:
		_line.add_point(newPos)
	else:
		_line.set_point_position(1, newPos)

func finish(endPos):
	_line.set_point_position(1, endPos)
	_add_new_section(_line.get_point_position(0), endPos)
	

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
