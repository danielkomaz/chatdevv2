# Agent Runner Guide — ChatDevV2 v3.0 Multi-Agent Workflow

> **Audience:** Anyone running the ChatDevV2 v3.0 workflow on any LLM platform (ChatGPT, Claude, GitHub Copilot, local models, etc.)

---

## Overview

The v3.0 workflow replaces the single-agent-per-phase model with **49 focused sub-agents** across 7 phases. Each sub-agent:

- Has **exactly one output file**
- Completes in **≤ 10 minutes**
- Reads committed files as inputs
- Commits one output file as its handoff

This design prevents session timeouts, makes every step resumable, and keeps each LLM session focused and high quality.

---

## Prerequisites

1. **Clone the repository** locally or access it via your LLM platform's file browsing.
2. **Confirm `main` branch is up to date** before starting any phase.
3. **Do not skip the QA sub-agent** at the end of each phase. The phase gate must PASS before the next phase begins.

---

## How to Run a Sub-Agent

### Step 1 — Identify the Sub-Agent

Open `workflow/jrpg_studio_workflow.json` and find the sub-agent you want to run. Each entry looks like:

```json
{
  "sub_agent_id": "1.2",
  "name": "world_lore_agent",
  "role": "story_writer",
  "title": "World Lore Bible Author",
  "description": "Write the World Lore Bible: world history, geography, and major factions.",
  "inputs": ["docs/phase_1/high_concept_document.md"],
  "output_file": "docs/phase_1/world_lore_bible.md",
  "estimated_minutes": 10,
  "completion_criteria": [...]
}
```

### Step 2 — Load the Role System Prompt

1. Open `roles/<role>.json` (e.g., `roles/story_writer.json`).
2. Copy the value of the `"system_prompt"` field.
3. Paste it as the **system message** (or first instruction) in your LLM session.

```
SYSTEM:
<paste the system_prompt value from roles/story_writer.json here>
```

### Step 3 — Provide the Inputs

For each file listed in the sub-agent's `"inputs"` array, paste the file contents into the user message, clearly labeled. For example:

```
USER:
## Input: docs/phase_1/high_concept_document.md

<paste full file contents here>

---

Your task: Write the World Lore Bible as described in your role. Save the result as `docs/phase_1/world_lore_bible.md`.

The output must satisfy all of the following completion criteria:
- 500+ word world history from founding era to present day
- Geography section with at least 6 named regions
- At least 4 factions with goals, leaders, and relationships to each other
```

### Step 4 — Collect and Commit the Output

1. Copy the LLM's entire response.
2. Create the output file at the path specified in `"output_file"`.
3. Commit the file to the repository with a clear message, e.g.:
   ```
   git add docs/phase_1/world_lore_bible.md
   git commit -m "feat(phase-1): add world lore bible [sub-agent 1.2]"
   git push
   ```

### Step 5 — Verify the Completion Criteria

Before moving to the next sub-agent, check off each item in the `"completion_criteria"` array. If any criteria are not met, re-prompt the LLM with feedback, collect the revised output, and update the committed file.

---

## Running the QA Phase Gate Sub-Agents

Each phase ends with a QA review sub-agent (e.g., `1.7`, `2.8`, `3.13`, etc.). These sub-agents:

1. Use the **`qa_agent`** role (`roles/qa_agent.json`).
2. Receive all phase output files as input.
3. Produce a single `qa_review_phase_N.md` file.
4. Must output an **overall verdict of PASS** before the next phase begins.

**If the verdict is FAIL:**
1. Read the mandatory fixes list in the QA review.
2. Re-run the relevant sub-agents from the failed phase.
3. Update the committed files.
4. Re-run the QA phase gate sub-agent.

---

## Platform-Specific Tips

### ChatGPT (GPT-4 / GPT-4o)

- Use the **Custom Instructions** or **System prompt** field for the role system prompt.
- For large inputs, split across multiple messages and ask the model to "hold state" between them.
- Each sub-agent session = one new conversation (fresh context, same system prompt).

### Claude (Anthropic)

- Paste the system prompt into the **System** block in the API or Claude.ai interface.
- Claude handles long inputs well; all phase inputs can typically be sent in one message.
- Use Projects (Claude.ai) to persist role context across sub-agent sessions in the same phase.

### GitHub Copilot Chat

- Reference files directly using `@workspace` or by attaching them.
- Start each sub-agent session with:
  > *"Act as the [Role Name]. Your system prompt is: [paste system_prompt]"*
- Use Copilot's inline chat for code-heavy sub-agents (Phase 3 Development).

### Local Models (Ollama, LM Studio, etc.)

- Set the system prompt via the `/system` parameter or config file.
- For models with smaller context windows, summarize large input files to the key facts needed.
- Recommended models: `llama3`, `mistral`, `codestral` (for Phase 3 code sub-agents).

---

## Sub-Agent Execution Order

Sub-agents within a phase must run in numerical order (e.g., `1.1` before `1.2` before `1.3`). The `depends_on` field on each phase indicates cross-phase dependencies — never start a phase until its predecessor's QA gate has PASSED.

