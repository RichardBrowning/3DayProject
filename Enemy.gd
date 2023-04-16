extends KinematicBody
# If the player got out of the elevator
	#Return to Elevator, can still 


const GRAVITY = -.2;
const MOVE_SPEED = 3.5;

onready var target_position = get_parent().get_node("TargetArea").transform.origin;
onready var collision_area = get_parent().get_node("TargetArea");

onready var isMoving = true;
onready var isCaught = false;
# if the ghost tripped over anything
onready var trippedOver = false;

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
		
func moveTowardEnemy():
	if isMoving:
		var dir = (target_position - translation).normalized()
		move_and_slide(dir);
	if isCaught || trippedOver:
		isMoving = false;
