extends Node

var time_start = 0
var time_now = 0
var time_end = 100
var elapsed = 0
var remaining = time_end
var time_warning_1 = 45
var time_warning_2 = 10
var bbcode_time

func _ready():
	time_start = OS.get_unix_time()
	$AnimationPlayer.play("Tick")
	set_process(true)

func _process(delta):
	_time_remaining()
	_maybe_change_color()

func _time_remaining():
	time_now = OS.get_unix_time()
	elapsed = time_now - time_start
	remaining = time_end - elapsed
	$TimeLeft.text = str(remaining)

func _maybe_change_color():
	if remaining < time_warning_2:
		$TimeLeft.add_color_override("font_color", Color("#9b2f1f"))
	elif remaining < time_warning_1:
		$TimeLeft.add_color_override("font_color", Color("#ff9b19"))
	else:
		$TimeLeft.add_color_override("font_color", Color("#3a3cad"))