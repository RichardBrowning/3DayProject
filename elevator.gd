extends Spatial

export var doorOpen = false
onready var elevator_anim = $AnimationPlayer

func toggle_door():
	#get door node and its status
	if doorOpen:
		elevator_anim.play("DoorCloses");
	else:
		elevator_anim.play("DoorOpens");
	doorOpen = !doorOpen
		
		
