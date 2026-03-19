class_name SkillSystem
extends Node

class SkillData:
	var id: String = ""
	var name: String = ""
	var description: String = ""
	var skill_type: String = "PHYSICAL"
	var element: String = "NONE"
	var mp_cost: int = 0
	var tp_cost: int = 0
	var cooldown: int = 0
	var level_requirement: int = 1
	var target_type: String = "SINGLE_ENEMY"
	var power: float = 1.0
	var hit_count: int = 1
	var status_effect: String = "NONE"
	var status_chance: float = 0.0
	var stat_buff: Dictionary = {}
	var buff_duration: int = 0
	var healing_power: float = 0.0

	func _init(data: Dictionary) -> void:
		for key in data:
			set(key, data[key])

const SKILL_DATABASE: Dictionary = {
	"power_strike": {"id": "power_strike", "name": "Power Strike", "description": "A powerful physical blow.", "skill_type": "PHYSICAL", "element": "NONE", "mp_cost": 8, "level_requirement": 1, "target_type": "SINGLE_ENEMY", "power": 1.5, "hit_count": 1},
	"rend": {"id": "rend", "name": "Rend", "description": "Slash the enemy, causing bleeding (Poison).", "skill_type": "PHYSICAL", "element": "NONE", "mp_cost": 12, "level_requirement": 5, "target_type": "SINGLE_ENEMY", "power": 1.2, "status_effect": "POISON", "status_chance": 0.6},
	"whirlwind": {"id": "whirlwind", "name": "Whirlwind Slash", "description": "Spin-attack hitting all enemies.", "skill_type": "PHYSICAL", "element": "WIND", "mp_cost": 18, "level_requirement": 10, "target_type": "ALL_ENEMIES", "power": 0.8},
	"shield_bash": {"id": "shield_bash", "name": "Shield Bash", "description": "Bash with shield, may stun.", "skill_type": "PHYSICAL", "element": "NONE", "mp_cost": 14, "level_requirement": 15, "target_type": "SINGLE_ENEMY", "power": 1.0, "status_effect": "STUN", "status_chance": 0.3},
	"battle_cry": {"id": "battle_cry", "name": "Battle Cry", "description": "Raise party STR by 15% for 2 turns.", "skill_type": "SUPPORT", "element": "NONE", "mp_cost": 15, "level_requirement": 5, "target_type": "ALL_ALLIES", "stat_buff": {"strength": 0.15}, "buff_duration": 2},
	"focus": {"id": "focus", "name": "Focus", "description": "Concentrate, raising own MAG by 25% for 2 turns.", "skill_type": "SUPPORT", "element": "NONE", "mp_cost": 10, "level_requirement": 3, "target_type": "SELF", "stat_buff": {"magic": 0.25}, "buff_duration": 2},
	"double_strike": {"id": "double_strike", "name": "Double Strike", "description": "Hit the enemy twice.", "skill_type": "COMBO", "element": "NONE", "mp_cost": 20, "level_requirement": 12, "target_type": "SINGLE_ENEMY", "power": 0.8, "hit_count": 2},
	"healing_light": {"id": "healing_light", "name": "Healing Light", "description": "Restore HP to one ally.", "skill_type": "SUPPORT", "element": "LIGHT", "mp_cost": 15, "level_requirement": 1, "target_type": "SINGLE_ALLY", "healing_power": 1.5},
	"elemental_burst": {"id": "elemental_burst", "name": "Elemental Burst", "description": "Fire explosion hitting all enemies.", "skill_type": "MAGICAL", "element": "FIRE", "mp_cost": 25, "level_requirement": 15, "target_type": "ALL_ENEMIES", "power": 1.2},
	"limit_break": {"id": "limit_break", "name": "Limit Break", "description": "Devastating strike usable only at low HP.", "skill_type": "PHYSICAL", "element": "NONE", "mp_cost": 40, "level_requirement": 30, "target_type": "SINGLE_ENEMY", "power": 3.5},
}

func get_skill(skill_id: String) -> SkillData:
	if SKILL_DATABASE.has(skill_id):
		return SkillData.new(SKILL_DATABASE[skill_id])
	push_warning("SkillSystem: Unknown skill_id '%s'" % skill_id)
	return null

func learn_skill(character: CharacterBase, skill_id: String) -> bool:
	if not SKILL_DATABASE.has(skill_id):
		return false
	var skill: SkillData = get_skill(skill_id)
	if character.level < skill.level_requirement:
		return false
	if skill_id in character.known_skills:
		return false
	character.known_skills.append(skill_id)
	return true

func can_use_skill(user: BattleUnit, skill_id: String) -> bool:
	if not SKILL_DATABASE.has(skill_id):
		return false
	var skill: SkillData = get_skill(skill_id)
	if not skill_id in user.character.known_skills:
		return false
	if user.character.mp < skill.mp_cost:
		return false
	if skill_id == "limit_break" and user.character.hp >= user.character.max_hp * 0.5:
		return false
	return true

func use_skill(user: BattleUnit, skill_id: String, targets: Array, battle_mgr: BattleManager) -> bool:
	if not can_use_skill(user, skill_id):
		return false
	var skill: SkillData = get_skill(skill_id)
	user.character.use_mp(skill.mp_cost)
	_apply_skill_effects(skill, user, targets, battle_mgr)
	return true

func _calculate_skill_damage(user: BattleUnit, skill: SkillData, target: BattleUnit) -> int:
	var is_magical: bool = skill.skill_type == "MAGICAL"
	var atk: int = user.get_effective_stat("magic" if is_magical else "strength")
	var def_val: int = target.get_effective_stat("resistance" if is_magical else "defense")
	var raw: float = (atk * skill.power) - (def_val * 0.5)
	raw = max(1.0, raw) * randf_range(0.9, 1.1)
	return int(raw)

func _apply_skill_effects(skill: SkillData, user: BattleUnit, targets: Array, battle_mgr: BattleManager) -> void:
	for target in targets:
		if skill.healing_power > 0.0:
			var heal_amount: int = int(user.get_effective_stat("magic") * skill.healing_power)
			target.character.heal(heal_amount)
		elif not skill.stat_buff.is_empty():
			pass
		elif skill.power > 0.0:
			for _hit in range(skill.hit_count):
				var dmg: int = _calculate_skill_damage(user, skill, target)
				battle_mgr._apply_damage(target, dmg, BattleManager.DamageType.PHYSICAL if skill.skill_type == "PHYSICAL" else BattleManager.DamageType.MAGICAL)
			if skill.status_effect != "NONE" and randf() < skill.status_chance:
				var effect_val: int = BattleManager.StatusEffect.get(skill.status_effect, 0)
				battle_mgr._apply_status_effect(target, effect_val, 3)
