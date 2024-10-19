extends Node2D

var float_distance : float = 0
var float_direction : float = -1

# Move player up and down automatically
func _on_float_timer_timeout() -> void:
	get_parent().get_node("AnimatedSprite2D").position.y += float_distance
	float_distance += float_direction
	if abs(float_distance) > 2:
		float_direction *= -1
	get_parent().get_node("ShadowComponent").scale.x -= 0.1 * float_direction
