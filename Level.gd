extends Spatial

onready var ghost = null;
onready var dest = null;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var dooropen_animation = get_node("elevator/AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	dooropen_animation.play("Door0Opens")
	dooropen_animation.play("Door1Opens")
	
	

func _process(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
