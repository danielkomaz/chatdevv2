class_name BattleUnit
extends RefCounted

# Wraps a CharacterBase for use during battle
var character: CharacterBase
var is_defending: bool = false
var action_taken: bool = false
var elemental_resistances: Dictionary = {}   # element -> float multiplier (<1 = resist)
var elemental_weaknesses: Array = []          # list of element strings
var status_effects: Dictionary = {}           # StatusEffect int -> {duration: int, stacks: int}

func _init(char: CharacterBase) -> void:
	character = char
	# Copy any racial resistances onto the unit
	if character.racial_bonuses.has("elemental_resistances"):
		elemental_resistances = character.racial_bonuses["elemental_resistances"].duplicate()

# Returns the effective value of a stat, accounting for equipment, status effects, and defending
func get_effective_stat(stat: String) -> int:
	var base: int = character.get_stat(stat)
	# Berserk: +50% STR, -50% DEF
	if has_status(BattleManager.StatusEffect.BERSERK):
		if stat == "strength":
			base = int(base * 1.5)
		elif stat == "defense":
			base = int(base * 0.5)
	# Shield / defending: +50% DEF and RES
	if is_defending:
		if stat == "defense" or stat == "resistance":
			base = int(base * 1.5)
	return base

# Apply a status effect (identified by its enum int value)
func apply_status(effect: int, duration: int) -> void:
	if status_effects.has(effect):
		# Refresh duration and increment stacks (max 3)
		status_effects[effect]["duration"] = max(status_effects[effect]["duration"], duration)
		status_effects[effect]["stacks"] = min(status_effects[effect]["stacks"] + 1, 3)
	else:
		status_effects[effect] = {"duration": duration, "stacks": 1}

func remove_status(effect: int) -> void:
	status_effects.erase(effect)

func has_status(effect: int) -> bool:
	return status_effects.has(effect)

# Decrement all status durations and remove any that have expired
func tick_statuses() -> void:
	var to_remove: Array = []
	for effect in status_effects.keys():
		status_effects[effect]["duration"] -= 1
		if status_effects[effect]["duration"] <= 0:
			to_remove.append(effect)
	for effect in to_remove:
		status_effects.erase(effect)

# Reset per-turn flags
func reset_turn() -> void:
	action_taken = false
	is_defending = false

func is_alive() -> bool:
	return character != null and character.hp > 0

# Returns false when unit cannot act due to incapacitating status
func can_act() -> bool:
	if has_status(BattleManager.StatusEffect.FREEZE):
		return false
	if has_status(BattleManager.StatusEffect.SLEEP):
		return false
	if has_status(BattleManager.StatusEffect.STUN):
		return false
	return true

# Speed value modified by Haste (+50%) or Slow (-33%)
func get_turn_speed() -> float:
	var spd: float = float(character.get_stat("speed"))
	if has_status(BattleManager.StatusEffect.HASTE):
		spd *= 1.5
	elif has_status(BattleManager.StatusEffect.SLOW):
		spd *= 0.67
	return spd
