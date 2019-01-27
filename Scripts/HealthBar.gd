extends Node2D

var percentage_fill = 0

onready var tween = $Tween

func _ready():
	pass
	
func _process(delta):
	$ProgressBar.value = percentage_fill

func on_update_health(new_value):
	percentage_fill = new_value * 100
