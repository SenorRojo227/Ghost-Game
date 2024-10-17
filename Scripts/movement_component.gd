extends Node2D
class_name MovementComponent

@export var grid_pos : Vector2
@export var grid_component : GridComponent

enum Direction {IDLE, UP, DOWN, LEFT, RIGHT}

var is_moving : bool = false
var is_flipped : bool = false
var animation : String
var current_direction : Vector2

func _ready() -> void:
	get_parent().position.x = 48 * grid_pos.x + 24
	get_parent().position.y = 48 * grid_pos.y + 16

func set_direction(direction : Direction):
	if is_moving:
		return
	
	match direction:
		Direction.UP:
			animation = "up_idle"
			current_direction = Vector2(0, -2)
			is_flipped = false
			grid_pos.y -= 1
		Direction.DOWN:
			animation = "down_idle"
			current_direction = Vector2(0, 2)
			is_flipped = false
			grid_pos.y += 1
		Direction.RIGHT:
			animation = "side_idle"
			current_direction = Vector2(2, 0)
			is_flipped = false
			grid_pos.x += 1
		Direction.LEFT:
			animation = "side_idle"
			current_direction = Vector2(-2, 0)
			is_flipped = true
			grid_pos.x -= 1
	is_moving = true

func move(entity : CharacterBody2D, rotate : bool = false):
	if !is_moving:
		return
	entity.position += current_direction
	entity.get_node("AnimatedSprite2D").animation = animation
	entity.get_node("AnimatedSprite2D").flip_h = is_flipped
	if rotate && animation == "side_idle":
		entity.get_node("AnimatedSprite2D").rotation_degrees += 15
	if entity.position.x == 48 * grid_pos.x + 24 && entity.position.y == 48 * grid_pos.y + 16:
		is_moving = false
		entity.rotation_degrees = 0
