extends KinematicBody

const GRAVITY = -.2;
const MOVE_SPEED = 3.5;
onready var target_position = get_parent().get_node("Area").transform.origin;
onready var collision_area = get_parent().get_node("Area");

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isMoving = true;
var isCaught = false;
var trippedOver = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if isMoving:
		var dir = (target_position - translation).normalized()
		move_and_slide(dir);
	if isCaught || trippedOver:
		isMoving = false;
		
		
#func _on_Area_body_entered(body: Node) -> void:
#	print("Collided");

# func _physics_process(delta):
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
