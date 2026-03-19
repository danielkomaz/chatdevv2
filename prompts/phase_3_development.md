# Phase 3: Godot 4 Implementation

## Overview

This phase converts the approved Game Design Document (Phase 2) into working Godot 4 code. The **Core Developer** is responsible for all implementation. This document defines coding standards, required systems, implementation order, review criteria, and integration testing requirements. No system is considered complete until it passes all criteria in this document.

---

## Objective

Produce a fully functional Godot 4 project where every system defined in the GDD is:
- Implemented in GDScript following the standards in Section 1
- Connected to the correct autoloads and signals
- Testable in isolation and in combination with other systems
- Free of debug code, placeholder nodes, and hardcoded values

---

## 1. GDScript Coding Standards

### 1.1 Typed Variables

All variables must be statically typed. Do not use untyped declarations.

```gdscript
# CORRECT
var health: int = 100
var character_name: String = "Kael"
var is_dead: bool = false
var skills: Array[SkillData] = []

# INCORRECT — never do this
var health = 100
var character_name = "Kael"
```

### 1.2 @export Decorators

All values that should be configurable from the Godot Inspector must use `@export`. Group related exports using `@export_group`.

```gdscript
@export_group("Base Stats")
@export var max_hp: int = 100
@export var max_mp: int = 50
@export var base_atk: int = 20

@export_group("Identity")
@export var character_name: String = ""
@export var race: RaceData
@export var portrait: Texture2D
```

### 1.3 Signal Pattern

All inter-node communication that crosses scene boundaries must use signals. Signals are defined at the top of the class, below class_name. All signal parameters must be typed.

```gdscript
class_name BattleCharacter

# Signals defined at class top
signal hp_changed(new_hp: int, max_hp: int)
signal status_applied(status_name: String, duration: int)
signal character_died(character: BattleCharacter)
signal turn_started(character: BattleCharacter)

# Connection syntax
func _ready() -> void:
    hp_changed.connect(_on_hp_changed)
```

Never use `get_node()` calls into sibling or parent scenes to read game state. Always use signals or autoloads.

### 1.4 Autoloads

All autoloads are registered in Project Settings → Autoload. They are accessible globally without `get_node()` calls. Autoloads must not store scene-specific references — only game-state data.

```gdscript
# Access pattern
GameManager.current_scene_name
BattleManager.start_battle(enemy_group)
PartyManager.get_active_party()
```

### 1.5 General Rules

- All functions must have return type annotations: `func get_name() -> String:`
- Use `const` for values that never change; `var` for mutable state
- Maximum function length: 40 lines. Split longer functions into named helpers.
- No magic numbers. All numeric constants must be named:
  ```gdscript
  const MAX_PARTY_SIZE: int = 4
  const BASE_CRIT_MULTIPLIER: float = 1.5
  ```
- Use `enum` for all state machines and type flags:
  ```gdscript
  enum BattleState { IDLE, SELECTING_ACTION, ANIMATING, CHECKING_END }
  ```
- File naming: `snake_case.gd` for scripts, `PascalCase.tscn` for scenes
- Node naming: `PascalCase` for all nodes in the scene tree

---

## 2. Required Autoloads

### 2.1 GameManager (`game_manager.gd`)

**Purpose:** Top-level game state. Manages which scene is active, game flags, and persistent global variables.

**Required Properties:**
```gdscript
var current_scene: String
var game_flags: Dictionary  # Key: flag_name (String), Value: bool
var play_time_seconds: float
var difficulty: int  # 0=Easy, 1=Normal, 2=Hard
```

**Required Methods:**
```gdscript
func change_scene(scene_path: String) -> void
func set_flag(flag_name: String, value: bool) -> void
func get_flag(flag_name: String) -> bool
func get_formatted_play_time() -> String  # Returns "HH:MM:SS"
```

**Required Signals:**
```gdscript
signal scene_changed(new_scene: String)
signal flag_changed(flag_name: String, value: bool)
```

---

### 2.2 BattleManager (`battle_manager.gd`)

**Purpose:** Controls all battle logic including ATB processing, turn resolution, damage calculation, and status effect management.

**Required Properties:**
```gdscript
var is_in_battle: bool
var current_battle_state: BattleState
var combatants: Array[BattleCharacter]  # Sorted by ATB
var active_enemy_group: EnemyGroupData
var turn_number: int
var game_speed: float  # Multiplier applied to ATB fill rate
```

