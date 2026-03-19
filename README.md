# ChatDevV2 — JRPG Studio Workflow

A multi-agent AI workflow system for developing a complete JRPG game using Godot 4, powered by PixelForge Studios' role-based AI pipeline.

## Workflow Version: 3.0 — Multi-Agent Architecture

Version 3.0 introduces a **multi-agent phase design** that eliminates session timeouts by breaking every phase into focused sub-agents. Each sub-agent has exactly one scoped deliverable, completes in under 10 minutes, and hands off cleanly to the next via committed files.

### Why Multi-Agent?

Previous versions assigned one agent to an entire phase. A phase like Development required generating 13+ scripts, scene files, and JSON data in a single session — routinely hitting the 59-minute timeout limit before completing.

**v3.0 solves this:** 49 sub-agents across 7 phases, each with a 5–10 minute scope.

---

## Quick Start

1. Read the **[Agent Runner Guide](workflow/agent_runner_guide.md)** to understand how to run sub-agents
2. Consult the **[Sub-Agent Index](workflow/sub_agent_index.md)** to find the next sub-agent to run
3. Open `workflow/jrpg_studio_workflow.json` for the full workflow definition
4. Start with sub-agent `p1_a1` (Game Vision Setter)

---

## Phases & Sub-Agent Counts

| Phase | Name | Sub-Agents | Lead Role |
|-------|------|-----------|-----------|
| 1 | Concept & Story | 7 | game_director |
| 2 | Game Design Document | 8 | game_designer |
| 3 | Development | 13 | core_developer |
| 4 | Art Production | 6 | game_artist |
| 5 | Sound Design | 5 | sound_designer |
| 6 | Testing & QA | 5 | qa_agent |
| 7 | Launch & Release | 5 | game_launcher |
| **Total** | | **49** | |

---

## Repository Structure

chatdevv2/ ├── workflow/ │ ├── jrpg_studio_workflow.json # Full v3.0 workflow definition │ ├── agent_runner_guide.md # How to run sub-agents │ └── sub_agent_index.md # Quick-reference table of all 49 sub-agents ├── roles/ │ ├── game_director.json │ ├── game_designer.json │ ├── core_developer.json │ ├── game_artist.json │ ├── sound_designer.json │ ├── game_tester.json │ ├── qa_agent.json │ ├── game_launcher.json │ └── story_writer.json ├── prompts/ # Reusable prompt templates ├── templates/ # Output document templates ├── godot_base/ # Base Godot 4 project files └── docs/ # Generated phase outputs (created by agents) ├── phase1/ # Story & concept documents ├── phase2/ # GDD documents ├── phase3/ # Code review reports ├── phase4/ # Art spec documents ├── phase5/ # Audio spec documents ├── phase6/ # QA reports and test cases └── phase7/ # Launch and release documents

Code

---

## Roles

| Role | Responsibilities |
|------|----------------|
| **game_director** | Creative vision, approvals, escalation handling |
| **story_writer** | World lore, characters, narrative, quests |
| **game_designer** | Game mechanics, balance, GDD, enemy/item design |
| **core_developer** | Godot 4 / GDScript implementation |
| **game_artist** | Art direction, sprite/tileset/UI specifications |
| **sound_designer** | Music composition, SFX design, audio integration |
| **game_tester** | Test case authoring and manual execution |
| **qa_agent** | Code/document review, consistency auditing, sign-off |
| **game_launcher** | Platform export, store pages, release management |

---

## Quality Gates

Every phase ends with a QA sub-agent review. The next phase **cannot begin** until the QA sub-agent produces a PASS report.

| Gate | After Phase | Criteria Summary |
|------|------------|-----------------|
| Story Lock | Phase 1 | No plot holes, all races complete, story arc approved |
| GDD Approval | Phase 2 | No undefined mechanics, balance validated |
| Code Review | Phase 3 | Godot 4 compliance, all autoloads functional |
| Art Consistency | Phase 4 | Palette compliance, no missing assets |
| Audio Completeness | Phase 5 | All events mapped, all tracks specified |
| QA Sign-Off | Phase 6 | Zero critical bugs, all tests documented |
| Release Readiness | Phase 7 | All builds verified, store pages submitted |

---

## Design Principles (v3.0)

1. **One deliverable per agent** — each sub-agent writes exactly one output file
2. **File-based handoffs** — inputs and outputs are always file paths (resumable at any point)
3. **Explicit role personas** — every sub-agent references a role JSON for its system prompt
4. **Timeout budget enforced** — all `estimated_minutes` values are ≤ 10
5. **QA in every phase** — each phase ends with a qa_agent review sub-agent
6. **Machine-readable dependencies** — `depends_on` arrays make execution order explicit

---

## Game: Dungeon Town

The game being developed with this workflow is **Dungeon Town**, a 2D pixel art JRPG built in Godot 4 by PixelForge Studios.

- **Genre:** JRPG
- **Engine:** Godot 4
- **Art Style:** 2D Pixel Art (16x16 tiles, 32x32 characters)
- **Target Platforms:** Windows, Linux, macOS, Web/HTML5

---

## Links

- [Agent Runner Guide](workflow/agent_runner_guide.md) — How to run sub-agents step by step
- [Sub-Agent Index](workflow/sub_agent_index.md) — All 49 sub-agents at a glance
- [Workflow JSON](workflow/jrpg_studio_workflow.json) — Full machine-readable workflow definition
