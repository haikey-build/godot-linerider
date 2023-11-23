extends RigidBody2D

func _ready():
	contact_monitor = true
	max_contacts_reported = 1
	

func _physics_process(delta):
	var cols = get_colliding_bodies()
	constant_force = Vector2(0, 0)
	if cols.size() > 0:
		var col = cols[0]
		var line = col.get_parent()
		if line.adds_force():
			add_constant_central_force(col.get_force_vector())


func _input(event):
	if event is InputEventKey:
		if event.key_label == KEY_J:
			if event.pressed: 
				$"Black-64".hide()
				$bosh.show()
				
