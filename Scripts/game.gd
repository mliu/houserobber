extends Node

export (int) var max_prizes = 20
export(String, "cute", "scary") var level_type = Enums.CUTE

onready var soundplayer = $SoundPlayer
onready var timer = $CanvasLayer/Timer
onready var prize = preload("res://Scenes/Prize.tscn")

var screensize
var noise_level = 0.0
var max_noise_level = 1500.0
var total_prize_value = 0.0
var collected_prizes = []

func _ready():
	# Dont Allow quitting by x and closing game (set this true in Game Start Screen)
	# Used to limit quit to Game Start Screen
#	get_tree().set_auto_accept_quit(false)

	# Hook up noise signals
	for node in $NoiseItems.get_children():
		node.connect("make_noise", self, "_increase_noise")
	
	randomize()
	
	# play theme
	if level_type == Enums.CUTE:
		soundplayer.get_node("CuteTheme").play()
	else:
		soundplayer.get_node("ScaryTheme").play()
	
	# get Screensize and determine player size
	screensize = get_viewport().size
	spawn_prizes()
	$Entrance.connect("exit", self, "_on_exit")

func _process(delta):
	if $CanvasLayer/EscapeDialog/ScreenContainer/RestartButton.is_pressed():
		get_tree().reload_current_scene()
	pass

func spawn_prizes():
	if (max_prizes > $prize_spawn_container.get_child_count()):
		max_prizes = $prize_spawn_container.get_child_count() / 2
	
	var children = $prize_spawn_container.get_children()
	for i in range(max_prizes):
		var idx = rand_range(0, children.size())
		var game_prize = prize.instance()
		game_prize.level_type = level_type
		game_prize.connect("collected", self, "_collect_prize")
		$prize_container.add_child(game_prize)
		game_prize.position = children[idx].position - game_prize.get_extents()
		children.remove(idx)

func _increase_noise(decibels):
	noise_level += decibels
	$CanvasLayer/HealthBar.on_update_health(noise_level / max_noise_level)
	if noise_level > max_noise_level:
		get_tree().paused = true
		$CanvasLayer/GameOverDialog.visible = true
		noise_level = 0.0

func _collect_prize(prize_node):
	collected_prizes.append(prize_node)
	soundplayer.get_node("Ding").play()
	
func _on_exit():
	# Only exit if it's past 10 seconds
	if timer.elapsed > 10 and !$CanvasLayer/EscapeDialog.visible:
		get_tree().paused = true
		$CanvasLayer/EscapeDialog.visible = true
		var grid = $CanvasLayer/EscapeDialog/ScreenContainer/GridContainer
		for prize_path in collected_prizes:
			var prize_image = load(prize_path).instance()
			grid.add_child(prize_image)
			yield(get_tree().create_timer(0.25), "timeout")
		pass
	