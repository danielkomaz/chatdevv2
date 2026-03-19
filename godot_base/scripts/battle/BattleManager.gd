class_name BattleManager
extends Node

signal battle_started(party: Array, enemies: Array)
signal battle_ended(result: int)
signal turn_started(unit: BattleUnit)
signal turn_ended(unit: BattleUnit)
signal unit_died(unit: BattleUnit)
signal skill_used(user: BattleUnit, skill_id: String, targets: Array)
signal spell_cast(caster: BattleUnit, spell_id: String, targets: Array)
signal damage_dealt(target: BattleUnit, amount: int, damage_type: int)
signal status_applied(target: BattleUnit, effect: int)

enum BattleState { IDLE, PLAYER_TURN, ENEMY_TURN, ANIMATION, VICTORY, DEFEAT, FLED }
enum BattleResult { VICTORY, DEFEAT, FLED }
enum DamageType { PHYSICAL, MAGICAL, FIRE, ICE, THUNDER, WIND, EARTH, WATER, LIGHT, DARK, TRUE_DAMAGE }
enum StatusEffect { NONE, POISON, BURN, FREEZE, SLEEP, STUN, CONFUSE, HASTE, SLOW, REGEN, SHIELD, BERSERK }

var current_state: BattleState = BattleState.IDLE
var battle_units: Array = []
var turn_queue: Array = []
var current_unit_index: int = 0
var turn_count: int = 0

const ELEMENTAL_CHART: Dictionary = {
	"FIRE":    {"FIRE": 0.5, "ICE": 1.5, "WATER": 0.5, "WIND": 1.0, "EARTH": 1.0, "THUNDER": 1.0},
	"ICE":     {"FIRE": 0.5, "ICE": 0.5, "WATER": 1.0, "WIND": 1.5, "EARTH": 1.0, "THUNDER": 1.0},
	"THUNDER": {"FIRE": 1.0, "ICE": 1.0, "WATER": 1.5, "WIND": 0.5, "EARTH": 0.5, "THUNDER": 0.5},
	"WIND":    {"FIRE": 1.0, "ICE": 0.5, "WATER": 1.0, "WIND": 0.5, "EARTH": 1.5, "THUNDER": 1.5},
	"EARTH":   {"FIRE": 1.0, "ICE": 1.0, "WATER": 1.0, "WIND": 0.5, "EARTH": 0.5, "THUNDER": 1.5},
	"WATER":   {"FIRE": 1.5, "ICE": 1.0, "WATER": 0.5, "WIND": 1.0, "EARTH": 1.0, "THUNDER": 0.5},
	"LIGHT":   {"DARK": 2.0, "LIGHT": 0.5},
	"DARK":    {"LIGHT": 2.0, "DARK": 0.5},
}

func start_battle(party_members: Array, enemy_data: Array) -> void:
	battle_units.clear()
	turn_queue.clear()
	turn_count = 0
	for member in party_members:
		var unit := BattleUnit.new(member)
		unit.is_player_unit = true
		battle_units.append(unit)
	for enemy in enemy_data:
		var unit := BattleUnit.new(enemy)
		unit.is_player_unit = false
		battle_units.append(unit)
	_calculate_turn_order()
	current_state = BattleState.PLAYER_TURN
	emit_signal("battle_started", party_members, enemy_data)
	_process_turn()

func _calculate_turn_order() -> void:
	turn_queue = battle_units.filter(func(u): return u.is_alive())
	turn_queue.sort_custom(func(a, b):
		var sa: int = a.get_effective_stat("speed")
		var sb: int = b.get_effective_stat("speed")
		if sa != sb:
			return sa > sb
		return a.get_effective_stat("luck") > b.get_effective_stat("luck")
	)

func _process_turn() -> void:
	if turn_queue.is_empty():
		_calculate_turn_order()
	if turn_queue.is_empty():
		return
	var unit: BattleUnit = turn_queue[current_unit_index % turn_queue.size()]
	unit.reset_turn()
	_process_status_ticks(unit)
	if not unit.is_alive():
		_advance_turn()
		return
	emit_signal("turn_started", unit)
	if not unit.can_act():
		_advance_turn()
		return
	if not unit.is_player_unit:
		_enemy_ai_action(unit)

func execute_action(action_type: String, user: BattleUnit, targets: Array, skill_id: String = "") -> void:
	match action_type:
		"ATTACK":
			for target in targets:
				var dmg: int = _calculate_damage(user, 1.0, false, DamageType.PHYSICAL)
				_apply_damage(target, dmg, DamageType.PHYSICAL)
		"DEFEND":
			user.is_defending = true
		"SKILL":
			emit_signal("skill_used", user, skill_id, targets)
		"SPELL":
			emit_signal("spell_cast", user, skill_id, targets)
		"FLEE":
			if flee_attempt(user):
				current_state = BattleState.FLED
				emit_signal("battle_ended", BattleResult.FLED)
				return
	user.action_taken = true
	_check_battle_end()
	if current_state == BattleState.PLAYER_TURN or current_state == BattleState.ENEMY_TURN:
		_advance_turn()

func _apply_damage(target: BattleUnit, amount: int, damage_type: DamageType) -> int:
	if damage_type == DamageType.TRUE_DAMAGE:
		target.character.take_damage(amount, "true")
		emit_signal("damage_dealt", target, amount, damage_type)
		if not target.is_alive():
			emit_signal("unit_died", target)
		return amount
	var actual: int = amount
	if target.has_status(StatusEffect.SHIELD):
		actual = int(actual * 0.5)
	if target.is_defending:
		actual = int(actual * 0.5)
	actual = max(1, actual)
	target.character.take_damage(actual, str(damage_type))
	emit_signal("damage_dealt", target, actual, damage_type)
	if not target.is_alive():
		emit_signal("unit_died", target)
	return actual

