extends RayCast

var current_collider

func _process(delt):
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider!= collider:
			current_collider = collider;
			
		if Input.is_action_just_pressed("ui_interact"):
			collider.interact()
			
	elif current_collider:
		current_collider = null;
