class_name Line_Straight
extends Line


func update_draw(newPos):
	if _line.get_point_count() == 1:
		_line.add_point(newPos)
	else:
		_line.set_point_position(1, newPos)

func finish_draw(endPos):
	_line.set_point_position(1, endPos)
	_add_new_section(_line.get_point_position(0), endPos)
