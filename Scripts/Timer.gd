extends Node

var time_start = 0
var time_now = 0
var time_end = 5*60
var elapsed = 0
var remaining = time_end

func _ready():
	time_start = OS.get_unix_time()
	set_process(true)

func _process(delta):
	time_now = OS.get_unix_time()
	elapsed = time_now - time_start
	remaining = time_end - elapsed
	var str_remaining = "%02d : %02d" % [remaining / 60, remaining % 60]
	$TimeLeft.text = str_remaining
	
	if remaining < (5*60 - 2):
		$TimeLeft.add_color_override("font_color", "yellow")
	elif remaining < (5*60 - 5):
		$TimeLeft.add_color_override("font_color", "red")
