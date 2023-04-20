extends Enemy
# If the player got out of the elevator
	#Return to Elevator, can still 
onready var health_indicator = get_parent().get_node("CharBody/Neck/Camera/Enemy_health");
const GRAVITY = -.2;
const MOVE_SPEED = 3;

onready var target_position = get_parent().get_node("TargetArea").transform.origin;
onready var ghostAnimation = $the_ghost/AnimationPlayer;
onready var ghstMesh = $the_ghost/Armature/Skeleton/WhiteClown
# if lights done
var inited = false;
# if the ghost should be moving
export var isMoving = false;
# if the ghost have caught the player
export var hasCaught = false;
# if the ghost tripped over anything
export var trippedOver = false;
# the health of ghost
var health = 100;
var infinite_initia = false

func _ready():
	ghstMesh.visible = false;
	pass # Replace with function body.

func _process(delta):
	# once recieved signal to run
	if isMoving:
		# inited is false before the initing steps finishes
		if !inited:
			self.set_process(false);
			#play the blocking function
			play_light_effect()
			yield(get_tree().create_timer(5), "timeout")
			health_indicator.text = String(health)
			#if all is done, inited is true
			inited = true;
			self.set_process(true);
			# this block will not be run any more
		else: 
			#set visibility to true
			ghstMesh.visible = true;
			#start animation
			ghostAnimation.play("RunT");
			var dir = (target_position - translation).normalized();
			var collision = move_and_collide(dir * MOVE_SPEED * delta, infinite_initia);
			if (translation.distance_to(target_position)) < 1:
				get_parent().get_node("CharBody/Neck/Camera/GameOver").visible = true;
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				get_parent().get_node("CharBody").game_over = true;
			if collision:
				if collision.collider is Tripper:
					infinite_initia = true;
					trippedOver = true;
					play_drop_health();
					ghostAnimation.stop(true);
				elif collision.collider is Bullet:
					health -= 1;
				#assign the heath to indicator
				health_indicator.text = String(health);
				if health <= 0:
					health_indicator.text = "0";
					infinite_initia = true;
					trippedOver = true;
					ghostAnimation.stop(true)
			if trippedOver || hasCaught:
				isMoving = false;
				ghostAnimation.play("FallT")
				yield(get_tree().create_timer(ghostAnimation.get_animation("FallT").length), "timeout");
				ghostAnimation.stop();
				health_indicator.text = "";
				yield(get_tree().create_timer(2), "timeout");
				get_parent().get_node("CharBody/Neck/Camera/GameComplete").visible = true;
				yield(get_tree().create_timer(2), "timeout");
				get_tree().quit();
func stop_moving(delta):
	pass
	
func play_light_effect():
	get_parent().get_node("OceanviewHotel/MainHotel/Lights/FirstLight").light_energy = 0
	yield(get_tree().create_timer(2), "timeout")
	get_parent().get_node("OceanviewHotel/MainHotel/Lights/SpotLight1").light_energy = 2.5
	yield(get_tree().create_timer(1.5), "timeout")
	get_parent().get_node("OceanviewHotel/MainHotel/Lights/SpotLight3").light_energy = 2.5
	yield(get_tree().create_timer(1.5), "timeout")
	get_parent().get_node("OceanviewHotel/MainHotel/Lights/SpotLight2").light_energy = 2.5

func play_drop_health():
	for i in range(100, -1, -1):
		health_indicator.text = String(i);
		yield(get_tree().create_timer(0.01), "timeout");
