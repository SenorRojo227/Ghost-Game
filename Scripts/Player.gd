extends CharacterBody2D

@export var movement_component : MovementComponent

var float_distance : float = 0
var float_direction : float = -1

signal game_tick

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	# Read inputs
	if Input.is_action_just_pressed("up"):
		check_input(movement_component.Direction.UP)
	elif Input.is_action_just_pressed("down"):
		check_input(movement_component.Direction.DOWN)
	elif Input.is_action_just_pressed("right"):
		check_input(movement_component.Direction.RIGHT)
	elif Input.is_action_just_pressed("left"):
		check_input(movement_component.Direction.LEFT)
	
	movement_component.move(self)

# Set blink intervals
func _on_blink_timer_timeout() -> void:
	$AnimatedSprite2D.play()

# Move player up and down automatically
func _on_float_timer_timeout() -> void:
	$AnimatedSprite2D.position.y += float_distance
	float_distance += float_direction
	if abs(float_distance) > 2:
		float_direction *= -1
	$ShadowComponent.scale.x -= 0.1 * float_direction

func check_input(direction) -> void:
	if !movement_component.check_if_moving():
		movement_component.set_direction(direction)
		game_tick.emit()
