extends Node2D

@export var next_level : PackedScene
@export var player : CharacterBody2D

func _ready() -> void:
	player.get_node("MovementComponent").advance_level.connect(_on_advance_level)
	
	# Start dialog if one is not running
	if Dialogic.current_timeline == null:
		Dialogic.start('Test')
		get_viewport().set_input_as_handled()

func _on_advance_level():
	get_parent().add_child(next_level.instantiate())
	queue_free()
