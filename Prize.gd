extends Area2D

export var prize_value = 100
signal collected(prize_value)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	for body in self.get_overlapping_bodies():
		if body.is_in_group("player"):
			emit_signal("collected", prize_value)
			queue_free()
	pass