**Required Methods:**
```gdscript
func start_battle(enemy_group: EnemyGroupData) -> void
func end_battle(victory: bool) -> void
func process_atb(delta: float) -> void  # Called every frame during battle
func resolve_action(actor: BattleCharacter, action: BattleAction) -> void
func calculate_damage(attacker: BattleCharacter, target: BattleCharacter, 
                      skill: SkillData) -> int
func apply_status(target: BattleCharacter, status: StatusEffect, 
                  duration: int) -> void
func tick_statuses() -> void  # Called at start of each character's turn
func calculate_flee_chance() -> float
func award_xp_and_loot() -> void
```

**Required Signals:**
```gdscript
signal battle_started(enemy_group: EnemyGroupData)
signal battle_ended(victory: bool)
signal turn_started(character: BattleCharacter)
signal action_resolved(actor: BattleCharacter, action: BattleAction, result: Dictionary)
signal combatant_defeated(combatant: BattleCharacter)
signal status_changed(target: BattleCharacter, status: String, applied: bool)
```

---

### 2.3 PartyManager (`party_manager.gd`)

**Purpose:** Manages the player's party roster, active lineup, formation, and morale.

**Required Properties:**
```gdscript
var full_roster: Array[CharacterData]  # All characters (max 8)
var active_party: Array[CharacterData]  # Active 4 members
var current_formation: Formation
var party_morale: int  # 0–100
var party_gold: int
```

**Required Methods:**
```gdscript
func get_active_party() -> Array[CharacterData]
func set_formation(formation: Formation) -> void
func get_formation_modifiers() -> Dictionary  # Returns stat multipliers
func add_character(character: CharacterData) -> void
func remove_character(character: CharacterData) -> void
func swap_character(active_slot: int, reserve_character: CharacterData) -> void
func modify_morale(amount: int) -> void  # Clamps to [0, 100]
func get_morale_state() -> String  # "Inspired", "Normal", "Shaken", "Broken"
func add_gold(amount: int) -> void
func spend_gold(amount: int) -> bool  # Returns false if insufficient
```

**Required Signals:**
```gdscript
signal party_changed(new_active_party: Array[CharacterData])
signal formation_changed(new_formation: Formation)
signal morale_changed(new_morale: int, morale_state: String)
signal gold_changed(new_amount: int)
```

---

### 2.4 DialogueManager (`dialogue_manager.gd`)

**Purpose:** Processes and displays dialogue sequences. Handles branching choices, speaker data, and dialogue state.

**Required Properties:**
```gdscript
var is_dialogue_active: bool
var current_dialogue_id: String
var current_line_index: int
var current_speaker: String
var current_portrait: Texture2D
```

**Required Methods:**
```gdscript
func start_dialogue(dialogue_id: String) -> void
func advance_dialogue() -> void
func make_choice(choice_index: int) -> void
func end_dialogue() -> void
func is_active() -> bool
```

**Required Signals:**
```gdscript
signal dialogue_started(dialogue_id: String)
signal dialogue_line_shown(speaker: String, text: String, portrait: Texture2D)
signal dialogue_choice_presented(choices: Array[String])
signal dialogue_ended(dialogue_id: String)
```

---

### 2.5 QuestManager (`quest_manager.gd`)

**Purpose:** Tracks all quests (main and side), their states, and objective completion.

**Required Properties:**
```gdscript
var active_quests: Array[QuestData]
var completed_quests: Array[String]  # Quest IDs
var failed_quests: Array[String]
```

**Required Methods:**
```gdscript
func start_quest(quest_id: String) -> void
func complete_objective(quest_id: String, objective_id: String) -> void
func complete_quest(quest_id: String) -> void
func fail_quest(quest_id: String) -> void
func is_quest_active(quest_id: String) -> bool
func is_quest_complete(quest_id: String) -> bool
func get_quest_by_id(quest_id: String) -> QuestData
```

**Required Signals:**
```gdscript
signal quest_started(quest: QuestData)
signal objective_completed(quest_id: String, objective_id: String)
signal quest_completed(quest: QuestData)
signal quest_failed(quest: QuestData)
```

---

### 2.6 AudioManager (`audio_manager.gd`)

**Purpose:** All audio playback. Manages BGM transitions, SFX pools, and volume bus settings.

**Required Properties:**
```gdscript
var current_bgm_name: String
var bgm_volume: float  # 0.0–1.0
var sfx_volume: float
var is_bgm_paused: bool
```