func _apply_status_effect(target: BattleUnit, effect: StatusEffect, duration: int) -> void:
	if effect == StatusEffect.FREEZE and target.has_status(StatusEffect.BURN):
		target.remove_status(StatusEffect.BURN)
		return
	target.apply_status(effect, duration)
	emit_signal("status_applied", target, effect)

func _check_battle_end() -> void:
	var players_alive: bool = battle_units.any(func(u): return u.is_player_unit and u.is_alive())
	var enemies_alive: bool = battle_units.any(func(u): return not u.is_player_unit and u.is_alive())
	if not players_alive:
		current_state = BattleState.DEFEAT
		emit_signal("battle_ended", BattleResult.DEFEAT)
	elif not enemies_alive:
		current_state = BattleState.VICTORY
		emit_signal("battle_ended", BattleResult.VICTORY)

func _calculate_damage(attacker: BattleUnit, base_power: float, is_magical: bool, damage_type: DamageType) -> int:
	var atk_stat: int = attacker.get_effective_stat("magic" if is_magical else "strength")
	var raw: float = atk_stat * base_power
	raw *= randf_range(0.9, 1.1)
	var crit_chance: float = attacker.get_effective_stat("luck") * 0.003
	if randf() < crit_chance:
		raw *= 1.5
	return max(1, int(raw))

func _enemy_ai_action(unit: BattleUnit) -> void:
	var player_targets: Array = battle_units.filter(func(u): return u.is_player_unit and u.is_alive())
	if player_targets.is_empty():
		return
	var ai_type: String = unit.character.get("ai_type") if unit.character.get("ai_type") else "BASIC"
	match ai_type:
		"AGGRESSIVE":
			player_targets.sort_custom(func(a, b): return a.character.hp < b.character.hp)
			var target: BattleUnit = player_targets[0]
			var dmg: int = _calculate_damage(unit, 1.2, false, DamageType.PHYSICAL)
			_apply_damage(target, dmg, DamageType.PHYSICAL)
		"DEFENSIVE":
			if unit.character.hp > unit.character.max_hp * 0.4:
				var target: BattleUnit = player_targets[randi() % player_targets.size()]
				var dmg: int = _calculate_damage(unit, 0.9, false, DamageType.PHYSICAL)
				_apply_damage(target, dmg, DamageType.PHYSICAL)
			else:
				unit.is_defending = true
		"SUPPORT":
			var allies: Array = battle_units.filter(func(u): return not u.is_player_unit and u.is_alive() and u.character.hp < u.character.max_hp * 0.5)
			if not allies.is_empty():
				allies.sort_custom(func(a, b): return a.character.hp < b.character.hp)
				var heal: int = int(allies[0].character.max_hp * 0.2)
				allies[0].character.heal(heal)
			else:
				var target: BattleUnit = player_targets[randi() % player_targets.size()]
				var dmg: int = _calculate_damage(unit, 1.0, true, DamageType.MAGICAL)
				_apply_damage(target, dmg, DamageType.MAGICAL)
		_:
			var target: BattleUnit = player_targets[randi() % player_targets.size()]
			var dmg: int = _calculate_damage(unit, 1.0, false, DamageType.PHYSICAL)
			_apply_damage(target, dmg, DamageType.PHYSICAL)
	unit.action_taken = true
	_check_battle_end()
	if current_state == BattleState.PLAYER_TURN or current_state == BattleState.ENEMY_TURN:
		_advance_turn()

func _process_status_ticks(unit: BattleUnit) -> void:
	if unit.has_status(StatusEffect.POISON):
		var dmg: int = max(1, int(unit.character.max_hp * 0.05))
		unit.character.take_damage(dmg, "poison")
	if unit.has_status(StatusEffect.BURN):
		var dmg: int = max(1, int(unit.character.max_hp * 0.07))
		unit.character.take_damage(dmg, "burn")
	if unit.has_status(StatusEffect.REGEN):
		var heal: int = max(1, int(unit.character.max_hp * 0.08))
		unit.character.heal(heal)
	unit.tick_statuses()
	if not unit.is_alive():
		emit_signal("unit_died", unit)

func _advance_turn() -> void:
	var current: BattleUnit = turn_queue[current_unit_index % turn_queue.size()]
	emit_signal("turn_ended", current)
	turn_count += 1
	current_unit_index = (current_unit_index + 1) % max(1, turn_queue.size())
	if current_unit_index == 0:
		_calculate_turn_order()
	_process_turn()

func end_turn() -> void:
	_advance_turn()

func flee_attempt(unit: BattleUnit) -> bool:
	var party_spd: float = 0.0
	var party_count: int = 0
	var enemy_spd: float = 0.0
	var enemy_count: int = 0
	for u in battle_units:
		if u.is_player_unit and u.is_alive():
			party_spd += u.get_effective_stat("speed")
			party_count += 1
		elif not u.is_player_unit and u.is_alive():
			enemy_spd += u.get_effective_stat("speed")
			enemy_count += 1
	if party_count == 0:
		return false
	party_spd /= party_count
	enemy_spd = enemy_spd / max(1, enemy_count)
	var flee_chance: float = clamp(0.5 + (party_spd - enemy_spd) / 200.0, 0.1, 0.9)
	return randf() < flee_chance
