extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var noise = 10
signal make_noise(decibels)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	for b in get_overlapping_bodies(): 
		if b.is_in_group("player"):
			emit_signal("make_noise", noise)
	pass
