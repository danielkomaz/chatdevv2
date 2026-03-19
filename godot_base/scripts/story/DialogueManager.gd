class_name DialogueManager
extends Node

signal dialogue_started(dialogue_id: String)
signal dialogue_ended(dialogue_id: String)
signal choice_presented(choices: Array)
signal line_displayed(speaker: String, text: String, portrait: String)

class DialogueLine:
	var speaker: String = ""
	var text: String = ""
	var portrait_id: String = ""
	var choices: Array = []
	var conditions: Array = []
	var actions: Array = []
	var next_line_id: String = ""

class DialogueChoice:
	var text: String = ""
	var next_line_id: String = ""
	var condition: String = ""
	var action: String = ""

var current_dialogue_id: String = ""
var current_dialogue: Dictionary = {}
var current_line_index: int = 0
var is_active: bool = false
var dialogue_database: Dictionary = {}

func register_dialogue(dialogue_id: String, lines: Array) -> void:
	dialogue_database[dialogue_id] = lines

func start_dialogue(dialogue_id: String) -> bool:
	if not dialogue_database.has(dialogue_id):
		push_warning("DialogueManager: Dialogue '%s' not found." % dialogue_id)
		return false
	current_dialogue_id = dialogue_id
	current_dialogue = {}
	current_line_index = 0
	is_active = true
	for raw in dialogue_database[dialogue_id]:
		var line: DialogueLine = _parse_line(raw)
		current_dialogue[raw.get("id", str(current_line_index))] = line
	emit_signal("dialogue_started", dialogue_id)
	_display_line("start")
	return true

func _display_line(line_id: String) -> void:
	if not current_dialogue.has(line_id):
		end_dialogue()
		return
	var line: DialogueLine = current_dialogue[line_id]
	for cond in line.conditions:
		if not _check_condition(cond):
			if line.next_line_id != "":
				_display_line(line.next_line_id)
			else:
				end_dialogue()
			return
	var substituted: String = _substitute_variables(line.text)
	emit_signal("line_displayed", line.speaker, substituted, line.portrait_id)
	for action in line.actions:
		_execute_action(action)
	if not line.choices.is_empty():
		emit_signal("choice_presented", line.choices)
	current_dialogue["_current"] = line

func next_line() -> void:
	if not is_active:
		return
	var current: DialogueLine = current_dialogue.get("_current", null)
	if current == null:
		end_dialogue()
		return
	if not current.choices.is_empty():
		return
	if current.next_line_id != "":
		_display_line(current.next_line_id)
	else:
		end_dialogue()

func make_choice(choice_index: int) -> void:
	var current: DialogueLine = current_dialogue.get("_current", null)
	if current == null or current.choices.is_empty():
		return
	if choice_index < 0 or choice_index >= current.choices.size():
		return
	var choice: DialogueChoice = current.choices[choice_index]
	if choice.action != "":
		_execute_action(choice.action)
	_display_line(choice.next_line_id)

func end_dialogue() -> void:
	is_active = false
	var ended_id: String = current_dialogue_id
	current_dialogue_id = ""
	current_dialogue = {}
	emit_signal("dialogue_ended", ended_id)

func _parse_line(raw: Dictionary) -> DialogueLine:
	var line := DialogueLine.new()
	line.speaker      = raw.get("speaker", "")
	line.text         = raw.get("text", "")
	line.portrait_id  = raw.get("portrait", "")
	line.next_line_id = raw.get("next", "")
	line.conditions   = raw.get("conditions", [])
	line.actions      = raw.get("actions", [])
	var raw_choices: Array = raw.get("choices", [])
	for rc in raw_choices:
		var choice := DialogueChoice.new()
		choice.text         = rc.get("text", "")
		choice.next_line_id = rc.get("next", "")
		choice.condition    = rc.get("condition", "")
		choice.action       = rc.get("action", "")
		line.choices.append(choice)
	return line

func _check_condition(condition: String) -> bool:
	if Engine.has_singleton("GameManager"):
		var gm = Engine.get_singleton("GameManager")
		if gm.has_method("check_flag"):
			return gm.check_flag(condition)
	return true

func _execute_action(action: String) -> void:
	if Engine.has_singleton("GameManager"):
		var gm = Engine.get_singleton("GameManager")
		if gm.has_method("execute_dialogue_action"):
			gm.execute_dialogue_action(action)

func _substitute_variables(text: String) -> String:
	var result: String = text
	if Engine.has_singleton("GameManager"):
		var gm = Engine.get_singleton("GameManager")
		if gm.has_method("get_player_name"):
			result = result.replace("{player_name}", gm.get_player_name())
		if gm.has_method("get_party_leader_name"):
			result = result.replace("{party_leader}", gm.get_party_leader_name())
	return result

func is_dialogue_active() -> bool:
	return is_active
