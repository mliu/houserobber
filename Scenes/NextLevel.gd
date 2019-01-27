extends TouchScreenButton

export (String, FILE, "*.tscn,*.scn") var next_level = null

func _ready():
	self.connect("pressed", self, "_on_press")
	pass

func _on_press():
	if next_level != null:
		get_tree().change_scene(next_level)
		get_tree().paused = false
	pass
