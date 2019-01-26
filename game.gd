extends Node

onready var tree = preload("res://tree.tscn")
onready var prize = preload("res://Prize.tscn")

var screensize
var noise_level = 0.0
var max_noise_level = 100.0
var total_prize_value = 0.0


func _ready():
	# Dont Allow quitting by x and closing game (set this true in Game Start Screen)
	# Used to limit quit to Game Start Screen
#	get_tree().set_auto_accept_quit(false)
	
	randomize()
	
	# get Screensize and determine player size
	screensize = get_viewport().size
	spawn_trees(rand_range(1,10))
	spawn_prizes(10)
	$Entrance.connect("exit", self, "_on_exit")

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func spawn_trees(num):	
	for i in range(num):
		var game_tree = tree.instance()
		game_tree.connect("make_noise", self, "_increase_noise")
		game_tree.set_scale(Vector2(2,2))
		
		# Set Random position of npc
		game_tree.position = (Vector2(rand_range(75, screensize.x - 75), rand_range(75 , screensize.y - 75)))
		$tree_container.add_child(game_tree)

func spawn_prizes(num):	
	for i in range(num):
		var game_prize = prize.instance()
		game_prize.connect("collected", self, "_collect_prize")
		
		# Set Random position of npc
		game_prize.position = (Vector2(rand_range(75, screensize.x - 75), rand_range(75 , screensize.y - 75)))
		$prize_container.add_child(game_prize)

func _increase_noise(decibels):
	noise_level += decibels
	$CanvasLayer/HealthBar.on_update_health(noise_level / max_noise_level)
	# TODO: game over

func _collect_prize(prize_value):
	total_prize_value += prize_value
	$CanvasLayer/PrizeValueCounter.on_update_prize_value(total_prize_value)
	
func _on_exit():
	# Only exit if it's past 30 seconds
	
	