extends CharacterBody2D

@export var movement_component : MovementComponent

var float_distance : float = 0
var float_direction : float = -1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	# Read inputs
	if Input.is_action_just_pressed("up"):
		movement_component.set_direction(movement_component.Direction.UP)
	elif Input.is_action_just_pressed("down"):
		movement_component.set_direction(movement_component.Direction.DOWN)
	elif Input.is_action_just_pressed("right"):
		movement_component.set_direction(movement_component.Direction.RIGHT)
	elif Input.is_action_just_pressed("left"):
		movement_component.set_direction(movement_component.Direction.LEFT)
	
	movement_component.move(self)
	
	# Start dialogue
	if Input.is_action_just_pressed("dialogic_default_action"):
		# Check if a dialog is already running
		if Dialogic.current_timeline == null:
			Dialogic.start('Test')
			get_viewport().set_input_as_handled()

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
