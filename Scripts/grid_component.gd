extends Node2D
class_name GridComponent

@export var size_x : int
@export var size_y : int

enum OccupantType {EMPTY, WALL, PLAYER, DOOR, ENEMY}

var map : Array[GridPoint]

signal map_ready()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in size_x:
		for y in size_y:
			# print(Vector2(x, y)) # print for debug purposes
			map.append(GridPoint.new(Vector2(x, y), OccupantType.EMPTY))
		pass
	map_ready.emit()
	print("map is ready!")
	claim_initial_grid_point(Vector2(13,7), OccupantType.WALL)
	claim_initial_grid_point(Vector2(14,7), OccupantType.WALL)
	claim_initial_grid_point(Vector2(14,8), OccupantType.WALL)

func claim_initial_grid_point(location: Vector2, occupant_type: OccupantType):
	if(occupant_type != OccupantType.WALL):
		print(OccupantType.find_key(occupant_type), " claimed initial spot of ", location)
	search_for_grid_point(location).tile_occupant = occupant_type
	
# Method needs to be called before moving to a grid point. Returns the
# type of occupant currently in the grid point being moved to to allow for
# enemy attacks or possibly tooltips.
func claim_grid_point(previous_location: Vector2, location: Vector2, occupant_type: OccupantType):
	var grid_point = search_for_grid_point(location)
	if grid_point != null:
		var original_grid_occupant = grid_point.tile_occupant
		if original_grid_occupant == OccupantType.EMPTY:
			search_for_grid_point(previous_location).tile_occupant = OccupantType.EMPTY
			grid_point.tile_occupant = occupant_type
			# print(OccupantType.find_key(occupant_type), " claimed ", location)
		return original_grid_occupant
	else:
		return OccupantType.WALL
	
func unclaim_grid_point(location: Vector2):
	search_for_grid_point(location).tile_occupant = OccupantType.EMPTY
	

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
	
