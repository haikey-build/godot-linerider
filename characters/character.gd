extends CharacterBody2D

const GRAVITY = 20.0
const LINE_ACCELERATION = 20.0
var _velocity = Vector2(0, 0)

func _physics_process(delta):
	_velocity.y += GRAVITY

	var collision = move_and_collide(_velocity * delta)
	if collision:
		var lineType = collision.get_collider().get_parent().get_type()
		match lineType:
			Rider.LineType.NEUTRAL:
				_handle_collisions(collision, delta)
			Rider.LineType.ACCELERATE:
				_velocity += collision.get_normal().rotated(PI/2) * LINE_ACCELERATION
				_handle_collisions(collision, delta)

func _handle_collisions(collision, delta):
	while collision:
		var remainingProportion = collision.get_remainder().length() / (_velocity * delta).length()
		_velocity = _velocity.slide(collision.get_normal())
		collision = move_and_collide(_velocity * delta * remainingProportion)
