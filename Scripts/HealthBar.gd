extends Node2D

var percentage_fill = 1

onready var tween = $Tween

func _ready():
	pass
	
func _process(delta):
	$ProgressBar.value = percentage_fill

func on_update_health(new_value):
	if tween.is_active():
		tween.stop_all()
	tween.interpolate_property(self, "percentage_fill", percentage_fill, new_value, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pass