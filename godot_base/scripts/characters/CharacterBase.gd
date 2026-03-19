class_name CharacterBase
extends Resource

@export var character_name: String = ""
@export var race_id: String = "human"
@export var class_id: String = "warrior"
@export var portrait_texture: Texture2D
@export var sprite_texture: Texture2D

@export var level: int = 1
@export var experience: int = 0
@export var experience_to_next_level: int = 150

@export var hp: int = 100
@export var max_hp: int = 100
@export var mp: int = 30
@export var max_mp: int = 30

@export var base_strength: int = 10
@export var base_defense: int = 10
@export var base_magic: int = 10
@export var base_resistance: int = 10
@export var base_speed: int = 10
@export var base_luck: int = 10

# Keys: "weapon", "armor", "helmet", "accessory_1", "accessory_2"
@export var equipment: Dictionary = {}
@export var known_skills: Array[String] = []
@export var known_spells: Array[String] = []
@export var racial_bonuses: Dictionary = {}
@export var status_immunities: Array[String] = []

# Apply raw damage and return actual amount taken
func take_damage(amount: int, damage_type: String) -> int:
	var actual: int = max(1, amount)
	hp = max(0, hp - actual)
	return actual

# Heal HP and return amount actually restored
func heal(amount: int) -> int:
	var before: int = hp
	hp = min(max_hp, hp + amount)
	return hp - before

# Restore MP and return amount restored
func restore_mp(amount: int) -> int:
	var before: int = mp
	mp = min(max_mp, mp + amount)
	return mp - before

# Consume MP; returns false if insufficient
func use_mp(amount: int) -> bool:
	if mp < amount:
		return false
	mp -= amount
	return true

# Level up, returning a dictionary of stat gains
func level_up() -> Dictionary:
	level += 1
	var gains: Dictionary = {}
	var growth := {
		"hp":         int(get_stat_growth("hp") * 10.0),
		"mp":         int(get_stat_growth("mp") * 5.0),
		"strength":   int(get_stat_growth("strength") * 2.0),
		"defense":    int(get_stat_growth("defense") * 2.0),
		"magic":      int(get_stat_growth("magic") * 2.0),
		"resistance": int(get_stat_growth("resistance") * 2.0),
		"speed":      int(get_stat_growth("speed") * 1.5),
		"luck":       int(get_stat_growth("luck") * 1.0),
	}
	# Small random bonus on each stat
	for stat in growth.keys():
		var bonus: int = growth[stat] + randi() % 2
		gains[stat] = bonus
	max_hp += gains.get("hp", 0)
	hp = max_hp  # full heal on level up
	max_mp += gains.get("mp", 0)
	mp = max_mp
	base_strength   += gains.get("strength", 0)
	base_defense    += gains.get("defense", 0)
	base_magic      += gains.get("magic", 0)
	base_resistance += gains.get("resistance", 0)
	base_speed      += gains.get("speed", 0)
	base_luck       += gains.get("luck", 0)
	experience_to_next_level = _calculate_experience_threshold(level)
	return gains

# Grant XP; returns true if a level-up occurred
func gain_experience(amount: int) -> bool:
	experience += amount
	if experience >= experience_to_next_level:
		experience -= experience_to_next_level
		level_up()
		return true
	return false

# Equip an item dict into a slot; returns false if slot invalid
func equip(item: Dictionary, slot: String) -> bool:
	var valid_slots := ["weapon", "armor", "helmet", "accessory_1", "accessory_2"]
	if not slot in valid_slots:
		return false
	equipment[slot] = item
	return true

# Remove item from slot and return it
func unequip(slot: String) -> Dictionary:
	if equipment.has(slot):
		var item: Dictionary = equipment[slot]
		equipment.erase(slot)
		return item
	return {}

func is_alive() -> bool:
	return hp > 0

# Return a stat value including equipment bonuses and racial modifiers
func get_stat(stat_name: String) -> int:
	var base: int = 0
	match stat_name:
		"strength":   base = base_strength
		"defense":    base = base_defense
		"magic":      base = base_magic
		"resistance": base = base_resistance
		"speed":      base = base_speed
		"luck":       base = base_luck
		"hp":         return max_hp
		"mp":         return max_mp
	# Add equipment bonuses
	for slot in equipment.keys():
		var item: Dictionary = equipment[slot]
		if item.has("stats") and item["stats"].has(stat_name):
			base += int(item["stats"][stat_name])
	# Apply racial modifier (stored as flat bonus)
	if racial_bonuses.has(stat_name):
		base += int(racial_bonuses[stat_name])
	return base

# XP threshold formula: 100 * lvl^2 * 0.5 + 50 * lvl
func _calculate_experience_threshold(lvl: int) -> int:
	return int(100.0 * lvl * lvl * 0.5 + 50.0 * lvl)

# Growth rate per level for a stat based on class_id
func get_stat_growth(stat: String) -> float:
	# Each class has different growth priorities
	var growths: Dictionary = {
		"warrior":  {"hp":1.4,"mp":0.6,"strength":1.3,"defense":1.2,"magic":0.6,"resistance":0.8,"speed":0.9,"luck":0.8},
		"mage":     {"hp":0.8,"mp":1.4,"strength":0.6,"defense":0.6,"magic":1.4,"resistance":1.1,"speed":0.9,"luck":1.0},
		"rogue":    {"hp":1.0,"mp":0.8,"strength":1.1,"defense":0.8,"magic":0.8,"resistance":0.8,"speed":1.4,"luck":1.3},
		"healer":   {"hp":1.0,"mp":1.3,"strength":0.7,"defense":0.9,"magic":1.2,"resistance":1.3,"speed":0.9,"luck":1.1},
		"paladin":  {"hp":1.3,"mp":1.0,"strength":1.1,"defense":1.3,"magic":1.0,"resistance":1.2,"speed":0.8,"luck":0.9},
		"ranger":   {"hp":1.0,"mp":0.9,"strength":1.2,"defense":0.9,"magic":0.9,"resistance":0.9,"speed":1.2,"luck":1.1},
	}
	var class_growth: Dictionary = growths.get(class_id, growths["warrior"])
	return class_growth.get(stat, 1.0)

func learn_skill(skill_id: String) -> bool:
	if skill_id in known_skills:
		return false
	known_skills.append(skill_id)
	return true

func learn_spell(spell_id: String) -> bool:
	if spell_id in known_spells:
		return false
	known_spells.append(spell_id)
	return true
