extends Area2D

signal exit

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	for b in self.get_overlapping_bodies():
		if b.is_in_group("player"):
			emit_signal("exit")
	pass
