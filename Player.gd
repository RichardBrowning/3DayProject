extends KinematicBody
class_name Player

const SPEED = 3.0;
const JUMP_VELOCITY = 4.5;
const GRAVITY = -.2;

var velocity = Vector3.ZERO;
onready var neck = $Neck;
onready var camera = $Neck/Camera;

onready var weapon_mesh = $Neck/Camera/hotWeapon/Armature/Skeleton/Shotgun
onready var weapon_animation = $Neck/Camera/hotWeapon/AnimationPlayer;
onready var weapon_sound = $Neck/Camera/hotWeapon/Pew
export var has_weapon = false;
var weapon_ready = true;
var weapon_aiming = false;
var sprinting = false

var bulletInstance;

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon_mesh.visible = false;
	bulletInstance = preload("res://Bullet.tscn")

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
		if has_weapon && weapon_ready && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			fire_weapon();
	if has_weapon && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if Input.is_action_pressed("ui_aim"):
			#set collision shape to disabled
			$Neck/Camera/hotWeapon/Armature/Skeleton/Shotgun/StaticBody/CollisionShape.disabled = true;
			#move the gun to aim
			if weapon_aiming == false:
				$Neck/Camera/hotWeapon.translate(Vector3(0.3, 0, 1.32));
				print("aiming")
				weapon_aiming = true;
		if Input.is_action_just_released("ui_aim"):
			#move the gun back
			if weapon_aiming == true:
				print("disengage")
				$Neck/Camera/hotWeapon.translate(Vector3(-0.3, 0, -1.32));
				weapon_aiming = false; 
			#set collision shape to be enabled
			$Neck/Camera/hotWeapon/Armature/Skeleton/Shotgun/StaticBody/CollisionShape.disabled = false;
	
	if Input.is_action_pressed("dash"):
		if sprinting == false:
			sprinting = true;
	if Input.is_action_just_released("dash"):
		if sprinting == true:
			sprinting = false;
		
	var input_dir = Input.get_vector( "ui_right", "ui_left", "ui_down", "ui_up");
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	var sp_buff = 1
	if sprinting:
		sp_buff = 1.5
	if direction:
		velocity.x = direction.x * SPEED * sp_buff;
		velocity.z = direction.z * SPEED * sp_buff;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED*sp_buff);
		velocity.z = move_toward(velocity.z, 0, SPEED*sp_buff);
		
	# mouse input
	move_and_slide(velocity, Vector3.UP);

func fire_weapon():
	weapon_ready = false;
	#create bullet
	var bullet = bulletInstance.instance()
	owner.add_child(bullet)
	bullet.global_transform = $Neck/Camera/hotWeapon/BulletSpawn.global_transform
	bullet.velocity = -bullet.transform.basis.x * bullet.bullet_speed
	weapon_animation.play("Fire");
	weapon_sound.play(0);
	yield(get_tree().create_timer(weapon_animation.get_animation("Fire").length), "timeout");
	weapon_sound.stop();
	weapon_ready = true;
