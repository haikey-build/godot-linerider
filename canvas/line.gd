class_name Line
extends Node2D

var _line: Line2D
var _bodies: Array[StaticBody2D]
var _type: Rider.LineType

func init(pos, lineType):
	_type = lineType
	_line = Line2D.new()
	_line.joint_mode = Line2D.LINE_JOINT_ROUND
	_line.default_color = Color(1, 1, 1, 1)
	_line.width = 5
	_line.add_point(pos)
	add_child(_line)


func adds_force():
	return _type == Rider.LineType.ACCELERATE


func _add_new_section(startPos, endPos):
	_line.add_point(endPos)
	if _type != Rider.LineType.NON_COLLIDING:
		var body = StaticBody2DForce.new()
		body.forceVector = Vector2(endPos.x - startPos.x, endPos.y - startPos.y).normalized()
		add_child(body)
		_bodies.push_back(body)
		
		var col = CollisionShape2D.new()
		var shape = SegmentShape2D.new()
		shape.a = startPos
		shape.b = endPos
		col.shape = shape
		body.add_child(col)

	
func _get_last_point():
	var idx = _line.get_point_count() - 1
	return _line.get_point_position(idx)
	
	
func _input(event):
	if event is InputEventKey:
		if event.key_label == KEY_J:
			if event.pressed: 
				_line.default_color = Color(0, 0, 0, 1)
				
