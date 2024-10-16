extends CharacterBody2D

@export var movement_component : MovementComponent

var float_distance : float = 0
var float_direction : float = -1

func _ready() -> void:
	pass

	

func _process(delta: float) -> void:
	
	# Read inputs
	receive_movement_inputs()

	
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

func receive_movement_inputs():
	if Input.is_action_pressed("up"):
		movement_component.add_to_movement_buffer(movement_component.Direction.UP)
	elif Input.is_action_just_pressed("down"):
		movement_component.add_to_movement_buffer(movement_component.Direction.DOWN)
	elif Input.is_action_just_pressed("right"):
		movement_component.add_to_movement_buffer(movement_component.Direction.RIGHT)
	elif Input.is_action_just_pressed("left"):
		movement_component.add_to_movement_buffer(movement_component.Direction.LEFT)
