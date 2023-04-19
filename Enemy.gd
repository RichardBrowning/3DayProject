extends KinematicBody
# If the player got out of the elevator
	#Return to Elevator, can still 

const GRAVITY = -.2;
const MOVE_SPEED = 3;

onready var target_position = get_parent().get_node("TargetArea").transform.origin;
onready var ghostAnimation = $the_ghost/AnimationPlayer;
onready var ghstMesh = $the_ghost/Armature/Skeleton/WhiteClown
var inited = false;
export var isMoving = false;
export var hasCaught = false;
# if the ghost tripped over anything
export var trippedOver = false;
var infinite_initia = false

func _ready():
	ghstMesh.visible = false;
	pass # Replace with function body.

func _process(delta):
	moveTowardPlayer(delta);
		
func moveTowardPlayer(delta):
	if isMoving:
		if !inited:
			get_parent().get_node("OceanviewHotel/MainHotel/Lights/FirstLight").light_energy = 0
			yield(get_tree().create_timer(2), "timeout")
			get_parent().get_node("OceanviewHotel/MainHotel/Lights/SpotLight1").light_energy = 2.5
			yield(get_tree().create_timer(1.5), "timeout")
			get_parent().get_node("OceanviewHotel/MainHotel/Lights/SpotLight3").light_energy = 2.5
			yield(get_tree().create_timer(1.5), "timeout")
			get_parent().get_node("OceanviewHotel/MainHotel/Lights/SpotLight2").light_energy = 2.5
			ghstMesh.visible = true;
			inited = true;
		ghostAnimation.play("RunT");
		var dir = (target_position - translation).normalized()
		var collision = move_and_collide(dir * MOVE_SPEED * delta, infinite_initia);
		if collision:
			if collision.collider is Tripper:
				infinite_initia = true;
				yield(get_tree().create_timer(0.3), "timeout")
				trippedOver = true;
		if hasCaught || trippedOver:
			isMoving = false;
			ghostAnimation.play("FallT");
			yield(get_tree().create_timer(ghostAnimation.get_animation("FallT").length), "timeout");
			ghostAnimation.stop();

