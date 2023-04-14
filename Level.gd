extends Spatial

onready var ghost = null;
onready var dest = null;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var dooropen_animation = get_node("elevator/AnimationPlayer")
dooropen_animation.set_loop(true)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	dooropen_animation.play("Door0Opens");
	dooropen_animation.play("Door1Opens");

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
