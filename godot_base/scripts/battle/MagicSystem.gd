class_name MagicSystem
extends Node

class SpellData:
	var id: String = ""
	var name: String = ""
	var description: String = ""
	var school: String = "FIRE"
	var mp_cost: int = 0
	var level_requirement: int = 1
	var power: float = 0.0
	var target_type: String = "SINGLE_ENEMY"
	var status_effect: String = "NONE"
	var status_chance: float = 0.0
	var healing_power: float = 0.0
	var buff_type: String = "NONE"

	func _init(data: Dictionary) -> void:
		for key in data:
			set(key, data[key])

const ELEMENT_CHART: Dictionary = {
	"FIRE":    {"FIRE": 0.5, "ICE": 1.5, "WATER": 0.5, "WIND": 1.0, "EARTH": 1.0, "THUNDER": 1.0, "HOLY": 1.0, "DARK": 1.0},
	"ICE":     {"FIRE": 0.5, "ICE": 0.5, "WATER": 1.0, "WIND": 1.5, "EARTH": 1.0, "THUNDER": 1.0, "HOLY": 1.0, "DARK": 1.0},
	"THUNDER": {"FIRE": 1.0, "ICE": 1.0, "WATER": 1.5, "WIND": 0.5, "EARTH": 0.5, "THUNDER": 0.5, "HOLY": 1.0, "DARK": 1.0},
	"WIND":    {"FIRE": 1.0, "ICE": 1.5, "WATER": 1.0, "WIND": 0.5, "EARTH": 1.5, "THUNDER": 1.0, "HOLY": 1.0, "DARK": 1.0},
	"EARTH":   {"FIRE": 1.0, "ICE": 1.0, "WATER": 1.0, "WIND": 1.5, "EARTH": 0.5, "THUNDER": 0.5, "HOLY": 1.0, "DARK": 1.0},
	"WATER":   {"FIRE": 1.5, "ICE": 1.0, "WATER": 0.5, "WIND": 1.0, "EARTH": 1.0, "THUNDER": 0.5, "HOLY": 1.0, "DARK": 1.0},
	"HOLY":    {"FIRE": 1.0, "ICE": 1.0, "WATER": 1.0, "WIND": 1.0, "EARTH": 1.0, "THUNDER": 1.0, "HOLY": 0.5, "DARK": 2.0},
	"DARK":    {"FIRE": 1.0, "ICE": 1.0, "WATER": 1.0, "WIND": 1.0, "EARTH": 1.0, "THUNDER": 1.0, "HOLY": 2.0, "DARK": 0.5},
	"TIME":    {},
	"SUPPORT": {},
}

const SPELL_DATABASE: Dictionary = {
	"fire":     {"id": "fire",     "name": "Fire",     "school": "FIRE",    "mp_cost": 10, "level_requirement": 1,  "power": 1.2, "target_type": "SINGLE_ENEMY"},
	"blizzard": {"id": "blizzard", "name": "Blizzard", "school": "ICE",     "mp_cost": 10, "level_requirement": 1,  "power": 1.2, "target_type": "SINGLE_ENEMY"},
	"thunder":  {"id": "thunder",  "name": "Thunder",  "school": "THUNDER", "mp_cost": 10, "level_requirement": 1,  "power": 1.2, "target_type": "SINGLE_ENEMY"},
	"fira":     {"id": "fira",     "name": "Fira",     "school": "FIRE",    "mp_cost": 22, "level_requirement": 10, "power": 2.0, "target_type": "SINGLE_ENEMY"},
	"blizzara": {"id": "blizzara", "name": "Blizzara", "school": "ICE",     "mp_cost": 22, "level_requirement": 10, "power": 2.0, "target_type": "SINGLE_ENEMY"},
	"thundara": {"id": "thundara", "name": "Thundara", "school": "THUNDER", "mp_cost": 22, "level_requirement": 10, "power": 2.0, "target_type": "SINGLE_ENEMY"},
	"firaga":   {"id": "firaga",   "name": "Firaga",   "school": "FIRE",    "mp_cost": 40, "level_requirement": 25, "power": 3.2, "target_type": "ALL_ENEMIES"},
	"blizzaga": {"id": "blizzaga", "name": "Blizzaga", "school": "ICE",     "mp_cost": 40, "level_requirement": 25, "power": 3.2, "target_type": "ALL_ENEMIES", "status_effect": "FREEZE", "status_chance": 0.25},
	"thundaga": {"id": "thundaga", "name": "Thundaga", "school": "THUNDER", "mp_cost": 40, "level_requirement": 25, "power": 3.2, "target_type": "ALL_ENEMIES", "status_effect": "STUN",   "status_chance": 0.20},
	"holy":     {"id": "holy",     "name": "Holy",     "school": "HOLY",    "mp_cost": 35, "level_requirement": 20, "power": 2.8, "target_type": "SINGLE_ENEMY"},
	"dark":     {"id": "dark",     "name": "Dark",     "school": "DARK",    "mp_cost": 35, "level_requirement": 20, "power": 2.8, "target_type": "SINGLE_ENEMY"},
	"cure":     {"id": "cure",     "name": "Cure",     "school": "SUPPORT", "mp_cost": 15, "level_requirement": 1,  "healing_power": 1.5, "target_type": "SINGLE_ALLY"},
	"cura":     {"id": "cura",     "name": "Cura",     "school": "SUPPORT", "mp_cost": 28, "level_requirement": 12, "healing_power": 2.5, "target_type": "SINGLE_ALLY"},
	"curaga":   {"id": "curaga",   "name": "Curaga",   "school": "SUPPORT", "mp_cost": 50, "level_requirement": 25, "healing_power": 3.5, "target_type": "ALL_ALLIES"},
	"haste":    {"id": "haste",    "name": "Haste",    "school": "TIME",    "mp_cost": 20, "level_requirement": 8,  "buff_type": "HASTE",  "target_type": "SINGLE_ALLY"},
	"slow":     {"id": "slow",     "name": "Slow",     "school": "TIME",    "mp_cost": 20, "level_requirement": 8,  "buff_type": "SLOW",   "target_type": "SINGLE_ENEMY"},
	"protect":  {"id": "protect",  "name": "Protect",  "school": "SUPPORT", "mp_cost": 18, "level_requirement": 5,  "buff_type": "SHIELD", "target_type": "SINGLE_ALLY"},
}

