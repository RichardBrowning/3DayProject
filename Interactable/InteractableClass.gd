extends Node

class_name Interactable

func get_interaction_text():
	return "Interaction";
	
func interact():
	print("interact with %s" % name);
