class_name HUD
extends CanvasLayer

@onready var party_panel: VBoxContainer = $PartyPanel
@onready var turn_order_bar: HBoxContainer = $TurnOrder
@onready var action_menu: HBoxContainer = $ActionMenu
@onready var damage_numbers_node: Node2D = $DamageNumbers

const DMG_COLOR: Color = Color(1.0, 0.2, 0.2)
const HEAL_COLOR: Color = Color(0.2, 1.0, 0.2)
const MP_COLOR: Color = Color(0.2, 0.6, 1.0)
const CRIT_COLOR: Color = Color(1.0, 0.9, 0.0)

func _ready() -> void:
	hide_all_menus()

func update_party_display() -> void:
	if party_panel == null:
		return
	for child in party_panel.get_children():
		child.queue_free()
	var party: Array = PartyManager.get_active_party() if Engine.has_singleton("PartyManager") else []
	for character in party:
		var member_ui := VBoxContainer.new()
		var name_label := Label.new()
		name_label.text = character.character_name
		member_ui.add_child(name_label)
		var hp_bar := ProgressBar.new()
		hp_bar.name = "HPBar"
		hp_bar.max_value = character.max_hp
		hp_bar.value = character.hp
		member_ui.add_child(hp_bar)
		var mp_bar := ProgressBar.new()
		mp_bar.name = "MPBar"
		mp_bar.max_value = character.max_mp
		mp_bar.value = character.mp
		member_ui.add_child(mp_bar)
		party_panel.add_child(member_ui)

func update_enemy_display(_enemies: Array) -> void:
	pass

func show_damage_number(value: int, world_position: Vector2, damage_type: String) -> void:
	var label := Label.new()
	label.text = str(value)
	match damage_type:
		"heal": label.modulate = HEAL_COLOR
		"mp":   label.modulate = MP_COLOR
		"crit": label.modulate = CRIT_COLOR
		_:      label.modulate = DMG_COLOR
	label.position = world_position
	damage_numbers_node.add_child(label)
	var tween: Tween = create_tween()
	tween.tween_property(label, "position", world_position + Vector2(0, -40), 0.8)
	tween.parallel().tween_property(label, "modulate:a", 0.0, 0.8)
	tween.tween_callback(label.queue_free)

func show_action_menu() -> void:
	if action_menu:
		action_menu.visible = true

func hide_action_menu() -> void:
	if action_menu:
		action_menu.visible = false

func show_skill_menu(_skills: Array) -> void:
	hide_all_menus()

func show_magic_menu(_spells: Array) -> void:
	hide_all_menus()

func show_item_menu() -> void:
	hide_all_menus()

func highlight_turn_order(unit: BattleUnit) -> void:
	if turn_order_bar == null:
		return
	for child in turn_order_bar.get_children():
		child.modulate = Color.WHITE
		if child.get_meta("unit_id", "") == unit.character.character_name:
			child.modulate = CRIT_COLOR

func show_status_icons(unit: BattleUnit, icons_container: Node) -> void:
	for child in icons_container.get_children():
		child.queue_free()
	for effect in unit.status_effects:
		if unit.status_effects[effect].get("duration", 0) > 0:
			var icon := Label.new()
			icon.text = BattleManager.StatusEffect.keys()[effect].left(3)
			icons_container.add_child(icon)

func update_hp_bar(character: CharacterBase, bar_node: ProgressBar) -> void:
	if bar_node == null:
		return
	bar_node.max_value = character.max_hp
	var tween: Tween = create_tween()
	tween.tween_property(bar_node, "value", float(character.hp), 0.3)

func update_mp_bar(character: CharacterBase, bar_node: ProgressBar) -> void:
	if bar_node == null:
		return
	bar_node.max_value = character.max_mp
	bar_node.value = character.mp

func hide_all_menus() -> void:
	if action_menu:
		action_menu.visible = false
