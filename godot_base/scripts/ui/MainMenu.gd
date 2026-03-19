class_name MainMenu
extends Control

@onready var new_game_button: Button = $MenuButtons/NewGame
@onready var continue_button: Button = $MenuButtons/Continue
@onready var options_button: Button = $MenuButtons/Options
@onready var credits_button: Button = $MenuButtons/Credits
@onready var quit_button: Button = $MenuButtons/Quit
@onready var title_logo: Node2D = $TitleLogo

func _ready() -> void:
	_animate_title_entrance()
	continue_button.disabled = not _check_save_exists()
	new_game_button.pressed.connect(_on_new_game_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	options_button.pressed.connect(_on_options_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_new_game_pressed() -> void:
	_transition_to_game(-1)

func _on_continue_pressed() -> void:
	var slots: Array = _load_save_slots()
	if slots.is_empty():
		return
	var most_recent: int = 0
	for i in range(slots.size()):
		if slots[i].get("timestamp", 0) > slots[most_recent].get("timestamp", 0):
			most_recent = i
	_transition_to_game(most_recent)

func _load_save_slots() -> Array:
	if Engine.has_singleton("SaveManager"):
		var sm = Engine.get_singleton("SaveManager")
		if sm.has_method("get_save_slots"):
			return sm.get_save_slots()
	return []

func _on_options_pressed() -> void:
	pass

func _on_credits_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()

func _transition_to_game(save_slot: int) -> void:
	if save_slot >= 0 and Engine.has_singleton("SaveManager"):
		var sm = Engine.get_singleton("SaveManager")
		if sm.has_method("load_game"):
			sm.load_game(save_slot)
	get_tree().change_scene_to_file("res://scenes/world/world_map.tscn")

func _animate_title_entrance() -> void:
	if title_logo == null:
		return
	title_logo.modulate.a = 0.0
	var tween: Tween = create_tween()
	tween.tween_property(title_logo, "modulate:a", 1.0, 1.5)

func _check_save_exists() -> bool:
	return not _load_save_slots().is_empty()