**Required Methods:**
```gdscript
func play_bgm(track_name: String, fade_in_seconds: float = 1.0) -> void
func stop_bgm(fade_out_seconds: float = 1.0) -> void
func pause_bgm() -> void
func resume_bgm() -> void
func play_sfx(sfx_name: String) -> void
func set_bgm_volume(volume: float) -> void  # Clamps to [0.0, 1.0]
func set_sfx_volume(volume: float) -> void
```

**Internal Structure:**
- BGM played via a dedicated `AudioStreamPlayer` node (child of AudioManager scene)
- SFX played via a pool of 8 `AudioStreamPlayer` nodes (polyphonic playback)
- All tracks referenced by name string, mapped to file path in a `const Dictionary`

---

### 2.7 SaveManager (`save_manager.gd`)

**Purpose:** Handles all save and load operations. Serializes game state to/from JSON in user:// directory.

**Required Properties:**
```gdscript
const SAVE_DIR: String = "user://saves/"
const MAX_SAVE_SLOTS: int = 3
var current_slot: int
```

**Required Methods:**
```gdscript
func save_game(slot: int) -> bool  # Returns true on success
func load_game(slot: int) -> bool
func delete_save(slot: int) -> void
func save_exists(slot: int) -> bool
func get_save_metadata(slot: int) -> Dictionary  # Returns preview info
func serialize_game_state() -> Dictionary
func deserialize_game_state(data: Dictionary) -> void
```

**Required Signals:**
```gdscript
signal save_completed(slot: int, success: bool)
signal load_completed(slot: int, success: bool)
```

**Serialization must include:** party roster (all stats, skills, equipment), quest state, game flags, map position, play time, gold, inventory.

---

## 3. Resource Types

All game data is stored as Godot `Resource` files (`.tres`). Resources are loaded at runtime via preload/load and must never be modified during gameplay — create instances or use separate state objects for runtime data.

### 3.1 CharacterData (`character_data.gd`)

```gdscript
class_name CharacterData
extends Resource

@export var character_id: String
@export var character_name: String
@export var race: RaceData
@export var character_class: ClassData
@export var level: int = 1
@export var experience: int = 0
@export var base_stats: StatBlock
@export var learned_skills: Array[SkillData]
@export var equipment_slots: EquipmentLoadout
@export var portrait_texture: Texture2D
@export var battle_sprite: SpriteFrames
```

### 3.2 SkillData (`skill_data.gd`)

```gdscript
class_name SkillData
extends Resource

@export var skill_id: String
@export var skill_name: String
@export var skill_type: SkillType  # enum: ACTIVE, PASSIVE, REACTIVE
@export var element: ElementType  # enum
@export var mp_cost: int
@export var cooldown_turns: int
@export var level_requirement: int
@export var skill_point_cost: int
@export var prerequisite_skill_id: String
@export var damage_formula: String  # Evaluated at runtime via Expression
@export var description: String
@export var icon: Texture2D
@export var animation_id: String
```

### 3.3 SpellData (`spell_data.gd`)

```gdscript
class_name SpellData
extends Resource

@export var spell_id: String
@export var spell_name: String
@export var school: SpellSchool  # enum
@export var element: ElementType
@export var mp_cost: int
@export var cooldown_turns: int
@export var level_requirement: int
@export var target_type: TargetType  # enum: SINGLE_ENEMY, ALL_ENEMIES, SINGLE_ALLY, ALL_ALLIES
@export var damage_formula: String
@export var effect_description: String
@export var status_to_apply: StatusEffect
@export var status_apply_chance: float
@export var icon: Texture2D
@export var cast_animation_id: String
@export var impact_animation_id: String
```

### 3.4 RaceData (`race_data.gd`)

```gdscript
class_name RaceData
extends Resource

@export var race_id: String
@export var race_name: String
@export var stat_modifiers: StatBlock  # Percentage modifiers
@export var passive_ability: SkillData
@export var active_ability: SkillData
@export var recommended_classes: Array[String]  # Class IDs
@export var restricted_classes: Array[String]
@export var elemental_resistances: Dictionary  # ElementType: float multiplier
@export var lore_description: String
@export var race_icon: Texture2D
```

### 3.5 ItemData (`item_data.gd`)

```gdscript
class_name ItemData
extends Resource

@export var item_id: String
@export var item_name: String
@export var item_type: ItemType  # enum: CONSUMABLE, EQUIPMENT, KEY_ITEM
@export var description: String
@export var price: int
@export var sell_price: int
@export var icon: Texture2D
@export var is_usable_in_battle: bool
@export var is_usable_on_map: bool
@export var effect_script: String  # GDScript function name to call on use
@export var equipment_stats: StatBlock  # Null for non-equipment
@export var equipment_slot: EquipmentSlot  # enum
@export var tier: int  # 1–5
```

