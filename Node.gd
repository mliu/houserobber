extends Node

var time_start = 0
var time_now = 0
var time_end = 5*60

func _ready():
	time_start = OS.get_unix_time()
	set_process(true)


func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var remaining = time_end - elapsed
	var minutes = remaining / 60
	var seconds = remaining % 60
	var str_remaining = "%02d : %02d" % [minutes, seconds]
	$TimeLeft.text = str_remaining

