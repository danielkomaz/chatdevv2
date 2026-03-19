class_name WorldMap
extends Node2D

signal location_entered(location_id: String)
signal encounter_triggered(terrain: String)
signal map_loaded(map_id: String)

@export var encounter_rate: float = 0.05
@export var move_speed: float = 2.0

var player_position: Vector2 = Vector2.ZERO
var step_count: int = 0
var current_terrain: String = "grassland"
var locations: Dictionary = {}
var _player_node: Node2D = null

func _ready() -> void:
	_player_node = get_node_or_null("Player")

func _physics_process(_delta: float) -> void:
	if not _player_node:
		return
	var direction := Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
	elif Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1
	if direction != Vector2.ZERO:
		_move_player(direction)

func _move_player(direction: Vector2) -> void:
	if not _player_node:
		return
	var new_pos: Vector2 = _player_node.position + direction * 16
	_player_node.position = new_pos
	player_position = new_pos
	step_count += 1
	_check_encounter()
	_check_location_proximity()

func _check_encounter() -> void:
	var terrain_multipliers: Dictionary = {
		"grassland": 1.0, "forest": 1.5, "dungeon": 2.0,
		"desert": 1.2, "snow": 1.1, "road": 0.3,
	}
	var modifier: float = terrain_multipliers.get(current_terrain, 1.0)
	if randf() < encounter_rate * modifier:
		step_count = 0
		emit_signal("encounter_triggered", current_terrain)

func _check_location_proximity() -> void:
	for loc_id in locations:
		var loc: Dictionary = locations[loc_id]
		if player_position.distance_to(loc["position"]) < 16.0:
			_on_location_reached(loc_id)
			return

func _enter_location(location_id: String) -> void:
	if not locations.has(location_id):
		return
	var scene_path: String = locations[location_id].get("scene_path", "")
	if scene_path != "" and ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)

func _on_location_reached(location_id: String) -> void:
	emit_signal("location_entered", location_id)
	if Input.is_action_just_pressed("interact"):
		_enter_location(location_id)

func get_current_terrain() -> String:
	return current_terrain

func set_encounter_rate(rate: float) -> void:
	encounter_rate = clamp(rate, 0.0, 1.0)

func add_location(location_id: String, position: Vector2, scene_path: String) -> void:
	locations[location_id] = {"position": position, "scene_path": scene_path}
