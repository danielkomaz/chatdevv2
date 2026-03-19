# Agent Runner Guide — ChatDevV2 Workflow v3.0

## Overview: Why Multi-Agent?

ChatDevV2 v2.0 assigned a single AI agent to an entire phase. A phase like Development required that one agent write all 13 scripts, all scene files, and all JSON data in a single session. This caused agents to hit session timeout limits (typically 59+ minutes) before completing their work, resulting in incomplete or truncated output.

**v3.0 solves this by breaking every phase into focused sub-agents.** Each sub-agent:

- Has **exactly one output file** (or one tightly-scoped folder of files)
- Should complete in **under 10 minutes**
- Reads only the files it needs from the repository
- Hands off cleanly by committing its output to the repository

This makes the workflow resumable, auditable, and compatible with any LLM platform.

---

## Core Concepts

| Term | Definition |
|------|-----------|
| **Sub-agent** | A single focused AI session with one scoped task and one output file |
| **Role persona** | The system prompt defining how the AI should think and behave (stored in `roles/*.json`) |
| **Output file** | The single file the sub-agent must produce and commit to the repository |
| **depends_on** | A list of sub-agent IDs that must be committed before this sub-agent can run |

---

## How to Run a Single Sub-Agent

### Step 1: Identify the sub-agent to run

Open `workflow/jrpg_studio_workflow.json` or `workflow/sub_agent_index.md` and find the sub-agent you want to run. Note its:
- `sub_agent_id` (e.g. `p1_a2`)
- `agent_name` (e.g. `World Lore Architect`)
- `assumes_role` (e.g. `story_writer`)
- `role_persona_file` (e.g. `roles/story_writer.json`)
- `system_prompt_override` (optional extra instructions)
- `inputs` (list of files to read from the repo)
- `output_file` (the file you will commit after the session)
- `scope` (the one-sentence task description)

### Step 2: Check dependencies

Look at the `depends_on` array. All listed sub-agent IDs must have their `output_file` committed to the repository before you proceed. Do not skip steps.

### Step 3: Read the role persona

Open the `role_persona_file` listed for this sub-agent (e.g. `roles/story_writer.json`). Copy the value of the `system_prompt` field. This is your AI system prompt.

### Step 4: Prepare your AI session

Start a new session in your LLM platform of choice. Set the system prompt to:
[Paste the system_prompt from the role JSON here]

ADDITIONAL INSTRUCTIONS FOR THIS TASK: [Paste the system_prompt_override from the sub-agent entry, if any]


### Step 5: Write your user message

Your user message should follow this template:

You are now acting as [agent_name].

Your task is to produce the file: [output_file]

SCOPE: [scope]

INPUTS — read and use the following content:

--- [input file 1 name] --- [paste the full content of input file 1 from the repository here]

--- [input file 2 name] --- [paste the full content of input file 2 from the repository here]

[continue for all inputs]

Now produce the complete content for [output_file]. Do not stop until the file is complete.

Code

### Step 6: Run the session

Submit the message and let the agent complete its output. If the session is cut off, see **Resuming After Interruption** below.

### Step 7: Commit the output

Copy the agent's output and create (or update) the `output_file` in the repository. Commit with a message like:

[sub_agent_id]: Complete [agent_name] output

Code

For example:
p1_a2: Complete World Lore Architect output

Code

### Step 8: Proceed to the next sub-agent

Once the file is committed, check the workflow for which sub-agent has `depends_on: ["this_id"]` and run it next.

---

## Running via GitHub Copilot

GitHub Copilot can run sub-agents directly in chat:

1. Reference the workflow file: `@danielkomaz/chatdevv2` then describe the sub-agent task
2. Ask: *"Please run sub-agent p1_a2 (World Lore Architect) from the jrpg_studio_workflow.json. Read docs/phase1/high_concept.md from the repo and produce docs/phase1/world_lore.md."*
3. Copilot will adopt the story_writer persona and generate the output
4. Ask Copilot to commit the file directly to the repository

**Tip:** Always provide the sub-agent ID (e.g. `p1_a2`) when asking Copilot so it knows exactly what scope to work within.

