class_name RaceSystem
extends Node

class RaceData:
	var id: String = ""
	var name: String = ""
	var description: String = ""
	var stat_modifiers: Dictionary = {}
	var passive_ability_id: String = ""
	var active_skill_id: String = ""
	var recommended_classes: Array = []
	var color_palette: Array = []

	func _init(data: Dictionary) -> void:
		for key in data:
			set(key, data[key])

func _get_race_dict() -> Dictionary:
	return {
		"human": {"id": "human", "name": "Human", "description": "Adaptable and resourceful, humans are the most numerous race in Aethoria.", "stat_modifiers": {"all_pct": 0.05}, "passive_ability_id": "quick_learner", "active_skill_id": "rally", "recommended_classes": ["warrior", "mage", "ranger", "healer", "knight", "bard"], "color_palette": ["#F5CBA7", "#E8A87C", "#C68642", "#8D5524", "#2C1810", "#DAA520"]},
		"elf": {"id": "elf", "name": "Elf", "description": "Ancient forest dwellers deeply connected to arcane magic and nature.", "stat_modifiers": {"magic": 20, "speed": 15, "strength": -10, "defense": -10}, "passive_ability_id": "arcane_affinity", "active_skill_id": "natures_grasp", "recommended_classes": ["mage", "ranger", "druid", "summoner"], "color_palette": ["#E8D5B7", "#C5A882", "#F5F5DC", "#90EE90", "#228B22", "#00CED1"]},
		"dwarf": {"id": "dwarf", "name": "Dwarf", "description": "Mountain-born craftspeople and warriors, masters of metal and stone.", "stat_modifiers": {"strength": 20, "defense": 15, "magic": -10, "speed": -15}, "passive_ability_id": "stone_skin", "active_skill_id": "war_cry", "recommended_classes": ["warrior", "knight", "berserker", "smith"], "color_palette": ["#A0785A", "#8B6348", "#C0C0C0", "#808080", "#8B4513", "#FF6B35"]},
		"draconian": {"id": "draconian", "name": "Draconian", "description": "Descendants of ancient dragons, proud warriors who breathe elemental energy.", "stat_modifiers": {"strength": 15, "magic": 15, "speed": -5}, "passive_ability_id": "dragon_scales", "active_skill_id": "dragon_breath", "recommended_classes": ["dragon_knight", "battle_mage", "berserker", "paladin"], "color_palette": ["#2F4F4F", "#8B0000", "#006400", "#FFD700", "#FF4500"]},
		"sprite": {"id": "sprite", "name": "Sprite", "description": "Tiny fey beings of pure magical energy, flickers of light given consciousness.", "stat_modifiers": {"magic": 30, "speed": 25, "max_hp": -20, "defense": -20}, "passive_ability_id": "fey_step", "active_skill_id": "phantasm", "recommended_classes": ["mage", "time_mage", "illusionist", "summoner"], "color_palette": ["#E0E0FF", "#FFE4E1", "#FF69B4", "#00BFFF", "#DDA0DD", "#FFD700"]},
	}

func apply_racial_bonuses(character: CharacterBase) -> void:
	var race_data: Dictionary = get_race_data(character.race_id)
	if race_data.is_empty():
		return
	var mods: Dictionary = race_data.get("stat_modifiers", {})
	for stat in mods:
		if stat == "all_pct":
			var pct: float = mods[stat]
			for s in ["base_strength", "base_defense", "base_magic", "base_resistance", "base_speed", "base_luck"]:
				character.set(s, int(character.get(s) * (1.0 + pct)))
		elif stat == "max_hp":
			character.max_hp = max(1, character.max_hp + mods[stat])
			character.hp = min(character.hp, character.max_hp)
		else:
			var prop: String = "base_" + stat
			var current: int = character.get(prop) if character.get(prop) != null else 0
			character.set(prop, max(1, current + mods[stat]))
	character.racial_bonuses = mods

func get_racial_passive(race_id: String) -> Dictionary:
	var passives: Dictionary = {
		"quick_learner":   {"id": "quick_learner",   "name": "Quick Learner",   "description": "Gain 10% bonus XP.",                   "effect_type": "xp_bonus",        "value": 0.10},
		"arcane_affinity": {"id": "arcane_affinity",  "name": "Arcane Affinity", "description": "MP costs reduced by 10%.",             "effect_type": "mp_cost_reduction","value": 0.10},
		"stone_skin":      {"id": "stone_skin",        "name": "Stone Skin",      "description": "15% physical damage reduction.",       "effect_type": "phys_reduction",   "value": 0.15},
		"dragon_scales":   {"id": "dragon_scales",     "name": "Dragon Scales",   "description": "5% all damage reduction.",             "effect_type": "all_reduction",    "value": 0.05},
		"fey_step":        {"id": "fey_step",          "name": "Fey Step",        "description": "20% chance to evade attacks.",         "effect_type": "evasion",          "value": 0.20},
	}
	var race: Dictionary = get_race_data(race_id)
	if race.is_empty():
		return {}
	return passives.get(race.get("passive_ability_id", ""), {})

func get_racial_skill(race_id: String) -> String:
	var race: Dictionary = get_race_data(race_id)
	return race.get("active_skill_id", "")

func get_race_data(race_id: String) -> Dictionary:
	return _get_race_dict().get(race_id, {})

func get_all_races() -> Array:
	return _get_race_dict().values()
