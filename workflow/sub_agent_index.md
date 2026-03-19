# Sub-Agent Index — ChatDevV2 Workflow v3.0

Quick-reference table of all 49 sub-agents across all 7 phases. Use this to find any sub-agent quickly, check its dependencies, and locate its output file.

> **Full definitions** (scope, inputs, output descriptions, system_prompt_override) are in `workflow/jrpg_studio_workflow.json`.
> **How to run a sub-agent** is in `workflow/agent_runner_guide.md`.

---

## All Sub-Agents

| Sub-Agent ID | Agent Name | Role | Phase | Output File | Est. Min | Depends On |
|---|---|---|---|---|---|---|
| p1_a1 | Game Vision Setter | game_director | 1 — Concept & Story | docs/phase1/high_concept.md | 5 | — |
| p1_a2 | World Lore Architect | story_writer | 1 — Concept & Story | docs/phase1/world_lore.md | 8 | p1_a1 |
| p1_a3 | Race Designer | story_writer | 1 — Concept & Story | docs/phase1/race_profiles.md | 8 | p1_a2 |
| p1_a4 | Story Arc Writer | story_writer | 1 — Concept & Story | docs/phase1/story_arc.md | 9 | p1_a2, p1_a3 |
| p1_a5 | Character Roster Writer | story_writer | 1 — Concept & Story | docs/phase1/character_roster.md | 9 | p1_a4 |
| p1_a6 | Villain & Sidequest Writer | story_writer | 1 — Concept & Story | docs/phase1/villain_and_sidequests.md | 7 | p1_a5 |
| p1_a7 | Phase 1 Story Reviewer | qa_agent | 1 — Concept & Story | docs/phase1/qa_review.md | 6 | p1_a6 |
| p2_a1 | Combat System Designer | game_designer | 2 — Game Design Document | docs/phase2/combat_system.md | 9 | p1_a7 |
| p2_a2 | Skill System Designer | game_designer | 2 — Game Design Document | docs/phase2/skill_system.md | 10 | p2_a1 |
| p2_a3 | Magic System Designer | game_designer | 2 — Game Design Document | docs/phase2/magic_system.md | 10 | p2_a1 |
| p2_a4 | Progression System Designer | game_designer | 2 — Game Design Document | docs/phase2/progression_system.md | 8 | p2_a2, p2_a3 |
| p2_a5 | Enemy & Item Designer | game_designer | 2 — Game Design Document | docs/phase2/enemies_and_items.md | 10 | p2_a4 |
| p2_a6 | UI & World Structure Designer | game_designer | 2 — Game Design Document | docs/phase2/ui_and_world.md | 8 | p2_a5 |
| p2_a7 | GDD Assembler & Approver | game_director | 2 — Game Design Document | docs/phase2/GDD_master.md | 6 | p2_a6 |
| p2_a8 | Phase 2 Balance Reviewer | qa_agent | 2 — Game Design Document | docs/phase2/qa_review.md | 7 | p2_a7 |
| p3_a1 | Project Scaffolder | core_developer | 3 — Development | godot/project.godot | 7 | p2_a8 |
| p3_a2 | Data Resources Developer | core_developer | 3 — Development | godot/scripts/data/ | 8 | p3_a1 |
| p3_a3 | Battle Manager Developer | core_developer | 3 — Development | godot/scripts/battle/BattleManager.gd | 10 | p3_a2 |
| p3_a4 | Skill & Magic System Developer | core_developer | 3 — Development | godot/scripts/battle/ | 10 | p3_a3 |
| p3_a5 | Character & Party System Developer | core_developer | 3 — Development | godot/scripts/characters/ | 10 | p3_a2 |
| p3_a6 | Progression & Inventory Developer | core_developer | 3 — Development | godot/scripts/systems/ | 9 | p3_a5 |
| p3_a7 | Save, Audio & Scene Transition Developer | core_developer | 3 — Development | godot/scripts/systems/ | 10 | p3_a6 |
| p3_a8 | Dialogue & Quest System Developer | core_developer | 3 — Development | godot/scripts/story/ | 9 | p3_a7 |
| p3_a9 | World & Player Scripts Developer | core_developer | 3 — Development | godot/scripts/world/ | 8 | p3_a8 |
| p3_a10 | UI Scripts Developer | core_developer | 3 — Development | godot/scripts/ui/ | 10 | p3_a9 |
| p3_a11 | Scene Files Creator | core_developer | 3 — Development | godot/scenes/ | 8 | p3_a10 |
| p3_a12 | Game Data JSON Creator | core_developer | 3 — Development | godot/data/ | 10 | p3_a11 |
| p3_a13 | Phase 3 Code Reviewer | qa_agent | 3 — Development | docs/phase3/qa_review.md | 8 | p3_a12 |
| p4_a1 | Art Style Guide Author | game_artist | 4 — Art Production | docs/phase4/art_style_guide.md | 7 | p3_a13 |
| p4_a2 | Character Art Specs Author | game_artist | 4 — Art Production | docs/phase4/character_art_specs.md | 8 | p4_a1 |
| p4_a3 | Enemy & Environment Art Specs Author | game_artist | 4 — Art Production | docs/phase4/enemy_and_environment_art_specs.md | 9 | p4_a2 |
| p4_a4 | UI & Effects Art Specs Author | game_artist | 4 — Art Production | docs/phase4/ui_and_effects_art_specs.md | 8 | p4_a3 |
| p4_a5 | Art Direction Approver | game_director | 4 — Art Production | docs/phase4/art_direction_approval.md | 5 | p4_a4 |
| p4_a6 | Phase 4 Art Consistency Reviewer | qa_agent | 4 — Art Production | docs/phase4/qa_review.md | 6 | p4_a5 |
| p5_a1 | Audio Direction Author | sound_designer | 5 — Sound Design | docs/phase5/audio_direction.md | 7 | p4_a6 |
| p5_a2 | Music Track Specs Author | sound_designer | 5 — Sound Design | docs/phase5/music_track_specs.md | 9 | p5_a1 |
| p5_a3 | SFX Library & Integration Mapper | sound_designer | 5 — Sound Design | docs/phase5/sfx_library.md | 8 | p5_a2 |
| p5_a4 | Audio Direction Approver | game_director | 5 — Sound Design | docs/phase5/audio_approval.md | 5 | p5_a3 |
| p5_a5 | Phase 5 Audio Completeness Reviewer | qa_agent | 5 — Sound Design | docs/phase5/qa_review.md | 6 | p5_a4 |
| p6_a1 | Battle System Test Planner | game_tester | 6 — Testing & QA | docs/phase6/battle_test_cases.md | 9 | p5_a5 |
| p6_a2 | Systems Test Planner | game_tester | 6 — Testing & QA | docs/phase6/systems_test_cases.md | 9 | p6_a1 |
| p6_a3 | Story & UI Test Planner | game_tester | 6 — Testing & QA | docs/phase6/story_and_ui_test_cases.md | 8 | p6_a2 |
| p6_a4 | Cross-Phase Consistency Auditor | qa_agent | 6 — Testing & QA | docs/phase6/cross_phase_audit.md | 10 | p6_a3 |
| p6_a5 | Bug Tracker & Sign-Off Author | qa_agent | 6 — Testing & QA | docs/phase6/qa_signoff_checklist.md | 7 | p6_a4 |
| p7_a1 | Export Config Author | game_launcher | 7 — Launch & Release | godot/export_presets.cfg | 6 | p6_a5 |
| p7_a2 | Launch Checklist Author | game_launcher | 7 — Launch & Release | docs/phase7/launch_checklist.md | 8 | p7_a1 |
| p7_a3 | Store Pages & Press Kit Author | game_launcher | 7 — Launch & Release | docs/phase7/store_pages.md | 8 | p7_a2 |
| p7_a4 | Release Notes & Support Plan Author | game_launcher | 7 — Launch & Release | docs/phase7/release_notes_v1.0.0.md | 6 | p7_a3 |
| p7_a5 | Final Pre-Release Smoke Tester | qa_agent | 7 — Launch & Release | docs/phase7/final_smoke_test.md | 7 | p7_a4 |