---

## Running via ChatGPT or Claude

1. **Start a fresh conversation** — never continue an old conversation for a new sub-agent
2. Set the **system prompt** (Custom Instructions in ChatGPT, or a [S] message in Claude) to the role persona + override
3. Paste your user message using the template from Step 5 above
4. If the output is long, the model may truncate it — use the prompt: *"Continue from where you left off. Do not repeat content already written."*
5. Assemble the full output and commit it

**Recommended context management:** Paste input files inline in the user message rather than as attachments. This gives the model the most reliable access to the content.

---

## Managing Dependencies

The `depends_on` field tells you the execution order. **Never run a sub-agent before its dependencies are committed.**

To check if a dependency is satisfied:
1. Look up the `output_file` of the dependency sub-agent in the workflow JSON
2. Check if that file exists and is non-empty in the repository
3. If yes: proceed. If no: run the dependency sub-agent first.

### Example dependency chain for Phase 1:

p1_a1 (no deps) → p1_a2 → p1_a3 → p1_a4 → p1_a5 → p1_a6 → p1_a7 ↓ p1_a4 depends on BOTH p1_a2 AND p1_a3

Code

The complete dependency graph is shown in `workflow/sub_agent_index.md`.

---

## Timeout Prevention Tips

- **Respect the estimated_minutes field.** If a sub-agent is estimated at 8 minutes, its scope should be completable in one focused session. If you find yourself needing more than 15 minutes, the scope is too broad — escalate to the workflow maintainer.
- **One output file at a time.** Sub-agents that list a directory (e.g. `godot/scripts/data/`) as their output should produce each file in sequence within the same session, not try to write all files simultaneously.
- **Never combine two sub-agents** into one session. The scoping is intentional.
- **If a session is approaching context limits**, use the "Continue" prompt before the cutoff, not after.

---

## Timeout Prevention: The "One Page at a Time" Rule

For sub-agents producing large documents (like the skill system with 144 skills), use this prompt pattern:

Produce the first 24 skills (Warrior class, all 3 branches). When complete, say "READY FOR NEXT BATCH" and wait.

Code

Then in follow-up messages:
Continue with the next 24 skills (Mage class, all 3 branches).

Code

Assemble the batches into the final output file yourself before committing.

---

## Phase Completion Criteria

A phase is considered **complete** when:
1. All sub-agents in that phase have their `output_file` committed to the repository
2. The final sub-agent of the phase (always a `qa_agent` reviewer) has returned a document with **no CRITICAL or HIGH severity issues** unresolved
3. If the QA reviewer flags issues, those must be fixed (by re-running the affected sub-agent with corrected inputs) before proceeding to the next phase

---

## Resuming After Interruption

If a session is cut off before producing the complete output:

1. Note the last complete section that was produced
2. Start a new session with the **same system prompt and context**
3. Include the partial output in your user message:
You were producing [output_file] and were cut off after completing [last section]. Here is what was produced so far:

[paste partial output]

Continue from where you left off. Begin at [next section]. Do not repeat anything already written.

Code
4. Assemble the partial and continued outputs into the final file
5. Commit as normal

---

## Workflow File Reference

| File | Purpose |
|------|---------|
| `workflow/jrpg_studio_workflow.json` | Full workflow definition with all sub-agents |
| `workflow/sub_agent_index.md` | Quick-reference table of all 49 sub-agents |
| `workflow/agent_runner_guide.md` | This file — how to use the workflow |
| `roles/*.json` | Role persona system prompts |
| `docs/phase*/` | Generated output documents per phase |
| `godot/` | Generated Godot 4 project files |

---

## Summary: Sub-Agent Count by Phase

| Phase | Name | Sub-Agents |
|-------|------|-----------|
| 1 | Concept & Story | 7 |
| 2 | Game Design Document | 8 |
| 3 | Development | 13 |
| 4 | Art Production | 6 |
| 5 | Sound Design | 5 |
| 6 | Testing & QA | 5 |
| 7 | Launch & Release | 5 |
| **Total** | | **49** |
