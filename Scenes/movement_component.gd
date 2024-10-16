extends Node2D
class_name MovementComponent

@export var grid_pos : Vector2
@export var grid_component : GridComponent

enum Direction {IDLE, UP, DOWN, LEFT, RIGHT}

const movement_buffer_max_size: int = 2
var movement_buffer : Array[Direction] = []
var movement_done: bool = false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	print(grid_pos)
	handle_movement()
	
func handle_movement():
	if movement_done == true:
		movement_buffer.pop_front()
	
	

func add_to_movement_buffer(direction):
	if movement_buffer.size() >= movement_buffer_max_size:
		if is_opposite_movement(direction, movement_buffer[1]):
			movement_buffer.pop_back()
			#movement_done = true
		else:
			print("Too many movements for the buffer. Discarded: " 
				+ Direction.keys()[direction])
	else:
		handle_opposite_movement_inputs(direction)
		movement_buffer.append(direction)
	
func handle_opposite_movement_inputs(movement_direction):
	if movement_buffer.size() == 0:
		return
		
	if is_opposite_movement(movement_direction, movement_buffer[0]):
		movement_buffer.pop_front()
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