func get_spell(spell_id: String) -> SpellData:
	if SPELL_DATABASE.has(spell_id):
		return SpellData.new(SPELL_DATABASE[spell_id])
	push_warning("MagicSystem: Unknown spell_id '%s'" % spell_id)
	return null

func check_mp(caster: BattleUnit, spell: SpellData) -> bool:
	return caster.character.mp >= spell.mp_cost

func cast_spell(caster: BattleUnit, spell_id: String, targets: Array, battle_mgr: BattleManager) -> bool:
	var spell: SpellData = get_spell(spell_id)
	if spell == null:
		return false
	if not check_mp(caster, spell):
		return false
	if not spell_id in caster.character.known_spells:
		return false
	caster.character.use_mp(spell.mp_cost)
	_apply_spell_effect(spell, caster, targets, battle_mgr)
	return true

func _calculate_spell_damage(caster: BattleUnit, spell: SpellData, target: BattleUnit) -> int:
	var mag: int = caster.get_effective_stat("magic")
	var res: int = target.get_effective_stat("resistance")
	var raw: float = (mag * spell.power) - (res * 0.3)
	raw = max(1.0, raw) * randf_range(0.9, 1.1)
	raw = _apply_elemental_modifier(int(raw), spell.school, target)
	return int(raw)

func _apply_elemental_modifier(base_damage: int, spell_element: String, target: BattleUnit) -> int:
	var multiplier: float = 1.0
	if ELEMENT_CHART.has(spell_element):
		var chart: Dictionary = ELEMENT_CHART[spell_element]
		var target_element: String = target.character.get("elemental_affinity") if target.character.get("elemental_affinity") else "NONE"
		if chart.has(target_element):
			multiplier = chart[target_element]
	for weakness in target.elemental_weaknesses:
		if weakness == spell_element:
			multiplier *= 1.5
			break
	return int(base_damage * multiplier)

func _apply_spell_effect(spell: SpellData, caster: BattleUnit, targets: Array, battle_mgr: BattleManager) -> void:
	for target in targets:
		if spell.healing_power > 0.0:
			var heal: int = int(caster.get_effective_stat("magic") * spell.healing_power)
			target.character.heal(heal)
		elif spell.buff_type != "NONE":
			var effect_val: int = BattleManager.StatusEffect.get(spell.buff_type, 0)
			battle_mgr._apply_status_effect(target, effect_val, 3)
		elif spell.power > 0.0:
			var dmg: int = _calculate_spell_damage(caster, spell, target)
			var dtype: int = BattleManager.DamageType.get(spell.school, BattleManager.DamageType.MAGICAL)
			battle_mgr._apply_damage(target, dmg, dtype)
			if spell.status_effect != "NONE" and randf() < spell.status_chance:
				var effect_val: int = BattleManager.StatusEffect.get(spell.status_effect, 0)
				battle_mgr._apply_status_effect(target, effect_val, 3)
