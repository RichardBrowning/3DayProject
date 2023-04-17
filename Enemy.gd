extends KinematicBody
# If the player got out of the elevator
	#Return to Elevator, can still 

const GRAVITY = -.2;
const MOVE_SPEED = 1;

onready var target_position = get_parent().get_node("TargetArea").transform.origin;
onready var collision_area = get_parent().get_node("TargetArea");

export var isMoving = false;
export var hasCaught = false;
# if the ghost tripped over anything
export var trippedOver = false;
var infinite_initia = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	moveTowardPlayer(delta);
		
func moveTowardPlayer(delta):
	if isMoving:
		var dir = (target_position - translation).normalized()
		var collision = move_and_collide(dir * MOVE_SPEED * delta, infinite_initia);
		if collision:
			if collision.collider is Tripper:
				infinite_initia = true;
				yield(get_tree().create_timer(0.3), "timeout");
				trippedOver = true
		if hasCaught || trippedOver:
			isMoving = false;

