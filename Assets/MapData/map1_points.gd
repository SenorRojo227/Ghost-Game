extends Resource

var map_points: Array[Vector2]

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	map_points = [
		Vector2(2, 6),
		Vector2(2, 7),
		Vector2(2, 8),
		Vector2(2, 9),
		Vector2(3, 5),
		Vector2(3, 9),
		Vector2(4, 5),
		Vector2(4, 9),
		Vector2(5, 5),
		Vector2(5, 9),
		Vector2(6, 6),
		Vector2(6, 8),
		Vector2(7, 6),
		Vector2(7, 8),
		Vector2(8, 6),
		Vector2(8, 8),
		Vector2(9, 9),
		Vector2(9, 5),
		Vector2(10, 10),
		Vector2(10, 4),
		Vector2(11, 11),
		Vector2(11, 3),
		Vector2(12, 11),
		Vector2(12, 3),
		Vector2(13, 11),
		Vector2(13, 3),
		Vector2(14, 10),
		Vector2(14, 4),
		Vector2(15, 9),
		Vector2(15, 5),
		Vector2(16, 8),
		Vector2(16, 6),
		Vector2(17, 8),
		Vector2(17, 6),
		Vector2(18, 8),
		Vector2(18, 6),
		Vector2(19, 8),
		Vector2(19, 6),
		Vector2(19, 5),
		Vector2(19, 4),
		Vector2(19, 3),
		Vector2(19, 2),
		Vector2(20, 8),
		Vector2(20, 2),
		Vector2(21, 7),
		Vector2(21, 6),
		Vector2(21, 5),
		Vector2(21, 4),
		Vector2(21, 3),
		Vector2(21, 2)
	]

func get_map_points():
	return map_points
