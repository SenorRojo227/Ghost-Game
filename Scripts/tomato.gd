extends CharacterBody2D

@export var movement_component : MovementComponent
@export var player : CharacterBody2D

func _ready() -> void:
	player.game_tick.connect(_on_game_tick)

func _process(delta: float) -> void:
	movement_component.move(self, true)

func _on_game_tick() -> void:
	movement_component.set_direction(movement_component.get_direction())
	if !movement_component.check_if_moving():
		movement_component.set_direction(movement_component.get_direction(true))
