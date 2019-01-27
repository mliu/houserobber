extends Node

var time_start = 0
var time_now = 0
var time_end = 5*60
var elapsed = 0
var remaining = time_end
var time_warning_1 = 2*60
var time_warning_2 = 60
var bbcode_time

func _ready():
	time_start = OS.get_unix_time()
	set_process(true)

func _process(delta):
	_time_remaining()


func _time_remaining():
	time_now = OS.get_unix_time()
	elapsed = time_now - time_start
	remaining = time_end - elapsed
	var str_remaining = "%02d : %02d" % [remaining / 60, remaining % 60]
	$TimeLeft.bbcode_text = _time_string_bbcode(str_remaining)


func _time_string_bbcode(str_time):
	var default_time = "[center][b]%s[/b][/center]" % str_time
	if remaining < time_warning_2:
		bbcode_time = "[color=red]" + default_time + "[/color]"
	elif remaining < time_warning_1:
		bbcode_time = "[color=yellow]" + default_time + "[/color]"
	else:
		bbcode_time = default_time
	return bbcode_time
	
func _time_warning_shake():
	if remaining < time_warning_2:
		print(1)