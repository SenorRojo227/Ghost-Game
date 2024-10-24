extends Node2D

@export var next_level : PackedScene
@export var player : CharacterBody2D
@export var level_dialog : String

func _ready() -> void:
	player.get_node("MovementComponent").advance_level.connect(_on_advance_level)
	player.game_over.connect(_on_game_over)
	
	# Start dialog if one is not running
	if Dialogic.current_timeline == null && str("Level",Counters.level) != name:
		print(str("Level",Counters.level))
		print(name)
		Counters.level += 1
		Dialogic.start(level_dialog)
		get_viewport().set_input_as_handled()

func _on_advance_level():
	get_tree().change_scene_to_packed(next_level)

func _on_game_over(enemy : CharacterBody2D):
	Dialogic.start(str(enemy.name, "Interaction", Counters.get_death_dialog(enemy)))
	get_viewport().set_input_as_handled()
	await Dialogic.timeline_ended
	get_tree().reload_current_scene()