---

## 4. Required Scenes

### 4.1 Battle Scene (`BattleScene.tscn`)

**Node Structure:**
```
BattleScene (Node2D)
├── Background (Sprite2D)                    # Battle background per terrain
├── EnemyContainer (Node2D)                  # Dynamic enemy sprite placement
├── PartyContainer (Node2D)                  # 4 party member slots
│   ├── PartySlot1 (BattleCharacterSprite)
│   ├── PartySlot2 (BattleCharacterSprite)
│   ├── PartySlot3 (BattleCharacterSprite)
│   └── PartySlot4 (BattleCharacterSprite)
├── UI (CanvasLayer)
│   ├── ATBDisplay (Control)                 # Shows all ATB gauges
│   ├── ActionMenu (Control)                 # Attack/Skill/Magic/Item/Defend/Flee
│   ├── TargetSelector (Control)             # Enemy/ally targeting overlay
│   ├── StatusDisplay (Control)             # Active status icons
│   ├── DamageNumbers (Control)             # Floating damage text
│   └── BattleLog (RichTextLabel)           # Combat log last 5 actions
├── EffectLayer (Node2D)                    # Spell/skill animations
└── BattleController (Node)                 # Script: battle_controller.gd
```

**Key Behaviors:**
- `BattleController` calls `BattleManager.process_atb(delta)` every frame
- When ATB gauge reaches 100 for a party member, ActionMenu activates for that member
- Enemy AI resolves automatically when enemy ATB reaches 100
- Damage numbers animate upward and fade over 1 second
- Status icons displayed as 16×16 pixel icons beneath each combatant

### 4.2 World Map Scene (`WorldMap.tscn`)

**Node Structure:**
```
WorldMap (Node2D)
├── TileMap (TileMap)                       # World map tiles (16x16)
├── PlayerCharacter (CharacterBody2D)        # Script: player_movement.gd
│   ├── Sprite2D
│   ├── CollisionShape2D
│   └── InteractionArea (Area2D)            # Detects nearby interactables
├── NPCContainer (Node2D)                   # Dynamic NPC population
├── TransitionZones (Node2D)               # Area2D triggers for scene transitions
├── UI (CanvasLayer)
│   ├── MinimapDisplay (Control)
│   └── LocationLabel (Label)              # Current region name
└── Camera2D
    └── [Follows player, with limits set per map]
```

**Movement:** 8-directional with tile-snapped collision. Random encounter check every N steps (N defined by region data).

### 4.3 Main Menu Scene (`MainMenu.tscn`)

**Node Structure:**
```
MainMenu (Control)
├── Background (TextureRect)
├── TitleLogo (TextureRect)
├── MenuContainer (VBoxContainer)
│   ├── NewGameButton (Button)
│   ├── ContinueButton (Button)             # Disabled if no save exists
│   ├── SettingsButton (Button)
│   └── QuitButton (Button)
├── VersionLabel (Label)                    # Bottom-right corner
└── AudioPlayer (AudioStreamPlayer)         # Title screen BGM
```

### 4.4 Dialogue System Scene (`DialogueOverlay.tscn`)

**Node Structure:**
```
DialogueOverlay (CanvasLayer)              # Layer 10, always on top
├── DialogueBox (PanelContainer)
│   ├── PortraitDisplay (TextureRect)      # 48x48 portrait
│   ├── SpeakerNameLabel (Label)
│   ├── DialogueText (RichTextLabel)       # Typewriter effect
│   └── AdvanceIndicator (AnimatedSprite2D) # "▼" blink animation
└── ChoiceContainer (VBoxContainer)        # Shown only when choices present
    └── [Dynamic ChoiceButton nodes]
```

**Typewriter Effect:** Characters revealed at 40 characters per second (configurable). Press confirm to skip to end of current line.

### 4.5 Inventory Scene (`InventoryMenu.tscn`)

**Node Structure:**
```
InventoryMenu (Control)
├── CategoryTabs (TabContainer)            # Consumables / Equipment / Key Items
├── ItemList (ItemList)                    # Scrollable item list
├── ItemPreview (PanelContainer)           # Selected item details
│   ├── ItemIcon (TextureRect)
│   ├── ItemName (Label)
│   ├── ItemDescription (RichTextLabel)
│   └── StatComparison (Control)           # Compare vs equipped (for equipment)
├── UseButton (Button)
├── EquipButton (Button)
└── DropButton (Button)
```

---

## 5. Implementation Order

