extends RayCast

#var current_collider
#onready var interaction_label = get_node("")
#func _process(delt):
#	var collider = get_collider()
#
#	if is_colliding() and collider is Interactable:
#		if current_collider!= collider:
#			current_collider = collider;
#
#		if Input.is_action_just_pressed("ui_interact"):
#			collider.interact()
#
#	elif current_collider:
#		current_collider = null;
func _physics_process(_delta):
	if is_colliding():
		print("colliding")

func _ready():
	add_exception(owner)
