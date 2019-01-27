extends Area2D

export var prize_value = 100
export(String, "cute", "scary") var level_type = Enums.CUTE

var prize_directories = {
	"cute": {
		"bear": "res://Scenes/bear.tscn",
		"banana": "res://Scenes/banana.tscn",
		"book": "res://Scenes/book.tscn"
	},
	"scary": {
		"bear": "res://Scenes/bear.tscn",
		"banana": "res://Scenes/banana.tscn",
		"book": "res://Scenes/book.tscn"
	}
}
var prize_scenes
var selected_scene

signal collected(prize_node)

func _ready():
	if level_type == Enums.CUTE:
		prize_scenes = prize_directories.cute
	else:
		prize_scenes = prize_directories.scary

	selected_scene = prize_scenes.keys()[rand_range(0, prize_scenes.size())]
	self.add_child(load(prize_scenes[selected_scene]).instance())
	pass

func _process(delta):
	for body in self.get_overlapping_bodies():
		if body.is_in_group("player"):
			emit_signal("collected", prize_scenes[selected_scene])
			queue_free()
	pass
