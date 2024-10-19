extends Node2D
class_name MovementComponent

signal advance_level

enum Direction {UP, DOWN, LEFT, RIGHT}

@export var grid_pos : Vector2i
@export var grid_component : GridComponent
@export var initial_direction : Direction

var is_moving : bool = false
var is_flipped : bool = false
var animation : String
var current_direction : Vector2
var new_pos : Vector2i
var new_tile : int

func _ready() -> void:
	get_parent().position.x = 48 * grid_pos.x + 24
	get_parent().position.y = 48 * grid_pos.y + 16
	set_direction(initial_direction)
	is_moving = false

func check_if_moving() -> bool:
	return is_moving

# Returns the current direction or inverted direction
func get_direction(flip_direction = false) -> Direction:
	match animation:
		"up_idle":
			if !flip_direction:
				return Direction.UP
			return Direction.DOWN
		"down_idle":
			if !flip_direction:
				return Direction.DOWN
			return Direction.UP
		"side_idle":
			if (!is_flipped && !flip_direction) || (is_flipped && flip_direction):
				return Direction.RIGHT
	return Direction.LEFT

func set_direction(direction : Direction) -> void:
	
	if Dialogic.current_timeline == null:
		#Recalibrate new_pos
		new_pos = grid_pos
		
		# Disregard if already moving
		if is_moving:
			return
		
		# Set properties based on direction moved
		match direction:
			Direction.UP:
				animation = "up_idle"
				current_direction = Vector2(0, -2)
				is_flipped = false
				new_pos.y = grid_pos.y - 1
			Direction.DOWN:
				animation = "down_idle"
				current_direction = Vector2(0, 2)
				is_flipped = false
				new_pos.y = grid_pos.y + 1
			Direction.RIGHT:
				animation = "side_idle"
				current_direction = Vector2(2, 0)
				is_flipped = false
				new_pos.x = grid_pos.x + 1
			Direction.LEFT:
				animation = "side_idle"
				current_direction = Vector2(-2, 0)
				is_flipped = true
				new_pos.x = grid_pos.x - 1
		
		#Get tilemap cell
		new_tile = get_parent().get_parent().get_node("TileMapLayer").get_cell_tile_data(new_pos).get_custom_data("interact_type")
		if new_tile == 1:
			is_moving = true
		elif new_tile == 2:
			advance_level.emit()

func move(entity : CharacterBody2D, rotate : bool = false) -> void:
	if Dialogic.current_timeline == null:
		entity.get_node("AnimatedSprite2D").animation = animation
		entity.get_node("AnimatedSprite2D").flip_h = is_flipped
		
		if !is_moving:
			return
			
		grid_pos = new_pos
		entity.position += current_direction
		if rotate && animation == "side_idle":
			entity.get_node("AnimatedSprite2D").rotation_degrees += 15 * (current_direction.x / 2)
		if entity.position.x == 48 * grid_pos.x + 24 && entity.position.y == 48 * grid_pos.y + 16:
			is_moving = false
			entity.rotation_degrees = 0
