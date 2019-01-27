extends Area2D

export var prize_value = 100

var prize_directories = {
	"cute": {
		"bear": "res://Scenes/bear.tscn",
		"banana": "res://Scenes/banana.tscn",
		"book": "res://Scenes/book.tscn"
	},
	"scary": {
		"bear": "res://Scenes/necklace1.tscn",
		"banana": "res://Scenes/necklace2.tscn",
		"book": "res://Scenes/necklace3.tscn"
	}
}
onready var level_type
var prize_scenes
var selected_scene

signal collected(prize_node)

func get_extents():
	return $CollisionShape2D.shape.extents

func _ready():
	if level_type == Enums.CUTE:
		prize_scenes = prize_directories.cute
	else:
		prize_scenes = prize_directories.scary

	selected_scene = prize_scenes.keys()[rand_range(0, prize_scenes.size())]
	var texture = load(prize_scenes[selected_scene]).instance()
	var shape = RectangleShape2D.new()
	shape.extents = texture.texture.get_size() / 2
	$CollisionShape2D.shape = shape
	$CollisionShape2D.position = texture.texture.get_size() / 2
	self.add_child(texture)
	
	# Adjust particle position and size
	$Particles.process_material.emission_box_extents = Vector3(shape.extents.x, shape.extents.y, 1)
	$Particles.position = texture.texture.get_size() / 2
	pass

func _process(delta):
	for body in self.get_overlapping_bodies():
		if body.is_in_group("player"):
			emit_signal("collected", prize_scenes[selected_scene])
			queue_free()
	pass