Follow this sequence strictly. Do not begin a step until the previous step passes its integration test.

| Step | System | Depends On | Integration Test |
|---|---|---|---|
| 1 | Resource types (all 5) | Nothing | Resources load without errors in Godot inspector |
| 2 | GameManager autoload | Nothing | Flags set/get correctly; scene change signal fires |
| 3 | SaveManager autoload | GameManager | Save/load round-trip preserves all data |
| 4 | PartyManager autoload | Resource types | Add/remove/swap party members; morale clamps correctly |
| 5 | AudioManager autoload | Nothing | BGM fades correctly; SFX pool plays without overlap |
| 6 | BattleManager autoload | PartyManager | ATB fills at correct rate; turn order resolves correctly |
| 7 | Battle Scene UI | BattleManager | Action menu appears on correct turn; targeting works |
| 8 | Damage/Status logic | BattleManager | All formulas produce expected results against test cases |
| 9 | DialogueManager autoload | Nothing | Dialogue advances correctly; choices branch correctly |
| 10 | World Map Scene | GameManager | Player moves; collision works; encounter triggers fire |
| 11 | Dialogue Overlay | DialogueManager | Typewriter plays; portraits display; choices selectable |
| 12 | QuestManager autoload | DialogueManager | Quest starts/completes/fails; objectives track correctly |
| 13 | Inventory Scene | PartyManager | Items display; equip compares stats; use triggers effect |
| 14 | Main Menu | SaveManager, AudioManager | New game and continue work; settings persist |
| 15 | Full integration | All above | Complete battle → world map → dialogue loop works end-to-end |

---

## 6. Code Review Criteria

All code submitted for review must pass the following before being considered complete:

### Mandatory (Block merge if failing)
- [ ] All variables are statically typed — no untyped declarations
- [ ] All functions have return type annotations
- [ ] No magic numbers — all constants named
- [ ] No `get_node()` calls crossing scene boundaries
- [ ] All cross-scene communication uses signals or autoloads
- [ ] No orphaned nodes (all dynamically created nodes are freed or queued_free'd)
- [ ] No `print()` debug statements in submitted code
- [ ] Resource files do not store mutable runtime state

### Advisory (Flag but do not block)
- Functions exceeding 40 lines flagged for refactor consideration
- Missing inline comments on non-obvious algorithms
- Magic strings (e.g., node names as literals) — suggest using `const` or `StringName`

---

## 7. Integration Testing Requirements

### Test Environment
- Godot 4.x (match target export version exactly)
- Run all tests in debug build before release build

### Required Test Scenarios

**Battle System Tests:**
- Two-character party vs. one enemy: correct ATB turn order, damage formula, defeat
- Status effect applied and expired after correct number of turns
- Flee succeeds and fails based on speed formula
- Boss encounter: flee always fails; status immunities apply

**Save/Load Tests:**
- Save in mid-dungeon state; reload; verify position, party, quests, inventory
- Save file corruption test: corrupted JSON handled gracefully (error shown, game does not crash)

**Party Management Tests:**
- Swap active/reserve member; verify formation bonuses recalculate
- Morale triggers at correct HP events; clamps to 0 and 100

**Dialogue Tests:**
- Multi-branch dialogue follows correct path based on choices
- Dialogue triggered mid-battle does not break ATB processing

**Quest Tests:**
- Objective completion triggers correct quest state change
- Completing quest with `complete_quest()` also fires signal and grants reward

---

## 8. Completion Checklist

- [ ] All 5 Resource types implemented and loadable
- [ ] All 7 autoloads implemented with required properties, methods, and signals
- [ ] All 5 required scenes implemented with specified node structure
- [ ] Implementation order followed (each step integration-tested before next)
- [ ] All code passes mandatory code review criteria
- [ ] All integration test scenarios pass
- [ ] No debug print statements in codebase
- [ ] No untyped variables or untyped function signatures
- [ ] AudioManager BGM fades work at all 3 game speeds
- [ ] SaveManager handles 3 slots independently
- [ ] BattleManager ATB formula matches GDD specification exactly
- [ ] Damage formulas validated against GDD test cases
- [ ] Status effect durations and tick effects match GDD specification
- [ ] Dialogue system supports branching choices
- [ ] World map triggers random encounters at correct rate
- [ ] Full loop tested: main menu → new game → world map → battle → save → load
- [ ] Core Developer formal sign-off recorded (name + date)

**Gate Signed Off By:** _________________________ **Date:** _____________

---

*Proceed to Phase 4: Art Production only after all gate items are checked.*
