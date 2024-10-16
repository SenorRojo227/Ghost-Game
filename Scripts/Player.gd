extends CharacterBody2D

@export var movement_component : MovementComponent

@export var map : Resource
var float_distance : float = 0
var float_direction : float = -1


func _ready() -> void:
	# Get into starting position in the centre of the screen
	position.x = 48 * movement_component.get_grid_pos().x + 24
	position.y = 48 * movement_component.get_grid_pos().y + 16
	

func _process(delta: float) -> void:
	
	# Read inputs
	movement_component.process_movement(self, map)
	
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
