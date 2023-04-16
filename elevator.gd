extends Spatial

export var doorOpen = false
export var currentFloor = 1
onready var elevator_anim = $AnimationPlayer

func toggle_door():
	#get door node and its status
	if doorOpen:
		elevator_anim.play("DoorCloses");
		get_node("Elevator Button Outside").enabled = false;
		yield(get_tree().create_timer(elevator_anim.get_animation("DoorCloses").length), "timeout");
		doorOpen = false
		get_node("Elevator Button Outside").enabled = true
	else:
		elevator_anim.play("DoorOpens");
		get_node("Elevator Button Outside").enabled = false;
		yield(get_tree().create_timer(elevator_anim.get_animation("DoorCloses").length), "timeout");
		doorOpen = true
		get_node("Elevator Button Outside").enabled = true;

func Go_Up():
	get_node("Elevator/Elevator Buttons").enabled = false;
	if currentFloor == 2:
		pass
	if doorOpen:
		elevator_anim.play("DoorCloses");
		yield(get_tree().create_timer(elevator_anim.get_animation("DoorOpens").length + 1), "timeout");
	elevator_anim.play("GoingUp");
	yield(get_tree().create_timer(elevator_anim.get_animation("GoingUp").length + 1), "timeout");
	elevator_anim.play("DoorOpens");
	currentFloor = 2
	get_node("Elevator/Elevator Buttons").enabled = true
	
func Go_Down():
	get_node("Elevator/Elevator Buttons").enabled = false
	if currentFloor == 1:
		pass
	if doorOpen:
		elevator_anim.play("DoorCloses");
		yield(get_tree().create_timer(elevator_anim.get_animation("DoorOpens").length + 1), "timeout");
	elevator_anim.play("GoingDown");
	yield(get_tree().create_timer(elevator_anim.get_animation("GoingUp").length + 1), "timeout");
	elevator_anim.play("DoorOpens");
	currentFloor = 1
	get_node("Elevator/Elevator Buttons").enabled = true

func closeDoor():
	elevator_anim.play("DoorCloses");
	doorOpen = false;
func openDoor():
	elevator_anim.play("DoorOpens");
	doorOpen = true;
