extends CharacterBody2D

@export var initial_x : int
@export var initial_y : int

enum direction {IDLE, UP, DOWN, LEFT, RIGHT}

var move_direction
var float_distance
var float_direction


func _ready() -> void:
	float_distance = 0
	float_direction = -1
	position.x = 48 * initial_x + 24
	position.y = 48 * initial_y + 16
	move_direction = direction.IDLE

func _process(delta: float) -> void:
	
	# Detect direction player is moving
	match move_direction:
		direction.IDLE:
			# Change animation based on user input
			if Input.is_action_just_pressed("up"):
				$AnimatedSprite2D.animation = "up_idle"
				$AnimatedSprite2D.flip_h = false
				move_direction = direction.UP
				initial_y -= 1
			elif Input.is_action_just_pressed("down"):
				$AnimatedSprite2D.animation = "down_idle"
				$AnimatedSprite2D.flip_h = false
				move_direction = direction.DOWN
				initial_y += 1
			elif Input.is_action_just_pressed("right"):
				$AnimatedSprite2D.animation = "side_idle"
				$AnimatedSprite2D.flip_h = false
				move_direction = direction.RIGHT
				initial_x += 1
			elif Input.is_action_just_pressed("left"):
				$AnimatedSprite2D.animation = "side_idle"
				$AnimatedSprite2D.flip_h = true
				move_direction = direction.LEFT
				initial_x -= 1
		# Move the player each frame until destination is reached
		direction.UP:
			position.y -= 2
			if position.y == (48 * initial_y + 16):
				move_direction = direction.IDLE
		direction.DOWN:
			position.y += 2
			if position.y == (48 * initial_y + 16):
				move_direction = direction.IDLE
		direction.RIGHT:
			position.x += 2
			if position.x == (48 * initial_x + 24):
				move_direction = direction.IDLE
		direction.LEFT:
			position.x -= 2
			if position.x == (48 * initial_x + 24):
				move_direction = direction.IDLE
	
	# Start dialogue
	if Input.is_action_just_pressed("ui_accept"):
		# Check if a dialog is already running
		if Dialogic.current_timeline == null:
			Dialogic.start('Test')
			get_viewport().set_input_as_handled()

func _physics_process(delta: float) -> void:
	pass

# Set blink intervals
func _on_blink_timer_timeout() -> void:
	$AnimatedSprite2D.play()

# Move player up and down automatically
func _on_float_timer_timeout() -> void:
	$AnimatedSprite2D.position.y += float_distance
	float_distance += float_direction
	if abs(float_distance) > 2:
		float_direction *= -1
	$Shadow.scale.x -= 0.1 * float_direction
