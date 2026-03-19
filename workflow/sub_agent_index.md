# Sub-Agent Index — ChatDevV2 v3.0

> Quick-reference table of all 49 sub-agents across 7 phases.
>
> **Legend:** Each row is one LLM session. Run in numerical order within each phase. Never start a new phase until its predecessor's QA gate shows **PASS**.

---

## Phase 1 — Concept & Story (7 sub-agents · ~52 min)

| ID | Name | Role | Est. Min | Output File |
|----|------|------|----------|-------------|
| 1.1 | High Concept Document Author | `game_director` | 7 | `docs/phase_1/high_concept_document.md` |
| 1.2 | World Lore Bible Author | `story_writer` | 10 | `docs/phase_1/world_lore_bible.md` |
| 1.3 | Playable Race Profiles Author | `story_writer` | 8 | `docs/phase_1/race_profiles.md` |
| 1.4 | 3-Act Story Arc Author | `story_writer` | 8 | `docs/phase_1/story_arc_outline.md` |
| 1.5 | Main Character Roster Author | `story_writer` | 8 | `docs/phase_1/character_roster.md` |
| 1.6 | Sidequest Hooks Author | `story_writer` | 6 | `docs/phase_1/sidequest_hooks.md` |
| **1.7** | **Phase 1 QA Gate** ✅ | `qa_agent` | 5 | `docs/phase_1/qa_review_phase_1.md` |

---

## Phase 2 — Game Design Document (8 sub-agents · ~67 min)

> **Requires:** Phase 1 QA gate PASS

| ID | Name | Role | Est. Min | Output File |
|----|------|------|----------|-------------|
| 2.1 | Combat System Designer | `game_designer` | 10 | `docs/phase_2/combat_system_spec.md` |
| 2.2 | Skill System Designer | `game_designer` | 10 | `docs/phase_2/skill_system_design.md` |
| 2.3 | Magic System Designer | `game_designer` | 8 | `docs/phase_2/magic_system_design.md` |
| 2.4 | Race Ability Tables Author | `game_designer` | 7 | `docs/phase_2/race_ability_tables.md` |
| 2.5 | Progression Curve Designer | `game_designer` | 8 | `docs/phase_2/progression_curve.md` |
| 2.6 | Item & Equipment Taxonomy Author | `game_designer` | 7 | `docs/phase_2/item_taxonomy.md` |
| 2.7 | Enemy Roster Designer | `game_designer` | 10 | `docs/phase_2/enemy_roster.md` |
| **2.8** | **Phase 2 QA Gate** ✅ | `qa_agent` | 7 | `docs/phase_2/qa_review_phase_2.md` |

---

## Phase 3 — Development (13 sub-agents · ~119 min)

> **Requires:** Phase 2 QA gate PASS

| ID | Name | Role | Est. Min | Output File |
|----|------|------|----------|-------------|
| 3.1 | BattleManager Developer | `core_developer` | 10 | `godot_base/scripts/autoloads/BattleManager.gd` |
| 3.2 | SkillSystem Developer | `core_developer` | 9 | `godot_base/scripts/autoloads/SkillSystem.gd` |
| 3.3 | MagicSystem Developer | `core_developer` | 9 | `godot_base/scripts/autoloads/MagicSystem.gd` |
| 3.4 | PartyManager Developer | `core_developer` | 8 | `godot_base/scripts/autoloads/PartyManager.gd` |
| 3.5 | ProgressionManager Developer | `core_developer` | 8 | `godot_base/scripts/autoloads/ProgressionManager.gd` |
| 3.6 | InventoryManager Developer | `core_developer` | 8 | `godot_base/scripts/autoloads/InventoryManager.gd` |
| 3.7 | SaveLoadManager Developer | `core_developer` | 9 | `godot_base/scripts/autoloads/SaveLoadManager.gd` |
| 3.8 | DialogueSystem Developer | `core_developer` | 9 | `godot_base/scripts/autoloads/DialogueSystem.gd` |
| 3.9 | QuestManager Developer | `core_developer` | 8 | `godot_base/scripts/autoloads/QuestManager.gd` |
| 3.10 | BattleScene Developer | `core_developer` | 10 | `godot_base/scenes/battle_scene.tscn` |
| 3.11 | WorldMap Scene Developer | `core_developer` | 9 | `godot_base/scenes/world_map.tscn` |
| 3.12 | HUD Scene Developer | `core_developer` | 7 | `godot_base/scenes/hud.tscn` |
| **3.13** | **Phase 3 QA Gate** ✅ | `qa_agent` | 5 | `docs/phase_3/qa_review_phase_3.md` |

---

## Phase 4 — Art Production (6 sub-agents · ~43 min)

> **Requires:** Phase 3 QA gate PASS

