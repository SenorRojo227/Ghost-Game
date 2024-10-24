extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_signal("game_over"):
		Counters.increment_deaths(get_parent())
		body.game_over.emit(get_parent())
