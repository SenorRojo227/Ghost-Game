extends Node2D

# Set blink intervals
func _on_blink_timer_timeout() -> void:
	get_parent().get_node("AnimatedSprite2D").play()
