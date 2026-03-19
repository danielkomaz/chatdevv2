class_name InventoryUI
extends Control

@onready var item_grid: GridContainer = $ItemGrid
@onready var detail_panel: PanelContainer = $DetailPanel
@onready var category_tabs: TabContainer = $CategoryTabs
@onready var stat_compare_panel: PanelContainer = $StatCompare
@onready var equip_slots_display: VBoxContainer = $EquipSlots

var current_character: CharacterBase = null
var selected_category: String = "consumable"
var selected_item_index: int = -1
var categories: Array[String] = ["consumable", "equipment", "key_item"]

func _ready() -> void:
	visible = false
	if stat_compare_panel:
		stat_compare_panel.visible = false

func open_inventory(character: CharacterBase) -> void:
	current_character = character
	selected_item_index = -1
	visible = true
	_populate_items(selected_category)
	_refresh_equipment_display()

func close_inventory() -> void:
	visible = false
	current_character = null

func _populate_items(category: String) -> void:
	selected_category = category
	if item_grid == null or current_character == null:
		return
	for child in item_grid.get_children():
		child.queue_free()
	var items: Array = []
	if Engine.has_singleton("GameManager"):
		var gm = Engine.get_singleton("GameManager")
		if gm.has_method("get_inventory"):
			items = gm.get_inventory(category)
	for i in range(items.size()):
		var btn := Button.new()
		btn.text = items[i].get("name", "???")
		var idx: int = i
		btn.pressed.connect(func(): _on_item_selected(idx))
		item_grid.add_child(btn)

func _on_item_selected(item_index: int) -> void:
	selected_item_index = item_index
	var items: Array = []
	if Engine.has_singleton("GameManager"):
		var gm = Engine.get_singleton("GameManager")
		if gm.has_method("get_inventory"):
			items = gm.get_inventory(selected_category)
	if item_index < items.size():
		_show_item_details(items[item_index])

func _show_item_details(item: Dictionary) -> void:
	if detail_panel == null:
		return
	detail_panel.visible = true
	var name_label: Label = detail_panel.get_node_or_null("ItemName")
	var desc_label: Label = detail_panel.get_node_or_null("ItemDesc")
	if name_label:
		name_label.text = item.get("name", "Unknown")
	if desc_label:
		desc_label.text = item.get("description", "")
	if item.get("type") == "equipment" and current_character != null:
		_show_stat_comparison(item, current_character)

func _equip_item(item: Dictionary, character: CharacterBase) -> void:
	if character == null:
		return
	var slot: String = item.get("slot", "weapon")
	character.equip(item, slot)
	_refresh_equipment_display()
	if stat_compare_panel:
		stat_compare_panel.visible = false

func _use_item(item: Dictionary, character: CharacterBase) -> void:
	if character == null:
		return
	var effect: String = item.get("effect", "")
	match effect:
		"heal":
			character.heal(item.get("value", 50))
		"restore_mp":
			character.restore_mp(item.get("value", 30))
		"revive":
			if not character.is_alive():
				character.hp = max(1, int(character.max_hp * 0.25))
	if Engine.has_singleton("GameManager"):
		var gm = Engine.get_singleton("GameManager")
		if gm.has_method("remove_item"):
			gm.remove_item(item.get("id", ""))
	_populate_items(selected_category)

func _on_category_changed(new_category: String) -> void:
	selected_item_index = -1
	if detail_panel:
		detail_panel.visible = false
	_populate_items(new_category)

func _show_stat_comparison(item: Dictionary, character: CharacterBase) -> void:
	if stat_compare_panel == null or character == null:
		return
	stat_compare_panel.visible = true
	var slot: String = item.get("slot", "weapon")
	var current_item: Dictionary = character.equipment.get(slot, {})
	var compare_label: Label = stat_compare_panel.get_node_or_null("CompareLabel")
	if compare_label == null:
		return
	var text: String = "Comparison:\n"
	for stat in ["attack", "defense", "magic", "speed"]:
		var new_val: int = item.get("stats", {}).get(stat, 0)
		var cur_val: int = current_item.get("stats", {}).get(stat, 0)
		var diff: int = new_val - cur_val
		text += "%s: %s%d\n" % [stat.capitalize(), "+" if diff >= 0 else "", diff]
	compare_label.text = text

func _refresh_equipment_display() -> void:
	if equip_slots_display == null or current_character == null:
		return
	for child in equip_slots_display.get_children():
		child.queue_free()
	for slot in ["weapon", "armor", "helmet", "accessory_1", "accessory_2"]:
		var row := HBoxContainer.new()
		var slot_label := Label.new()
		slot_label.text = slot.replace("_", " ").capitalize() + ": "
		row.add_child(slot_label)
		var item: Dictionary = current_character.equipment.get(slot, {})
		var item_label := Label.new()
		item_label.text = item.get("name", "(empty)")
		row.add_child(item_label)
		equip_slots_display.add_child(row)
