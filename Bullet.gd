extends KinematicBody

var velocity = Vector3.ZERO
var gravity = Vector3.DOWN * 0.1
var bullet_speed = 50

func _physics_process(delta):
	velocity += gravity * delta
	
	move_and_collide(velocity * delta)
	if translation.y < -3:
		queue_free()

