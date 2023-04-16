extends KinematicBody

var velocity = Vector3.ZERO
var gravity = Vector3.DOWN
var bullet_speed = 20

func _physics_process(delta):
	velocity += gravity * delta
	
	move_and_collide(velocity * delta)
	if translation.y < -3:
		queue_free()

