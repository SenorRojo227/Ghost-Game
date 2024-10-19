extends CharacterBody2D

@export var movement_component : MovementComponent

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

func check_input(direction) -> void:
	if !movement_component.check_if_moving():
		movement_component.set_direction(direction)
		game_tick.emit()
