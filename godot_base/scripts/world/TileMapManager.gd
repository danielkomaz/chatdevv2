class_name TileMapManager
extends Node

var current_map_id: String = ""
var tilemap: TileMap = null
var event_tiles: Dictionary = {}
var spawn_points: Dictionary = {}

func load_map(map_id: String) -> void:
	current_map_id = map_id
	event_tiles.clear()
	spawn_points.clear()
	tilemap = get_node_or_null("WorldTileMap") as TileMap
	emit_signal("map_loaded", map_id) if has_signal("map_loaded") else null

func get_tile_events(position: Vector2i) -> Array:
	return event_tiles.get(position, [])

func set_tile(position: Vector2i, tile_id: int, layer: int) -> void:
	if tilemap == null:
		push_warning("TileMapManager: tilemap node not set.")
		return
	var atlas_coords := Vector2i(tile_id % 16, tile_id / 16)
	tilemap.set_cell(layer, position, 0, atlas_coords)

func find_spawn_point(spawn_id: String) -> Vector2:
	return spawn_points.get(spawn_id, Vector2.ZERO)

func register_event_tile(position: Vector2i, event_data: Dictionary) -> void:
	if not event_tiles.has(position):
		event_tiles[position] = []
	event_tiles[position].append(event_data)

func clear_event_tile(position: Vector2i) -> void:
	event_tiles.erase(position)

func get_collision_at(position: Vector2i) -> bool:
	if tilemap == null:
		return false
	var tile_data: TileData = tilemap.get_cell_tile_data(3, position)
	return tile_data != null
