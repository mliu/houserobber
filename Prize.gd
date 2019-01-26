extends Area2D

export var prize_value = 100
signal collected(prize_node)

func _ready():
	pass

func _process(delta):
	for body in self.get_overlapping_bodies():
		if body.is_in_group("player"):
			emit_signal("collected", self.get_path())
			queue_free()
	pass
