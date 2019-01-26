extends Node

onready var tween = $Tween
var score = 0

func _ready():
	pass


func _process(delta):
	 $PrizeValue.text = str(ceil(score))

func on_update_prize_value(new_value):
	tween.interpolate_property(self, "score", score, new_value, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if not tween.is_active():
		tween.start()
	pass