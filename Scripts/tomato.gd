extends CharacterBody2D

@export var movement_component : MovementComponent
@export var horizontal : bool

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("movement"):
		if horizontal:
			movement_component.set_direction(movement_component.Direction.RIGHT)
		else:
			movement_component.set_direction(movement_component.Direction.DOWN)
	movement_component.move(self, true)
