extends Spatial
# Declare member variables here. Examples:
onready var game_over = $CharBody/Neck/Camera/GameOver
onready var game_passed = $CharBody/Neck/Camera/GameComplete
onready var main_screen = $CharBody/Neck/Camera/MainScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	#dooropen_animation.play("DoorOpens")
	pass

func _process(delta):
	pass
	#change the resolution of the windows
	main_screen.set_size( OS.get_real_window_size() );
	game_passed.set_size( OS.get_real_window_size() );
	game_over.set_size( OS.get_real_window_size() );
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
