extends Bullet

var velocity = Vector3.ZERO
var gravity = Vector3.DOWN * 0.1
var bullet_speed = 50

func _physics_process(delta):
	velocity += gravity * delta
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider is Enemy:
			yield(get_tree().create_timer(0.12), "timeout")
			queue_free();
	if translation.y < -3:
		queue_free();
