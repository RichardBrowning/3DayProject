extends KinematicBody

const GRAVITY = -.2;
const MOVE_SPEED = 3.5;
onready var target_position = get_parent().get_node("CollisionArea").transform.origin;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isMoving = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if isMoving:
		var dir = (target_position - translation).normalized()
		move_and_slide(dir);
	#print(target_position)

# func _physics_process(delta):
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
