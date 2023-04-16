#class_name Interactable
extends Interactable

onready var elevator_anim = get_parent().get_node("AnimationPlayer");
onready var elevator = get_parent()
signal interacted(body)
export var prompt_message = "Call for elevator"
export var prompt_action = "ui_interact"

func _ready():
	pass
		
func get_prompt():
	var key_name = "";
	for action in InputMap.get_action_list(prompt_action):
		if action is InputEventKey:
			key_name = "E"
	return prompt_message + " [" + key_name + "]";

func interact():
	elevator.toggle_door();
	
