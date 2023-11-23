extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.key_label == KEY_J:
			if event.pressed: 
				$"White-64".show()
				
