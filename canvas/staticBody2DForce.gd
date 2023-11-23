class_name StaticBody2DForce
extends StaticBody2D

var forceVector: Vector2

func get_force_vector():
	return forceVector * Rider.LINE_ACCELERATION
