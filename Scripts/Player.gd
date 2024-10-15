extends CharacterBody2D

@export var initial_x : int
@export var initial_y : int

enum direction {IDLE, UP, DOWN, LEFT, RIGHT}

var move_direction
var movement_done
var fifo_movement_list
var movement_buffer_size = 2
var float_distance
var float_direction


func _ready() -> void:
	movement_done = true
	float_distance = 0
	float_direction = -1
	position.x = 48 * initial_x + 24
	position.y = 48 * initial_y + 16
	move_direction = direction.IDLE
	fifo_movement_list = []

func _process(delta: float) -> void:
	
	# Read inputs
	process_movement()
	
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
	
func process_movement():
	print(fifo_movement_list)
	if movement_done:
		fifo_movement_list.pop_front()
		
	receive_movement_inputs()
	
	if fifo_movement_list.size() > 0:
		set_direction()
		set_target_tile()
		move_character()
		
	
func receive_movement_inputs():
	if Input.is_action_just_pressed("up"):
		add_movement_to_buffer(direction.UP)
	elif Input.is_action_just_pressed("down"):
		add_movement_to_buffer(direction.DOWN)
	elif Input.is_action_just_pressed("right"):
		add_movement_to_buffer(direction.RIGHT)
	elif Input.is_action_just_pressed("left"):
		add_movement_to_buffer(direction.LEFT)
		
func add_movement_to_buffer(movement_direction):
	if fifo_movement_list.size() >= movement_buffer_size:
		if is_opposite_movement(movement_direction, fifo_movement_list[1]):
			fifo_movement_list.pop_back()
			print("Removed from back of stack")
			#movement_done = true
		else:
			print("Too many movements for the buffer. Discarded: " 
				+ direction.keys()[movement_direction])
	else:
		handle_opposite_movement_inputs(movement_direction)
		fifo_movement_list.append(movement_direction)
	
func handle_opposite_movement_inputs(movement_direction):
	if fifo_movement_list.size() == 0:
		return
		
	if is_opposite_movement(movement_direction, fifo_movement_list[0]):
		fifo_movement_list.pop_front()
		movement_done = true

func is_opposite_movement(movement_direction_input, stored_direction):
	match movement_direction_input:
		direction.UP:
			if stored_direction == direction.DOWN:
				return true
		direction.DOWN:
			if stored_direction == direction.UP:
				return true
		direction.RIGHT:
			if stored_direction == direction.LEFT:
				return true
		direction.LEFT:
			if stored_direction == direction.RIGHT:
				return true
	return false
	
func set_direction():	
	if fifo_movement_list.size() == 0 || !movement_done:
		return
	
	match fifo_movement_list[0]:
		direction.UP:
			$AnimatedSprite2D.animation = "up_idle"
			$AnimatedSprite2D.flip_h = false
		direction.DOWN:
			$AnimatedSprite2D.animation = "down_idle"
			$AnimatedSprite2D.flip_h = false
		direction.RIGHT:
			$AnimatedSprite2D.animation = "side_idle"
			$AnimatedSprite2D.flip_h = false
		direction.LEFT:
			$AnimatedSprite2D.animation = "side_idle"
			$AnimatedSprite2D.flip_h = true
		_:
			print("Invalid movement type received.")
			fifo_movement_list.pop_front()
			return
	move_direction = fifo_movement_list[0]
	
	
func set_target_tile():	
	if !movement_done:
		return
	else:
		movement_done = false
		
	match fifo_movement_list[0]:
		direction.UP:
			initial_y -= 1
		direction.DOWN:
			initial_y += 1
		direction.RIGHT:
			initial_x += 1
		direction.LEFT:
			initial_x -= 1
		_:
			return
	
func move_character():
	match fifo_movement_list[0]:
		direction.UP:
			position.y -= 2
			if position.y == (48 * initial_y + 16):
				move_direction = direction.IDLE
				movement_done = true
		direction.DOWN:
			position.y += 2
			if position.y == (48 * initial_y + 16):
				move_direction = direction.IDLE
				movement_done = true
		direction.RIGHT:
			position.x += 2
			if position.x == (48 * initial_x + 24):
				move_direction = direction.IDLE
				movement_done = true
		direction.LEFT:
			position.x -= 2
			if position.x == (48 * initial_x + 24):
				move_direction = direction.IDLE
				movement_done = true
	
