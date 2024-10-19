extends CharacterBody2D

var delay: float = 0
var animation_names: Array[String] = ["side_idle", "down_idle"]
var float_distance : float = 0
var float_direction : float = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delay += delta
	if delay > 2:
		$AnimatedSprite2D.animation = animation_names[randi_range(0, animation_names.size() - 1)]
		if $AnimatedSprite2D.animation == "side_idle":
			# Randomly choose between true and false
			$AnimatedSprite2D.flip_h = bool(randi() % 2)
		else:
			$AnimatedSprite2D.flip_h = false
		delay = 0
	pass

# Set blink intervals
func _on_blink_timer_timeout() -> void:
	$AnimatedSprite2D.play()

# Move player up and down automatically
func _on_float_timer_timeout() -> void:
	position.y += float_distance
	float_distance += float_direction
	if abs(float_distance) > 2:
		float_direction *= -1
	$ShadowComponent.scale.x -= 0.1 * float_direction