```
Phase 1 → [1.1 → 1.2 → 1.3 → 1.4 → 1.5 → 1.6 → 1.7 QA GATE]
                                                         ↓ PASS
Phase 2 → [2.1 → 2.2 → 2.3 → 2.4 → 2.5 → 2.6 → 2.7 → 2.8 QA GATE]
                                                              ↓ PASS
Phase 3 → [3.1 → 3.2 → ... → 3.12 → 3.13 QA GATE]
                                          ↓ PASS
Phase 4 → [4.1 → 4.2 → 4.3 → 4.4 → 4.5 → 4.6 QA GATE]
                                              ↓ PASS
Phase 5 → [5.1 → 5.2 → 5.3 → 5.4 → 5.5 QA GATE]
                                         ↓ PASS
Phase 6 → [6.1 → 6.2 → 6.3 → 6.4 → 6.5 QA GATE]
                                         ↓ PASS
Phase 7 → [7.1 → 7.2 → 7.3 → 7.4 → 7.5 FINAL SIGN-OFF]
```

---

## Resuming a Failed or Interrupted Session

Because every sub-agent commits exactly one file, resuming is simple:

1. Check which files have been committed using `git log --oneline`.
2. Find the last committed output file in `workflow/sub_agent_index.md`.
3. Identify the next un-committed sub-agent.
4. Run that sub-agent, providing all its listed input files as context.

No work from previous sub-agents is lost — all outputs are committed and permanent.

---

## Output File Structure

All sub-agent outputs are organized under `docs/`:

```
docs/
├── phase_1/
│   ├── high_concept_document.md      # Sub-agent 1.1
│   ├── world_lore_bible.md           # Sub-agent 1.2
│   ├── race_profiles.md              # Sub-agent 1.3
│   ├── story_arc_outline.md          # Sub-agent 1.4
│   ├── character_roster.md           # Sub-agent 1.5
│   ├── sidequest_hooks.md            # Sub-agent 1.6
│   └── qa_review_phase_1.md          # Sub-agent 1.7 (QA gate)
├── phase_2/
│   ├── combat_system_spec.md         # Sub-agent 2.1
│   ├── skill_system_design.md        # Sub-agent 2.2
│   ├── magic_system_design.md        # Sub-agent 2.3
│   ├── race_ability_tables.md        # Sub-agent 2.4
│   ├── progression_curve.md          # Sub-agent 2.5
│   ├── item_taxonomy.md              # Sub-agent 2.6
│   ├── enemy_roster.md               # Sub-agent 2.7
│   └── qa_review_phase_2.md          # Sub-agent 2.8 (QA gate)
├── phase_3/
│   └── qa_review_phase_3.md          # Sub-agent 3.13 (QA gate)
├── phase_4/
│   ├── art_style_guide.md            # Sub-agent 4.1
│   ├── character_sprite_specs.md     # Sub-agent 4.2
│   ├── tileset_specs.md              # Sub-agent 4.3
│   ├── ui_art_specs.md               # Sub-agent 4.4
│   ├── vfx_specs.md                  # Sub-agent 4.5
│   └── qa_review_phase_4.md          # Sub-agent 4.6 (QA gate)
├── phase_5/
│   ├── music_track_list.md           # Sub-agent 5.1
│   ├── sfx_library.md                # Sub-agent 5.2
│   ├── audio_bus_layout.md           # Sub-agent 5.3
│   ├── audio_implementation_guide.md # Sub-agent 5.4
│   └── qa_review_phase_5.md          # Sub-agent 5.5 (QA gate)
├── phase_6/
│   ├── combat_test_plan.md           # Sub-agent 6.1
│   ├── progression_test_plan.md      # Sub-agent 6.2
│   ├── world_navigation_test_plan.md # Sub-agent 6.3
│   ├── regression_test_suite.md      # Sub-agent 6.4
│   └── qa_review_phase_6.md          # Sub-agent 6.5 (QA gate)
└── phase_7/
    ├── export_config.md              # Sub-agent 7.1
    ├── launch_checklist.md           # Sub-agent 7.2
    ├── store_page_copy.md            # Sub-agent 7.3
    ├── release_notes_v1.0.0.md       # Sub-agent 7.4
    └── qa_review_final_signoff.md    # Sub-agent 7.5 (final gate)
```

Phase 3 code outputs go directly into `godot_base/`:

```
godot_base/
├── scripts/autoloads/
│   ├── BattleManager.gd              # Sub-agent 3.1
│   ├── SkillSystem.gd                # Sub-agent 3.2
│   ├── MagicSystem.gd                # Sub-agent 3.3
│   ├── PartyManager.gd               # Sub-agent 3.4
│   ├── ProgressionManager.gd         # Sub-agent 3.5
│   ├── InventoryManager.gd           # Sub-agent 3.6
│   ├── SaveLoadManager.gd            # Sub-agent 3.7
│   ├── DialogueSystem.gd             # Sub-agent 3.8
│   └── QuestManager.gd               # Sub-agent 3.9
└── scenes/
    ├── battle_scene.tscn             # Sub-agent 3.10
    ├── world_map.tscn                # Sub-agent 3.11
    └── hud.tscn                      # Sub-agent 3.12
```

---

## Quick Reference

| Sub-Agent ID | Role File | Output File |
|---|---|---|
| 1.1 | `roles/game_director.json` | `docs/phase_1/high_concept_document.md` |
| 1.7 | `roles/qa_agent.json` | `docs/phase_1/qa_review_phase_1.md` |
| 3.1 | `roles/core_developer.json` | `godot_base/scripts/autoloads/BattleManager.gd` |
| 7.5 | `roles/qa_agent.json` | `docs/phase_7/qa_review_final_signoff.md` |

> For the full table of all 49 sub-agents, see [`workflow/sub_agent_index.md`](./sub_agent_index.md).

---

*ChatDevV2 v3.0 — PixelForge Studios*
