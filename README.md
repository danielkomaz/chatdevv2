# ChatDevV2 — JRPG Studio Workflow

> A multi-agent LLM workflow simulator powering a complete 2D pixel art JRPG game development studio in Godot 4.
>
> **v3.0** — 49 focused sub-agents across 7 phases. Each sub-agent has one output file and completes in ≤ 10 minutes, preventing session timeouts.

## Workflow Version: 3.0 — Multi-Agent Architecture

Version 3.0 introduces a **multi-agent phase design** that eliminates session timeouts by breaking every phase into focused sub-agents. Each sub-agent has exactly one scoped deliverable, completes in under 10 minutes, and hands off cleanly to the next via committed files.

### Why Multi-Agent?

Previous versions assigned one agent to an entire phase. A phase like Development required generating 13+ scripts, scene files, and JSON data in a single session — routinely hitting the 59-minute timeout limit before completing.

**v3.0 solves this:** 49 sub-agents across 7 phases, each with a 5–10 minute scope.

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
