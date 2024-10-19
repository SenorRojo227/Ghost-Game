extends Node2D

@export var next_level : PackedScene
@export var player : CharacterBody2D
@export var level_dialog : String

func _ready() -> void:
	player.get_node("MovementComponent").advance_level.connect(_on_advance_level)
	player.game_over.connect(_on_game_over)
	
	# Start dialog if one is not running
	if Dialogic.current_timeline == null:
		Dialogic.start(level_dialog)
		get_viewport().set_input_as_handled()

func _on_advance_level():
	get_parent().add_child(next_level.instantiate())
	queue_free()

func _on_game_over(enemy : CharacterBody2D):
	Dialogic.start(str(enemy.name, "Interaction", 1))
	get_viewport().set_input_as_handled()
	await Dialogic.timeline_ended
	queue_free()
