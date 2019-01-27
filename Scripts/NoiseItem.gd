extends Area2D

export var noise = 2
export (Texture) var active = null
signal make_noise(decibels)

func _ready():
	var texture = $TextureRect
	var shape = RectangleShape2D.new()
	shape.extents = texture.texture.get_size() / 2
	$CollisionShape2D.shape = shape
	$CollisionShape2D.position = texture.texture.get_size() / 2

func _process(delta):
	for b in get_overlapping_bodies(): 
		if b.is_in_group("player"):
			if active != null:
				$TextureRect.texture = active
			emit_signal("make_noise", noise)