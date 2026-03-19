# ChatDevV2 — PixelForge JRPG Game Studio Workflow

> A multi-agent LLM workflow simulator powering a complete 2D pixel art JRPG game development studio in Godot 4.
>
> **v3.0** — 49 focused sub-agents across 7 phases. Each sub-agent has one output file and completes in ≤ 10 minutes, preventing session timeouts.

---

## What is ChatDevV2?

**ChatDevV2** is a structured multi-agent Large Language Model (LLM) workflow simulator that models an entire game development studio as a team of specialized AI agents. Each agent inhabits a distinct professional role — from Game Director to Sound Designer — and produces real, usable artifacts such as GDDs, GDScript source files, art briefs, audio cue lists, QA reports, and release checklists.

The studio — **PixelForge Studios** — is building a full-featured 2D pixel art JRPG in **Godot 4**. The game includes a turn-based battle system, a multi-race party system, a skill and magic framework, a deep narrative with branching dialogue, and a polished release pipeline targeting PC and Web platforms.

ChatDevV2 enables developers, designers, and LLM researchers to simulate professional-grade game production pipelines using prompt engineering. Each role has a detailed system prompt designed to guide an LLM to reason, plan, and produce output exactly as that professional would.

### v3.0 Architecture — Why Multi-Agent?

The v2.0 workflow assigned one AI agent per phase. Phase 3 (Development) required generating 13+ scripts and scene files in a single session — consistently hitting the 59-minute timeout limit. **v3.0 solves this with 49 focused sub-agents**, each scoped to exactly one output file:

| Property | v2.0 | v3.0 |
|----------|------|------|
| Sub-agents per phase | 1 | 5–13 |
| Output files per session | Many | **1** |
| Estimated session time | Up to 59 min | **≤ 10 min** |
| Resumable on failure | No | **Yes** |
| Phase gate QA review | Optional | **Required** |

---

## Studio Roles

| # | Role | Emoji | Responsibility |
|---|------|-------|----------------|
| 1 | Game Director | 🎬 | Overall creative vision, milestone approval, cross-team alignment, quality bar enforcement |
| 2 | Game Designer | ⚙️ | Combat balance, skill/magic systems, race mechanics, progression curves, GDD authorship |
| 3 | Core Developer | 💻 | Godot 4 GDScript implementation, scene architecture, systems programming, save/load |
| 4 | Game Artist | 🎨 | Pixel art direction, sprite sheets, tile sets, palettes, UI design, animation briefs |
| 5 | Sound Designer | 🎵 | Chiptune/orchestral hybrid soundtrack, SFX library, audio cue mapping, music loops |
| 6 | Game Tester | 🔍 | Test case authorship, regression testing, edge case hunting, bug reports with repro steps |
| 7 | QA Agent | ✅ | Cross-phase quality gating, code style enforcement, art consistency, design balance audits |
| 8 | Game Launcher | 🚀 | Export pipeline (Win/Linux/Mac/Web), versioning, release notes, store page copy, post-launch plan |
| 9 | Story Writer | 📖 | World lore, race backstories, 3-act narrative, character arcs, dialogue scripts, sidequests |

---

## 7-Phase Workflow Pipeline

1. **Concept & Story** — The Game Director and Story Writer establish the foundational creative vision. This phase produces the High Concept Document, world lore bible, playable race profiles, main story arc outline, and initial character rosters. Nothing moves forward without a locked story foundation.

2. **Game Design Document (GDD)** — The Game Designer, reviewed by the Game Director, translates the story and concept into formal mechanical design. This includes the complete battle system design, skill trees, magic schools, race ability tables, progression curves, item/equipment taxonomies, and UI flow diagrams. The GDD is the single source of truth for all subsequent phases.

3. **Development** — The Core Developer implements all designed systems in Godot 4 GDScript. This includes the turn-based battle engine, skill and magic system, party management, scene transitions, dialogue system, save/load framework, and all autoloaded singletons. Code is modular, commented, and fully functional.

4. **Art Production** — The Game Artist produces detailed art briefs and pixel art assets for every character race, environment tileset, UI element, spell effect, and animation. Art direction enforces consistent palettes, grid alignment, and sprite sheet standards across the entire game.

5. **Sound Design** — The Sound Designer composes and catalogs all music tracks (town, dungeon, world map, battle, boss) and SFX (UI clicks, footsteps, magic casts, skill activations, fanfares, game over stings). All audio is spec'd for Godot's AudioStreamPlayer integration.

6. **Testing & QA** — The Game Tester writes and executes comprehensive test plans covering every mechanic, edge case, and player path. The QA Agent reviews all cross-phase deliverables for consistency, style compliance, and completeness before final approval.

7. **Launch & Release** — The Game Launcher configures Godot export presets for all target platforms, writes release notes, manages SemVer versioning, creates store page descriptions, and defines the post-launch support roadmap.

---

## How to Use the Workflow

> **New to v3.0?** Start with the step-by-step guide: [`workflow/agent_runner_guide.md`](workflow/agent_runner_guide.md)
> For a quick overview of all 49 sub-agents: [`workflow/sub_agent_index.md`](workflow/sub_agent_index.md)

1. **Clone the repository** and review the `roles/` directory to understand each agent's system prompt and responsibilities.
2. **Open your preferred LLM interface** (e.g., ChatGPT, Claude, local model via Ollama).
3. **Load a role's system prompt** from its JSON file (`roles/<role_id>.json` → `system_prompt` field) as the LLM system message.
4. **Run sub-agents in order** as defined in `workflow/jrpg_studio_workflow.json`. Each sub-agent reads committed files as inputs and produces exactly one output file.
5. **Commit each output file** immediately after collection so the next sub-agent can use it as input.
6. **Pass the QA phase gate** at the end of each phase (sub-agents 1.7, 2.8, 3.13, 4.6, 5.5, 6.5, 7.5) before proceeding to the next phase.
7. **Iterate** — sub-agents can be re-run independently with feedback until they meet the completion criteria defined in each sub-agent entry.

