extends Interactable

onready var elevator_anim = get_parent().get_node("AnimationPlayer");
onready var elevator = get_parent()

var prompt_message = ""
var enabled = true
export var prompt_action = "ui_interact"

func _ready():
	pass
		
func get_prompt():
	if elevator.doorOpen:
		prompt_message = "Dismiss Elevator";
	else:
		prompt_message = "Call Elevator"
	var key_name = "";
	for action in InputMap.get_action_list(prompt_action):
		if action is InputEventKey:
			key_name = "E"
	return prompt_message + " [" + key_name + "]";

func interact():
	if enabled:
		elevator.toggle_door();
