extends RayCast
#var current_collider
onready var prompt = $Prompt; 

func _physics_process(delta):
	prompt.text = ""
	if is_colliding():
		var detected = get_collider();
		if detected is Interactable:
			prompt.text = detected.get_prompt();
			if Input.is_action_just_pressed("ui_interact"):
				detected.interact();

func _ready():
	add_exception(owner)
