extends Node2D
class_name MovementComponent

@export var grid_pos : Vector2
@export var grid_component : GridComponent
@export var character_type : GridComponent.OccupantType

enum Direction {IDLE, UP, DOWN, LEFT, RIGHT}

const movement_buffer_max_size: int = 2
var movement_buffer : Array[Direction] = []
var movement_done: bool = true

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	handle_movement()
	move_character()
	
func handle_movement():
	if movement_buffer.size() == 0 || movement_done == false:
		return
	
	var temp_grid_pos = grid_pos
	match movement_buffer[0]:
		Direction.UP:
			temp_grid_pos.y -= 1
		Direction.DOWN:
			temp_grid_pos.y += 1
		Direction.RIGHT:
			temp_grid_pos.x += 1
		Direction.LEFT:
			temp_grid_pos.x -= 1

	if grid_component.claim_grid_point(grid_pos, temp_grid_pos, character_type):
		movement_done = false
		grid_pos = temp_grid_pos
	
func move_character():
	if movement_buffer.size() == 0:
		return
		
	match movement_buffer[0]:
		Direction.UP:
			get_parent().position.y -= 2
			if get_parent().position.y == (48 * grid_pos.y + 16):
				movement_buffer.pop_front()
				movement_done = true
		Direction.DOWN:
			get_parent().position.y += 2
			if get_parent().position.y == (48 * grid_pos.y + 16):
				movement_buffer.pop_front()
				movement_done = true
		Direction.RIGHT:
			get_parent().position.x += 2
			if get_parent().position.x == (48 * grid_pos.x + 24):
				movement_buffer.pop_front()
				movement_done = true
		Direction.LEFT:
			get_parent().position.x -= 2
			if get_parent().position.x == (48 * grid_pos.x + 24):
				movement_buffer.pop_front()
				movement_done = true

func add_to_movement_buffer(direction):
	if !(movement_buffer.size() >= movement_buffer_max_size):
		movement_buffer.append(direction)
	
