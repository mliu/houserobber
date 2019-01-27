extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if $ScreenContainer/RestartButton.is_pressed() && $ScreenContainer.visible:
		get_tree().reload_current_scene()
		get_tree().paused = false
		print(get_tree().paused)
