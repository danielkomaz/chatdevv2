class_name PartyManager
extends Node

signal party_changed
signal member_added(character: CharacterBase)
signal member_removed(character: CharacterBase)
signal member_swapped(active_idx: int, reserve_idx: int)
signal morale_changed(new_morale: int)
signal party_wiped

enum Formation { STANDARD, AGGRESSIVE, DEFENSIVE, SPREAD }

const MAX_ACTIVE: int = 4
const MAX_RESERVE: int = 8

var active_party: Array = []
var reserve_party: Array = []
var current_formation: Formation = Formation.STANDARD
var morale: int = 75

const FORMATION_BONUSES: Dictionary = {
	Formation.STANDARD:   {"attack_mult": 1.0, "defense_mult": 1.0, "speed_mult": 1.0},
	Formation.AGGRESSIVE: {"attack_mult": 1.15, "defense_mult": 0.9, "speed_mult": 1.05},
	Formation.DEFENSIVE:  {"attack_mult": 0.9,  "defense_mult": 1.2, "speed_mult": 0.95},
	Formation.SPREAD:     {"attack_mult": 1.05, "defense_mult": 1.05, "speed_mult": 1.1},
}

func add_to_party(character: CharacterBase) -> bool:
	if active_party.size() < MAX_ACTIVE:
		active_party.append(character)
		emit_signal("member_added", character)
		emit_signal("party_changed")
		return true
	elif reserve_party.size() < MAX_RESERVE:
		reserve_party.append(character)
		emit_signal("member_added", character)
		emit_signal("party_changed")
		return true
	return false

func remove_from_party(index: int) -> CharacterBase:
	if index < 0 or index >= active_party.size():
		return null
	var character: CharacterBase = active_party[index]
	active_party.remove_at(index)
	emit_signal("member_removed", character)
	emit_signal("party_changed")
	return character

func swap_members(active_idx: int, reserve_idx: int) -> bool:
	if active_idx < 0 or active_idx >= active_party.size():
		return false
	if reserve_idx < 0 or reserve_idx >= reserve_party.size():
		return false
	var temp: CharacterBase = active_party[active_idx]
	active_party[active_idx] = reserve_party[reserve_idx]
	reserve_party[reserve_idx] = temp
	emit_signal("member_swapped", active_idx, reserve_idx)
	emit_signal("party_changed")
	return true

func get_active_party() -> Array:
	return active_party.duplicate()

func get_reserve() -> Array:
	return reserve_party.duplicate()

func heal_all_party(amount: int) -> void:
	for character in active_party + reserve_party:
		character.heal(amount)

func restore_mp_all(amount: int) -> void:
	for character in active_party + reserve_party:
		character.restore_mp(amount)

func revive_fallen() -> void:
	for character in active_party + reserve_party:
		if not character.is_alive():
			character.hp = 1

func get_average_level() -> float:
	if active_party.is_empty():
		return 1.0
	var total: int = 0
	for c in active_party:
		total += c.level
	return float(total) / active_party.size()

func update_morale(delta: int) -> void:
	morale = clamp(morale + delta, 0, 100)
	emit_signal("morale_changed", morale)

func get_formation_bonus(formation_type: Formation) -> Dictionary:
	return FORMATION_BONUSES.get(formation_type, FORMATION_BONUSES[Formation.STANDARD])

func set_formation(formation_type: Formation) -> void:
	current_formation = formation_type
	emit_signal("party_changed")

func is_party_wiped() -> bool:
	for character in active_party:
		if character.is_alive():
			return false
	return true

func get_member_count() -> int:
	return active_party.size()

func has_character(character_name: String) -> bool:
	for c in active_party + reserve_party:
		if c.character_name == character_name:
			return true
	return false
