extends Node2D
class_name GridComponent

@export var size_x : int
@export var size_y : int

enum OccupantType {EMPTY, WALL, PLAYER, DOOR, ENEMY}

var map : Array[GridPoint]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in size_x:
		for y in size_y:
			map.append(GridPoint.new(Vector2(x, y), OccupantType.EMPTY))
		pass


func claim_initial_grid_point(location: Vector2, occupant_type: OccupantType):
	search_for_grid_point(location).tile_occupant = occupant_type
	

func claim_grid_point(previous_location: Vector2, location: Vector2, occupant_type: OccupantType):
	var grid_point = search_for_grid_point(location)
	if grid_point != null:
		if grid_point.tile_occupant == OccupantType.EMPTY:
			search_for_grid_point(previous_location).tile_occupant = OccupantType.EMPTY
			grid_point.tile_occupant = occupant_type
			return true
	return false
	

func search_for_grid_point(location: Vector2):
	for point in map:
		if point.location == location:
			return point

class GridPoint:
	
	var location : Vector2
	var tile_occupant : OccupantType
	
	func _init(location, tile_occupancy):
		self.location = location
		self.tile_occupant = tile_occupancy
	
