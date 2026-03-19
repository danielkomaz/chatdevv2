class_name QuestManager
extends Node

signal quest_started(quest_id: String)
signal quest_completed(quest_id: String)
signal quest_failed(quest_id: String)
signal objective_updated(quest_id: String, objective_id: String, progress: int)
signal reward_given(quest_id: String, rewards: Dictionary)

enum QuestState { UNAVAILABLE, AVAILABLE, ACTIVE, COMPLETED, FAILED }

class QuestObjective:
	var id: String = ""
	var description: String = ""
	var required_count: int = 1
	var current_count: int = 0
	var objective_type: String = "KILL"
	var is_complete: bool = false

	func check_complete() -> void:
		is_complete = current_count >= required_count

class QuestData:
	var id: String = ""
	var title: String = ""
	var description: String = ""
	var objectives: Array = []
	var rewards: Dictionary = {}
	var prerequisite_quests: Array = []
	var is_main_quest: bool = false
	var quest_giver_id: String = ""

var quest_registry: Dictionary = {}
var quest_states: Dictionary = {}
var active_quests: Array = []
var completed_quests: Array = []

func register_quest(quest_data: QuestData) -> void:
	quest_registry[quest_data.id] = quest_data
	quest_states[quest_data.id] = QuestState.UNAVAILABLE

func start_quest(quest_id: String) -> bool:
	if not quest_registry.has(quest_id):
		return false
	if quest_states.get(quest_id, QuestState.UNAVAILABLE) != QuestState.AVAILABLE:
		return false
	if not check_prerequisites(quest_id):
		return false
	quest_states[quest_id] = QuestState.ACTIVE
	active_quests.append(quest_id)
	emit_signal("quest_started", quest_id)
	return true

func update_objective(quest_id: String, objective_id: String, progress: int) -> void:
	if not quest_registry.has(quest_id):
		return
	if quest_states.get(quest_id) != QuestState.ACTIVE:
		return
	var quest: QuestData = quest_registry[quest_id]
	for obj in quest.objectives:
		if obj.id == objective_id:
			obj.current_count = min(obj.current_count + progress, obj.required_count)
			obj.check_complete()
			emit_signal("objective_updated", quest_id, objective_id, obj.current_count)
			break
	if is_quest_complete(quest_id):
		complete_quest(quest_id)

func complete_quest(quest_id: String) -> void:
	if quest_states.get(quest_id) != QuestState.ACTIVE:
		return
	quest_states[quest_id] = QuestState.COMPLETED
	active_quests.erase(quest_id)
	completed_quests.append(quest_id)
	give_rewards(quest_id)
	emit_signal("quest_completed", quest_id)
	for qid in quest_registry:
		var q: QuestData = quest_registry[qid]
		if quest_id in q.prerequisite_quests and quest_states.get(qid) == QuestState.UNAVAILABLE:
			if check_prerequisites(qid):
				quest_states[qid] = QuestState.AVAILABLE

func fail_quest(quest_id: String) -> void:
	if quest_states.get(quest_id) != QuestState.ACTIVE:
		return
	quest_states[quest_id] = QuestState.FAILED
	active_quests.erase(quest_id)
	emit_signal("quest_failed", quest_id)

func get_active_quests() -> Array:
	return active_quests.map(func(qid): return quest_registry.get(qid))

func get_completed_quests() -> Array:
	return completed_quests.map(func(qid): return quest_registry.get(qid))

func check_prerequisites(quest_id: String) -> bool:
	var quest: QuestData = quest_registry.get(quest_id)
	if quest == null:
		return false
	for prereq in quest.prerequisite_quests:
		if quest_states.get(prereq, QuestState.UNAVAILABLE) != QuestState.COMPLETED:
			return false
	return true

func give_rewards(quest_id: String) -> void:
	var quest: QuestData = quest_registry.get(quest_id)
	if quest == null:
		return
	emit_signal("reward_given", quest_id, quest.rewards)

func is_quest_complete(quest_id: String) -> bool:
	var quest: QuestData = quest_registry.get(quest_id)
	if quest == null:
		return false
	for obj in quest.objectives:
		if not obj.is_complete:
			return false
	return true

func get_quest_state(quest_id: String) -> QuestState:
	return quest_states.get(quest_id, QuestState.UNAVAILABLE)
