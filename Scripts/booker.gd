extends CharacterBody2D

@export var movement_component : MovementComponent
var intro : bool

func _ready() -> void:
	intro = false


func _on_vision_body_entered(body: Node2D) -> void:
	if Dialogic.current_timeline == null && !intro:
		Dialogic.start("BookerIntro")
		get_viewport().set_input_as_handled()
		intro = true
