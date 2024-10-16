extends CharacterBody2D

@export var grid_pos : Vector2
@export var map_path : String

var map_points: Array[Vector2]

enum Direction {IDLE, UP, DOWN, LEFT, RIGHT}

var move_direction : Direction = Direction.IDLE
var movement_done : bool = true
var fifo_movement_list : Array[Direction] = []
var movement_buffer_size = 2
var float_distance : float = 0
var float_direction : float = -1


func _ready() -> void:
	# Load the map
	map_points = load(map_path).new().get_map_points()
	# Get into starting position in the centre of the screen
	position.x = 48 * grid_pos.x + 24
	position.y = 48 * grid_pos.y + 16
	

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
	if movement_done:
		fifo_movement_list.pop_front()
		
	receive_movement_inputs()
	
	if fifo_movement_list.size() > 0:
		set_direction()
		move_character()
		
	
func receive_movement_inputs():
	if Input.is_action_just_pressed("up"):
		add_movement_to_buffer(Direction.UP)
	elif Input.is_action_just_pressed("down"):
		add_movement_to_buffer(Direction.DOWN)
	elif Input.is_action_just_pressed("right"):
		add_movement_to_buffer(Direction.RIGHT)
	elif Input.is_action_just_pressed("left"):
		add_movement_to_buffer(Direction.LEFT)
		
func add_movement_to_buffer(movement_direction):
	if fifo_movement_list.size() >= movement_buffer_size:
		if is_opposite_movement(movement_direction, fifo_movement_list[1]):
			fifo_movement_list.pop_back()
			print("Removed from back of stack")
			#movement_done = true
		else:
			print("Too many movements for the buffer. Discarded: " 
				+ Direction.keys()[movement_direction])
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
		Direction.UP:
			if stored_direction == Direction.DOWN:
				return true
		Direction.DOWN:
			if stored_direction == Direction.UP:
				return true
		Direction.RIGHT:
			if stored_direction == Direction.LEFT:
				return true
		Direction.LEFT:
			if stored_direction == Direction.RIGHT:
				return true
	return false
	
func set_animation_direction(animation, flip_boolean):
	$AnimatedSprite2D.animation = animation
	$AnimatedSprite2D.flip_h = flip_boolean
	
func set_direction():	
	if !movement_done:
		return
	else:
		movement_done = false
		
	var temp_grid_pos = grid_pos
	match fifo_movement_list[0]:
		Direction.UP:
			set_animation_direction("up_idle", false)
			temp_grid_pos.y -= 1
		Direction.DOWN:
			set_animation_direction("down_idle", false)
			temp_grid_pos.y += 1
		Direction.RIGHT:
			set_animation_direction("side_idle", false)
			temp_grid_pos.x += 1
		Direction.LEFT:
			set_animation_direction("side_idle", true)
			temp_grid_pos.x -= 1
		_:
			print("Invalid movement direction provided!")
			return
	if not_going_to_hit_wall(temp_grid_pos):
		grid_pos = temp_grid_pos
		move_direction = fifo_movement_list[0]
	else:
		fifo_movement_list.pop_front()
		movement_done = true
	
func move_character():
	if fifo_movement_list.size() == 0:
		return
		
	match fifo_movement_list[0]:
		Direction.UP:
			position.y -= 2
			if position.y == (48 * grid_pos.y + 16):
				move_direction = Direction.IDLE
				movement_done = true
		Direction.DOWN:
			position.y += 2
			if position.y == (48 * grid_pos.y + 16):
				move_direction = Direction.IDLE
				movement_done = true
		Direction.RIGHT:
			position.x += 2
			if position.x == (48 * grid_pos.x + 24):
				move_direction = Direction.IDLE
				movement_done = true
		Direction.LEFT:
			position.x -= 2
			if position.x == (48 * grid_pos.x + 24):
				move_direction = Direction.IDLE
				movement_done = true
	
func not_going_to_hit_wall(position_to_move_to):
	return !map_points.has(position_to_move_to)
	