> **Tip:** Because each sub-agent commits one file, any failed or interrupted session can be resumed from exactly where it left off.

---

## JRPG Game Features

The game being developed by PixelForge Studios includes:

- **Turn-Based Combat** — Classic ATB-adjacent system with action menus, enemy AI, and combo mechanics
- **Skill System** — Characters learn active and passive skills via level-up and skill books; skills have MP costs, cooldowns, and targeting rules
- **Magic System** — Six elemental schools (Fire, Ice, Thunder, Wind, Earth, Void); spells have power tiers (I, II, III), area-of-effect variants, and status effect riders
- **Playable Races** — Multiple races (e.g., Human, Elf, Dwarf, Beastkin, Undead) each with unique stat arrays, innate abilities, and cultural story hooks
- **Party System** — Up to 4 active party members drawn from a larger roster; formation bonuses, relationship affinity system, and guest party members
- **Story** — 3-act main narrative with a central villain, political intrigue, and cosmic stakes; branching dialogue with relationship flags; 15+ sidequests
- **Progression** — Level-based XP system, equipment slots (weapon, armor, accessory ×2), item crafting, and a New Game+ mode
- **World** — Overworld map with towns, dungeons, and hidden areas; fast travel after first visit; day/night cycle affecting NPC schedules and enemy encounters

---

## Godot 4 Project Setup

```bash
# 1. Open Godot 4 (4.2+ recommended)
# 2. Create a new project pointing to godot_base/
# 3. Set the renderer to Compatibility (for pixel art + web export)
# 4. Import the project; Godot will index all scenes and resources

# Project settings to configure:
# - Display > Window > Size: 320x180 (base), stretch mode: canvas_items
# - Display > Window > Pixel Snap: enabled
# - Rendering > Textures > Default Texture Filter: Nearest (pixel-perfect)
# - Input Map: configure action keys (ui_accept, ui_cancel, battle_*)
```

**Recommended Godot Plugins:**
- `gdUnit4` — unit testing framework for GDScript
- `Dialogic 2` — dialogue system (or use the custom dialogue engine in `scripts/dialogue/`)
- `Phantom Camera` — smooth camera control for overworld and battle scenes

---

## Directory Structure

```
chatdevv2/
├── README.md                        # This file
├── workflow/
│   ├── jrpg_studio_workflow.json    # Full v3.0 pipeline — 49 sub-agents across 7 phases
│   ├── agent_runner_guide.md        # Step-by-step guide for running sub-agents on any LLM
│   └── sub_agent_index.md           # Quick-reference table of all 49 sub-agents
├── roles/
│   ├── game_director.json           # 🎬 Creative lead system prompt + metadata
│   ├── game_designer.json           # ⚙️  Mechanics designer system prompt + metadata
│   ├── core_developer.json          # 💻 Godot 4 developer system prompt + metadata
│   ├── game_artist.json             # 🎨 Pixel artist system prompt + metadata
│   ├── sound_designer.json          # 🎵 Audio director system prompt + metadata
│   ├── game_tester.json             # 🔍 QA tester system prompt + metadata
│   ├── qa_agent.json                # ✅ Quality gating agent system prompt + metadata
│   ├── game_launcher.json           # 🚀 Release engineer system prompt + metadata
│   └── story_writer.json            # 📖 Narrative designer system prompt + metadata
├── prompts/
│   └── (phase-specific prompt templates)
├── templates/
│   └── (GDD templates, test plan templates, art brief templates)
└── godot_base/
    └── (Godot 4 project skeleton)
```

---

## Quick Start — Example Usage

### Run the Story Writer for Phase 1

```
SYSTEM: <paste contents of roles/story_writer.json → system_prompt>

USER: We are starting Phase 1 of the PixelForge JRPG project.
Your task is to produce the World Lore Bible for our game.
The game features 5 playable races: Humans, Elves, Dwarves, Beastkin, and the Undead.
The world is called Aethermoor — a continent fractured by a cataclysm 500 years ago.
Please produce:
1. A 500-word world history summary
2. A profile for each of the 5 races (origin, culture, stats tendency, innate ability)
3. The 3-act main story arc outline (each act in 3-5 bullet points)
```

### Run the Game Designer for Phase 2

```
SYSTEM: <paste contents of roles/game_designer.json → system_prompt>

USER: Using the World Lore Bible from Phase 1, produce the Combat System section of the GDD.
Include: action menu structure, turn order formula, damage calculation formula,
status effect list (10 minimum), and a skill balance table for the Human Fighter class
(levels 1–20, 6 skills minimum, with MP cost, power rating, and unlock level).
```

### Run the Core Developer for Phase 3

```
SYSTEM: <paste contents of roles/core_developer.json → system_prompt>

USER: Implement the BattleManager autoload in GDScript for Godot 4.
It should handle: turn queue sorting, action resolution, damage calculation,
status effect application, and win/lose condition checking.
Follow the formulas defined in the GDD. Include full comments.
```

---

## Contributing

This repository is a living workflow template. To add a new role:
1. Create `roles/<new_role_id>.json` following the schema of existing role files.
2. Add the role to `workflow/jrpg_studio_workflow.json` under `roles_registry` and the relevant phases.
3. Update this README's roles table.

---

*Built with ❤️ and many GPU hours by PixelForge Studios × ChatDevV2*