| ID | Name | Role | Est. Min | Output File |
|----|------|------|----------|-------------|
| 4.1 | Art Style Guide Author | `game_artist` | 9 | `docs/phase_4/art_style_guide.md` |
| 4.2 | Character Sprite Specifications Author | `game_artist` | 8 | `docs/phase_4/character_sprite_specs.md` |
| 4.3 | Tileset Specifications Author | `game_artist` | 8 | `docs/phase_4/tileset_specs.md` |
| 4.4 | UI Art Specifications Author | `game_artist` | 7 | `docs/phase_4/ui_art_specs.md` |
| 4.5 | VFX & Spell Effect Specifications Author | `game_artist` | 6 | `docs/phase_4/vfx_specs.md` |
| **4.6** | **Phase 4 QA Gate** ✅ | `qa_agent` | 5 | `docs/phase_4/qa_review_phase_4.md` |

---

## Phase 5 — Sound Design (5 sub-agents · ~35 min)

> **Requires:** Phase 4 QA gate PASS

| ID | Name | Role | Est. Min | Output File |
|----|------|------|----------|-------------|
| 5.1 | Music Track List Author | `sound_designer` | 8 | `docs/phase_5/music_track_list.md` |
| 5.2 | SFX Library Author | `sound_designer` | 8 | `docs/phase_5/sfx_library.md` |
| 5.3 | Godot AudioBus Layout Author | `sound_designer` | 6 | `docs/phase_5/audio_bus_layout.md` |
| 5.4 | Audio Implementation Guide Author | `sound_designer` | 7 | `docs/phase_5/audio_implementation_guide.md` |
| **5.5** | **Phase 5 QA Gate** ✅ | `qa_agent` | 6 | `docs/phase_5/qa_review_phase_5.md` |

---

## Phase 6 — Testing & QA (5 sub-agents · ~43 min)

> **Requires:** Phase 5 QA gate PASS

| ID | Name | Role | Est. Min | Output File |
|----|------|------|----------|-------------|
| 6.1 | Combat Test Plan Author | `game_tester` | 10 | `docs/phase_6/combat_test_plan.md` |
| 6.2 | Progression & Inventory Test Plan Author | `game_tester` | 8 | `docs/phase_6/progression_test_plan.md` |
| 6.3 | World Navigation Test Plan Author | `game_tester` | 8 | `docs/phase_6/world_navigation_test_plan.md` |
| 6.4 | Regression Test Suite Author | `game_tester` | 8 | `docs/phase_6/regression_test_suite.md` |
| **6.5** | **Phase 6 QA Gate** ✅ | `qa_agent` | 9 | `docs/phase_6/qa_review_phase_6.md` |

---

## Phase 7 — Launch & Release (5 sub-agents · ~40 min)

> **Requires:** Phase 6 QA gate PASS

| ID | Name | Role | Est. Min | Output File |
|----|------|------|----------|-------------|
| 7.1 | Godot Export Config Author | `game_launcher` | 7 | `docs/phase_7/export_config.md` |
| 7.2 | Launch Checklist Author | `game_launcher` | 8 | `docs/phase_7/launch_checklist.md` |
| 7.3 | Store Page Copy Author | `game_launcher` | 7 | `docs/phase_7/store_page_copy.md` |
| 7.4 | Release Notes & Roadmap Author | `game_launcher` | 7 | `docs/phase_7/release_notes_v1.0.0.md` |
| **7.5** | **Final Studio Sign-Off** 🏁 | `qa_agent` | 11 | `docs/phase_7/qa_review_final_signoff.md` |

---

## Summary

| Phase | Sub-Agents | Est. Total Minutes |
|-------|-----------|-------------------|
| 1 — Concept & Story | 7 | 52 |
| 2 — Game Design Document | 8 | 67 |
| 3 — Development | 13 | 119 |
| 4 — Art Production | 6 | 43 |
| 5 — Sound Design | 5 | 35 |
| 6 — Testing & QA | 5 | 43 |
| 7 — Launch & Release | 5 | 40 |
| **Total** | **49** | **399** |

---

## Role File Reference

| Role ID | Role File | Used By Sub-Agents |
|---------|-----------|-------------------|
| `game_director` | `roles/game_director.json` | 1.1 |
| `story_writer` | `roles/story_writer.json` | 1.2, 1.3, 1.4, 1.5, 1.6 |
| `game_designer` | `roles/game_designer.json` | 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7 |
| `core_developer` | `roles/core_developer.json` | 3.1–3.12 |
| `game_artist` | `roles/game_artist.json` | 4.1, 4.2, 4.3, 4.4, 4.5 |
| `sound_designer` | `roles/sound_designer.json` | 5.1, 5.2, 5.3, 5.4 |
| `game_tester` | `roles/game_tester.json` | 6.1, 6.2, 6.3, 6.4 |
| `game_launcher` | `roles/game_launcher.json` | 7.1, 7.2, 7.3, 7.4 |
| `qa_agent` | `roles/qa_agent.json` | 1.7, 2.8, 3.13, 4.6, 5.5, 6.5, 7.5 |

---

*For step-by-step instructions on running each sub-agent, see [`workflow/agent_runner_guide.md`](./agent_runner_guide.md).*

*ChatDevV2 v3.0 — PixelForge Studios*
