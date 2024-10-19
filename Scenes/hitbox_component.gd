extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_signal("game_over"):
		body.game_over.emit(get_parent())
