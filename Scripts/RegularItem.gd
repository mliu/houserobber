extends StaticBody2D

func _ready():
	var texture = $TextureRect
	var shape = RectangleShape2D.new()
	shape.extents = texture.texture.get_size() / 2
	$CollisionShape2D.shape = shape
	$CollisionShape2D.position = texture.texture.get_size() / 2