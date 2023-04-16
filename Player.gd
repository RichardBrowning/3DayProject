extends KinematicBody

const SPEED = 3.0;
const JUMP_VELOCITY = 4.5;
const GRAVITY = -.2;

var velocity = Vector3.ZERO;
onready var neck = $Neck;
onready var camera = $Neck/Camera;
#onready var weapon = $Neck/Camera/hotWeapon;
onready var weapon_mesh = $Neck/Camera/hotWeapon/Armature/Skeleton/Shotgun
onready var weapon_animation = $Neck/Camera/hotWeapon/AnimationPlayer;
export var has_weapon = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon_mesh.visible = false;
	pass # Replace with function body.

func _unhandled_input(event: InputEvent):
	# if mouse clicked on the window, start capturing the mouse 
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	elif event.is_action_pressed("ui_cancel"): #if ESC clicked, stop capturing the mouse
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01);
			camera.rotate_x(-event.relative.y * 0.01);
			camera.rotation.x = clamp(camera.rotation.x, -0.894, 1.06);

#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#once acquired weapon, make weapon visible
	if has_weapon:
		weapon_mesh.visible = true; 
	if !is_on_floor():
		velocity.y += GRAVITY;
	if Input.is_action_just_pressed("ui_accept") && is_on_floor():
		velocity.y = JUMP_VELOCITY;
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if has_weapon && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			weapon_animation.play("Fire");
	
	
	var input_dir = Input.get_vector( "ui_left", "ui_right", "ui_up", "ui_down");
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	if direction:
		velocity.x = direction.x * SPEED;
		velocity.z = direction.z * SPEED;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED);
		velocity.z = move_toward(velocity.z, 0, SPEED);
		
	# mouse input
	move_and_slide(velocity, Vector3.UP);
