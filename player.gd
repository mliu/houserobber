extends KinematicBody2D

export (int) var speed = 300

# Player Velocity
var velocity = Vector2(0,0)
var analog_velocity = Vector2(0,0)

func _ready():
	pass

func _physics_process(delta):
	
	velocity = Vector2()
	
	# Process Input Keys
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1

	if Input.is_action_pressed("ui_up"):
		velocity.y -=1

	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		
	# Add in analog_velocity
	velocity += analog_velocity	

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	if velocity.x > 0:
		$sprite.play("WalkRight")
	elif velocity.x < 0:
		$sprite.play("WalkLeft")
	elif velocity.y != 0:
		$sprite.play("Idle")	
	else:
		$sprite.play("Idle")
		# No idle animations
#		if $sprite/anim.current_animation == "Right":
#			$sprite/anim.play("Idle-Right")
#		if $sprite/anim.current_animation == "Left":
#			$sprite/anim.play("Idle-Left")
#		if $sprite/anim.current_animation == "Up":
#			$sprite/anim.play("Idle-Up")
#		if $sprite/anim.current_animation == "Down":
#			$sprite/anim.play("Idle-Down")
		#$sprite/anim.stop()	
	
	move_and_slide(velocity)
	
func analog_force_change(inForce, inStick):
	if(inStick.get_name()=="AnalogRight") or (inStick.get_name()=="AnalogLeft"):
		if (inForce.length() < 0.1):
			analog_velocity = Vector2(0,0) 
		else:
			analog_velocity = Vector2(inForce.x,-inForce.y)
		
		#Convert analog velocity to 0 , 1 , -1 
		analog_velocity = analog_velocity.normalized()
#		analog_velocity.x = int(round(analog_velocity.x))
#		analog_velocity.y = int(round(analog_velocity.y))
		
		analog_velocity.x = stepify(analog_velocity.x, 1)
		analog_velocity.y = stepify(analog_velocity.y, 1)
#		print(analog_velocity)
		
