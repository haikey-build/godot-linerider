class_name Line_Freehand
extends Line

func update_draw(newPos):
	var prevPos = _get_last_point()
	_add_new_section(prevPos, newPos)

func finish_draw(x):
	pass
