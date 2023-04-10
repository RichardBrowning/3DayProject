extends KinematicBody

const SPEED = 3.0;
const JUMP_VELOCITY = 4.5;
const GRAVITY = -.2;

var velocity = Vector3.ZERO;
onready var neck := $Neck;
onready var camera := $Neck/Camera;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY;
	if Input.is_action_just_pressed("ui_accept") && is_on_floor():
		velocity.y = JUMP_VELOCITY;
	
	var input_dir = Input.get_vector( "ui_left", "ui_right", "ui_up", "ui_down");
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	if direction:
		velocity.x = direction.x * SPEED;
		velocity.z = direction.z * SPEED;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED);
		velocity.z = move_toward(velocity.z, 0, SPEED);
		
	# mouse input
	
	move_and_slide(velocity, Vector3.UP);
