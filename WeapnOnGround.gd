extends Interactable

onready var player = get_parent().get_node("CharBody");
var prompt_message = "Pick Up the Weapon"
var enabled = true
export var prompt_action = "ui_interact"
export var pickedUp = false

func _ready():
	pass
		
func get_prompt():
	var key_name = "";
	for action in InputMap.get_action_list(prompt_action):
		if action is InputEventKey:
			key_name = "E"
	return prompt_message + " [" + key_name + "]";

func interact():
	player.has_weapon = true;
	self.visible = false;
	translate(Vector3(0, 0, 0.15))
	get_parent().get_node("Enemy").isMoving = true;
