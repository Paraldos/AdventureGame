extends Node2D

@onready var tile_map: TileMapLayer = %TileMapLayer
var astar_grid: AStarGrid2D

func _ready() -> void:
	_setup_astar()
	_show_grid_display()

func _setup_astar():
	astar_grid = AStarGrid2D.new()
	Astar.street_map = astar_grid
	astar_grid.cell_size = tile_map.tile_set.tile_size
	astar_grid.region = Rect2(Vector2.ZERO, ceil(get_viewport_rect().size / astar_grid.cell_size))
	astar_grid.update()
	for id in tile_map.get_used_cells():
		var data = tile_map.get_cell_tile_data(id)
		if data and data.get_custom_data('obstacle'):
			astar_grid.set_point_solid(id)

func _show_grid_display():
	if not astar_grid: return
	for x in astar_grid.region.size.x:
		for y in astar_grid.region.size.y:
			var p = Vector2(x,y)
			var col = Color(1,0,0,0.3) if astar_grid.is_point_solid(p) else Color(0,1,0,0.3)
			draw_rect(Rect2(p * astar_grid.cell_size, astar_grid.cell_size), col)