---

## Sub-Agent Counts by Phase

| Phase | Name | Sub-Agents | Total Est. Minutes |
|-------|------|-----------|-------------------|
| 1 | Concept & Story | 7 | 52 |
| 2 | Game Design Document | 8 | 67 |
| 3 | Development | 13 | 119 |
| 4 | Art Production | 6 | 43 |
| 5 | Sound Design | 5 | 35 |
| 6 | Testing & QA | 5 | 43 |
| 7 | Launch & Release | 5 | 40 |
| **Total** | | **49** | **399** |

---

## Sub-Agents by Role

| Role | Sub-Agent IDs |
|------|--------------|
| game_director | p1_a1, p2_a7, p4_a5, p5_a4, p7_a1 *(via game_launcher)* |
| story_writer | p1_a2, p1_a3, p1_a4, p1_a5, p1_a6 |
| game_designer | p2_a1, p2_a2, p2_a3, p2_a4, p2_a5, p2_a6 |
| core_developer | p3_a1, p3_a2, p3_a3, p3_a4, p3_a5, p3_a6, p3_a7, p3_a8, p3_a9, p3_a10, p3_a11, p3_a12 |
| game_artist | p4_a1, p4_a2, p4_a3, p4_a4 |
| sound_designer | p5_a1, p5_a2, p5_a3 |
| game_tester | p6_a1, p6_a2, p6_a3 |
| qa_agent | p1_a7, p2_a8, p3_a13, p4_a6, p5_a5, p6_a4, p6_a5, p7_a5 |
| game_launcher | p7_a1, p7_a2, p7_a3, p7_a4 |

---

## Quality Gates

Each phase ends with a QA sub-agent whose output must PASS before the next phase begins:

| Gate | After Phase | Enforcing Sub-Agent | Enforcing Role |
|------|------------|---------------------|---------------|
| Story Lock Gate | Phase 1 | p1_a7 | qa_agent |
| GDD Approval Gate | Phase 2 | p2_a8 | qa_agent |
| Code Review Gate | Phase 3 | p3_a13 | qa_agent |
| Art Consistency Gate | Phase 4 | p4_a6 | qa_agent |
| Audio Completeness Gate | Phase 5 | p5_a5 | qa_agent |
| QA Sign-Off Gate | Phase 6 | p6_a5 | qa_agent |
| Release Readiness Gate | Phase 7 | p7_a5 | qa_agent |
