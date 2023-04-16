extends Interactable

onready var elevator_anim = get_parent().get_parent().get_node("AnimationPlayer");
onready var elevator = get_parent().get_parent();

export var prompt_message = ""
export var prompt_action = "ui_interact"
export var enabled = true;

func _ready():
	pass
		
func get_prompt():
	if elevator.currentFloor == 1:
		prompt_message = "Go Up";
	elif elevator.currentFloor == 2:
		prompt_message = "Go Down"
	var key_name = "";
	for action in InputMap.get_action_list(prompt_action):
		if action is InputEventKey:
			key_name = "E"
	return prompt_message + " [" + key_name + "]";

func interact():
	if elevator.currentFloor == 1:
		if enabled:
			elevator.Go_Up();
	elif elevator.currentFloor == 2:
		if enabled:
			elevator.Go_Down();
