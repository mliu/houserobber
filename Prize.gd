extends Area2D

export var prize_value = 100

var type
var prize_types = {
	"necklace1": "res://Scenes/necklace1.tscn",
	"necklace2": "res://Scenes/necklace2.tscn"
}

signal collected(prize_node)

func _ready():
	type = prize_types.keys()[rand_range(0, prize_types.size())]
	self.add_child(load(prize_types[type]).instance())
	pass

func _process(delta):
	for body in self.get_overlapping_bodies():
		if body.is_in_group("player"):
			emit_signal("collected", prize_types[type])
			queue_free()
	pass
