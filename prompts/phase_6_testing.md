# Phase 6: Testing & QA

## Overview

This phase defines the complete quality assurance process for the game. The **Game Tester** and **QA Agent** execute all test cases, log bugs using the standard template, and verify that all QA gate criteria are met before Phase 7 (Launch) begins. No asset from earlier phases is exempt from testing.

---

## Objective

Ensure the game is:
- Functionally correct across all systems
- Free of Critical and High severity bugs
- Performing at or above the defined benchmarks
- Regress-safe (old fixes do not break with new changes)

---

## 1. Master Test Plan Structure

### Test Domains

| Domain | Test Case Range | Minimum Count |
|---|---|---|
| Battle System | TC-BAT-001 to TC-BAT-015 | 15 |
| Skills & Magic | TC-SKL-001 to TC-SKL-010 | 10 |
| Party Management | TC-PTY-001 to TC-PTY-008 | 8 |
| Save / Load | TC-SAV-001 to TC-SAV-005 | 5 |
| UI / UX | TC-UIX-001 to TC-UIX-007 | 7 |
| World / Movement | TC-WLD-001 to TC-WLD-005 | 5 |
| **Total** | | **50 minimum** |

### Test Case Status Values

- **PASS** — Behavior matches Expected Result exactly
- **FAIL** — Behavior does not match Expected Result; file a bug report
- **BLOCKED** — Test cannot be executed due to a prerequisite failure
- **SKIP** — Test intentionally deferred (must include justification)

---

## 2. Test Cases

### 2.1 Battle System

| Test ID | System | Test Name | Steps | Expected Result | Status |
|---|---|---|---|---|---|
| TC-BAT-001 | Battle | ATB Turn Order — Speed | 1. Start battle with party member SPD=10 and enemy SPD=20. 2. Observe first turn. | Enemy acts first because SPD is higher. ATB fills at correct relative rates. | |
| TC-BAT-002 | Battle | ATB Turn Order — Tie Break | 1. Set party member and enemy to identical SPD=15. 2. Both reach 100 ATB simultaneously. | Party member acts before enemy. | |
| TC-BAT-003 | Battle | Physical Damage Formula | 1. Set attacker ATK=50, target DEF=20, weapon_modifier=1.0. 2. Attack. 3. Record damage. | Damage between 72 and 88 (formula: (50*2-20)*1.0 × random 0.9–1.1 = 72–88). | |
| TC-BAT-004 | Battle | Minimum Damage Floor | 1. Set attacker ATK=5, target DEF=200 (far exceeds attack). 2. Attack. | Damage is exactly 1 (minimum damage floor). | |
| TC-BAT-005 | Battle | Critical Hit | 1. Set character crit_chance to 1.0 (guaranteed). 2. Attack. 3. Record damage. | Damage is exactly 1.5× the non-critical damage calculated by formula. | |
| TC-BAT-006 | Battle | Defend Action — Physical Reduction | 1. Party member selects Defend. 2. Enemy uses physical attack on that member. | Damage received is reduced by exactly 50% compared to non-defended hit. | |
| TC-BAT-007 | Battle | Defend Action — Magic Reduction | 1. Party member selects Defend. 2. Enemy uses magic attack. | Damage received is reduced by exactly 25%. | |
| TC-BAT-008 | Battle | Flee — Success | 1. Set avg party AGI far above avg enemy AGI (flee_chance → 0.95). 2. Select Flee. | Battle ends. No XP or gold awarded. Party returns to world map. | |
| TC-BAT-009 | Battle | Flee — Failure | 1. Set flee_chance to 0 (guaranteed fail). 2. Select Flee. | Flee fails. Fleeing character loses turn. All enemies gain +10% ATB. Battle continues. | |
| TC-BAT-010 | Battle | Boss — Flee Impossible | 1. Enter boss battle. 2. Select Flee. | Flee always fails (flee_chance = 0 regardless of stats). Message displayed to player. | |
| TC-BAT-011 | Battle | Poison Status — Tick Damage | 1. Apply Poison to party member with 200 max HP. 2. Advance 1 turn. | Party member loses exactly 10 HP (5% of 200) at turn start. | |
| TC-BAT-012 | Battle | Poison Status — Duration | 1. Apply Poison (duration 5). 2. Advance character turns. | Poison ticks 5 times then expires. No further tick damage on turn 6. | |
| TC-BAT-013 | Battle | Haste + Slow Opposing Cancellation | 1. Apply Haste to a character. 2. Apply Slow to same character. | Haste is removed. Slow is applied. Character ATB fills at 0.5× rate. | |
| TC-BAT-014 | Battle | Stun — ATB Freeze | 1. Apply Stun to party member. 2. Observe ATB gauge. | ATB gauge does not increase while Stun is active. | |
| TC-BAT-015 | Battle | Victory — XP Award | 1. Defeat all enemies in a battle. 2. Check party XP. | Each active party member receives full XP. Reserve members receive 50% of full XP. | |

---

### 2.2 Skills & Magic

| Test ID | System | Test Name | Steps | Expected Result | Status |
|---|---|---|---|---|---|
| TC-SKL-001 | Skills | Skill MP Cost Deducted | 1. Character has 50 MP. 2. Use Power Strike (cost 8 MP). | Character MP reduces to exactly 42 after use. | |
| TC-SKL-002 | Skills | Skill Cooldown Tracks Correctly | 1. Use a skill with cooldown 3. 2. Attempt to use same skill on next 3 turns. | Skill is greyed out and unselectable for turns 1, 2, 3 after use. Available on turn 4. | |
| TC-SKL-003 | Skills | Insufficient MP Blocks Skill | 1. Set character MP to 0. 2. Attempt to select a skill costing 8 MP. | Skill is unselectable. Error or greyed-out indicator shown. | |
| TC-SKL-004 | Skills | War Cry — Stat Buff Applied | 1. Use War Cry. 2. Check all party member ATK stats. | All active party members have ATK increased by 15% for 4 turns. | |
| TC-SKL-005 | Skills | Passive Skill — Iron Resolve Triggers | 1. Set character HP to 24% of max. 2. Check ATK and DEF values. | ATK increased by 30%, DEF increased by 20% (passive triggered). | |
| TC-SKL-006 | Magic | Elemental Weakness — Fire vs. Ice | 1. Cast Fireball on an Ice-elemental enemy (Ice absorbs Fire as weakness 2.0×). 2. Record damage. | Damage is 2.0× the base magic damage formula. | |
| TC-SKL-007 | Magic | Elemental Resistance — Fire vs. Fire | 1. Cast Fireball on a Fire-resistant enemy (0.5×). 2. Record damage. | Damage is 0.5× the base formula. | |
| TC-SKL-008 | Magic | Holy vs. Undead Double Damage | 1. Cast Holy Smite on an undead enemy. | Damage is exactly 2× the calculated Holy damage. | |
| TC-SKL-009 | Magic | Shadow Drain — Lifesteal | 1. Cast Shadow Drain dealing 100 damage. 2. Check caster HP. | Caster HP increases by exactly 50 (50% of 100 damage dealt). | |
| TC-SKL-010 | Magic | Stop — Boss Immunity | 1. Enter boss battle. 2. Cast Stop on boss. | Stop fails (0% success rate vs. boss). Appropriate "immune" message shown. | |

---

### 2.3 Party Management

| Test ID | System | Test Name | Steps | Expected Result | Status |
|---|---|---|---|---|---|
| TC-PTY-001 | Party | Formation — Aggressive Stat Modifiers | 1. Note party ATK values. 2. Switch to Aggressive formation. 3. Check ATK again. | All active members: ATK +20%, DEF -15%, SPD +10%, MAG +10%. | |
| TC-PTY-002 | Party | Formation — Defensive Stat Modifiers | 1. Switch to Defensive formation. 2. Check stats. | All active members: DEF +25%, ATK -10%, SPD -10%, MAG -5%. | |
| TC-PTY-003 | Party | Morale — Gain on Kill | 1. Note current morale value. 2. Defeat an enemy. | Morale increases by exactly 2. | |
| TC-PTY-004 | Party | Morale — Loss on KO | 1. Note current morale. 2. Allow party member to be KO'd. | Morale decreases by exactly 8. | |
| TC-PTY-005 | Party | Morale — Clamp at 0 | 1. Set morale to 5. 2. Apply event that subtracts 8 morale. | Morale is clamped to 0, not set to -3. | |
| TC-PTY-006 | Party | Morale — Inspired Stat Bonus | 1. Set morale to 85. 2. Check party stats in battle. | All active party members: all stats +10%, crit rate +5%. | |
| TC-PTY-007 | Party | Reserve Member XP | 1. Battle with 4 active members, 1 reserve. 2. Defeat enemies. 3. Check reserve XP gain. | Reserve member gained exactly 50% of XP earned by active members. | |
| TC-PTY-008 | Party | Character Swap at Save Point | 1. Approach save crystal. 2. Access party menu. 3. Swap active slot 1 with a reserve character. | Active party updates. Previously active member moves to reserve. Formation bonuses recalculate. | |

---

### 2.4 Save / Load

| Test ID | System | Test Name | Steps | Expected Result | Status |
|---|---|---|---|---|---|
| TC-SAV-001 | Save/Load | Save and Load — Party State | 1. Set party to specific formation with specific members. 2. Save to slot 1. 3. Load slot 1. | Party composition, formation, and stats identical to pre-save state. | |
| TC-SAV-002 | Save/Load | Save and Load — Quest State | 1. Start quest Q001, complete objective O1. 2. Save. 3. Load. | Quest Q001 is active with objective O1 completed. Quest progress not reset. | |
| TC-SAV-003 | Save/Load | Save and Load — Inventory | 1. Place 3 specific items in inventory. 2. Save. 3. Load. | Inventory contains exactly those 3 items in same quantities. | |
| TC-SAV-004 | Save/Load | Multiple Slot Independence | 1. Save different game states to slots 1, 2, and 3. 2. Load each slot. | Each slot loads its own independent state. No cross-slot data contamination. | |
| TC-SAV-005 | Save/Load | Corrupted Save — Graceful Handling | 1. Manually corrupt a save file (delete a required JSON key). 2. Attempt to load that slot. | Game shows an error message. Game does not crash. Other save slots remain accessible. | |

---

### 2.5 UI / UX

| Test ID | System | Test Name | Steps | Expected Result | Status |
|---|---|---|---|---|---|
| TC-UIX-001 | UI | HP Bar Updates in Real Time | 1. Observe HP bar during battle. 2. Take damage. | HP bar value decreases smoothly, matching exact HP loss. Color changes to red below 25% HP. | |
| TC-UIX-002 | UI | Dialogue Typewriter Effect | 1. Trigger any dialogue line. 2. Watch text reveal. | Text reveals at ~40 characters per second. All characters are readable. | |
| TC-UIX-003 | UI | Dialogue Skip to End | 1. Trigger dialogue. 2. Press confirm during typewriter. | All text for current line immediately revealed. Next confirm advances to next line. | |
| TC-UIX-004 | UI | Dialogue Choices — Correct Branch | 1. Trigger branching dialogue. 2. Select choice 2. | Dialogue advances to the branch associated with choice 2 (not choice 1 or choice 3). | |
| TC-UIX-005 | UI | Action Menu — Greyed Disabled Skills | 1. Enter battle with a character whose skill is on cooldown. 2. Open skill menu. | Skill on cooldown is visually greyed out and cannot be selected. Cooldown turns remaining shown. | |
| TC-UIX-006 | UI | Main Menu — Continue Disabled Without Save | 1. Delete all save files. 2. Open main menu. | "Continue" button is disabled (greyed out, not clickable). | |
| TC-UIX-007 | UI | Inventory — Stat Comparison | 1. Open inventory. 2. Select a weapon. 3. View stat comparison vs. equipped item. | Stat comparison shows +/- difference for ATK, DEF, MAG vs. currently equipped item in that slot. | |

---

### 2.6 World / Movement

| Test ID | System | Test Name | Steps | Expected Result | Status |
|---|---|---|---|---|---|
| TC-WLD-001 | World | Player Movement — Collision | 1. Move player toward a wall tile or impassable object. | Player stops at the tile boundary. No clipping through walls. | |
| TC-WLD-002 | World | Scene Transition — Zone Trigger | 1. Walk into a zone transition trigger (e.g., town entrance). | Scene transitions to the correct target scene. Player spawns at the designated entry point in new scene. | |
| TC-WLD-003 | World | Random Encounter — Triggers After N Steps | 1. Walk continuously on a random-encounter-enabled tile type. 2. Count steps. | Battle triggers within the expected step range defined for that region. | |
| TC-WLD-004 | World | No Encounters in Towns | 1. Walk around inside a town. 2. Walk extensively. | No random battle encounters trigger inside town boundaries. | |
| TC-WLD-005 | World | NPC Dialogue Trigger | 1. Walk up to an NPC. 2. Press interact button. | Correct dialogue for that NPC begins. Dialogue does not trigger from other NPCs. | |

---

## 3. Bug Report Template

Every bug discovered must be logged using the following format before any fix is attempted. Bug IDs are assigned sequentially: BUG-0001, BUG-0002, etc.

```
Bug ID:         BUG-XXXX
Severity:       [Critical / High / Medium / Low]
System:         [Battle / Skills / Magic / Party / Save / UI / World / Audio / Other]
Test Case:      [TC-XXX-XXX or "Exploratory"]
Title:          [Short descriptive title — max 80 characters]
Description:    [Full description of the problem]

Steps to Reproduce:
  1. [Step 1]
  2. [Step 2]
  3. [Step 3]
  [Add as many steps as needed for consistent reproduction]

Expected Result:
  [What should happen according to the GDD or test case]

Actual Result:
  [What actually happens]

Reproduction Rate:  [Always / Intermittent X/10 / Once]
Build Version:      [Godot project version, e.g., 0.9.1]
Platform:           [Windows 64 / Linux 64 / macOS / Web]
Screenshot/Video:   [Attach file name or note "None"]
Assigned To:        [Developer name or "Unassigned"]
Status:             [Open / In Progress / Fixed / Verified / Won't Fix]
Fixed in Version:   [Version where fix was applied, or blank]
```

### Severity Definitions

| Severity | Definition | Examples |
|---|---|---|
| **Critical** | Game cannot be played. Data loss possible. Ship blocker. | Crash on startup, save data deleted on load, infinite loop locking game |
| **High** | Core system broken. Major feature unusable. Should block release. | Battle system damage formula wrong, skills not deducting MP, scenes not loading |
| **Medium** | Feature works but incorrectly or partially. Noticeable to most players. | Status icon not displaying, wrong music playing, stat bonus off by 10% |
| **Low** | Minor visual glitch, typo, cosmetic issue. Does not affect gameplay. | Animation 1 frame out of sync, UI text truncated, minor color mismatch |

---

## 4. QA Gate Criteria

**The following must be true before Phase 7 (Launch) begins:**

### Mandatory (No exceptions)
- [ ] All 50+ test cases executed (no BLOCKED or SKIP without documented justification)
- [ ] Zero (0) open Critical severity bugs
- [ ] Zero (0) open High severity bugs
- [ ] All Critical and High bugs fixed and marked Verified by QA
- [ ] Save/load round-trip passes TC-SAV-001 through TC-SAV-005 on all 3 platforms
- [ ] Battle system damage formula verified against GDD for all 6 action types
- [ ] All 11 status effects verified for correct duration and tick effect
- [ ] Flee behavior verified (success formula, boss immunity)
- [ ] ATB turn order verified (speed-based, tie-breaking rules)

### Advisory (Document open items; release decision at Game Director discretion)
- [ ] Medium severity bugs: total count documented; each assessed for release risk
- [ ] Low severity bugs: total count documented
- [ ] Performance benchmarks met (see Section 5)
- [ ] Regression suite passes on final build

---

## 5. Performance Benchmarks

### Target Specifications

| Metric | Target | Minimum Acceptable |
|---|---|---|
| Frame rate — World Map | 60 FPS | 55 FPS |
| Frame rate — Battle Scene (4v4) | 60 FPS | 55 FPS |
| Frame rate — Town (busy, many NPCs) | 60 FPS | 50 FPS |
| Scene load time — Battle | < 100ms | < 250ms |
| Scene load time — World Map | < 200ms | < 400ms |
| Save write time | < 500ms | < 1000ms |
| Load read time | < 500ms | < 1000ms |
| Memory usage — peak in battle | < 512 MB | < 768 MB |

### Measurement Method

1. Run Godot with profiler enabled (`--profiling` flag or in-editor profiler)
2. Measure FPS using Godot's built-in FPS counter in the top-right corner (debug build)
3. Scene load times measured from trigger event to scene-ready signal
4. Memory measured via Godot Monitor panel → Memory → Static/Dynamic

### Performance Test Scenarios

- **Worst-case battle:** 4 party members + 4 enemies + 3 active spell effects simultaneously + battle log active
- **Busy town:** 20+ NPC nodes active + particle effects + ambient audio
- **World map worst-case:** Long outdoor scene with full tilemap visible + minimap active

---

## 6. Regression Test Procedure

After any bug fix or code change is merged, the following minimum regression suite must be re-run before the build is considered stable:

### Regression Suite (Minimum — run after every fix)

| Test ID | Description |
|---|---|
| TC-BAT-001 | ATB turn order still correct |
| TC-BAT-003 | Damage formula still correct |
| TC-BAT-011 | Poison tick still correct |
| TC-SKL-001 | Skill MP cost still deducted |
| TC-PTY-001 | Formation modifiers still apply |
| TC-SAV-001 | Save/load party state still works |
| TC-SAV-005 | Corrupted save handled gracefully |
| TC-UIX-001 | HP bar updates correctly |
| TC-WLD-001 | Player collision still works |
| TC-WLD-002 | Scene transitions still work |

### Full Regression Suite (Run before each release candidate build)

All 50+ test cases in Section 2 plus any additional tests written for bugs that have been fixed (a test must be added for every Critical or High bug to prevent regression).

---

## 7. Completion Checklist

- [ ] All test cases in Section 2 executed (50 minimum)
- [ ] All test results recorded with Pass/Fail/Blocked/Skip status
- [ ] All FAIL results have corresponding bug reports filed using the template
- [ ] Bug report IDs documented and tracked
- [ ] All Critical bugs fixed, verified, and closed
- [ ] All High bugs fixed, verified, and closed
- [ ] Medium bugs assessed and documented (release risk noted per bug)
- [ ] Low bugs documented
- [ ] Performance benchmarks measured on all 3 target platforms (Windows, Linux, macOS)
- [ ] Frame rate targets met in all 3 performance test scenarios
- [ ] Scene load time targets met
- [ ] Save/load performance targets met
- [ ] Regression suite passed on final QA build
- [ ] A regression test added for every Critical and High bug fixed
- [ ] Game Director and QA Agent reviewed open Medium bugs and approved release decision
- [ ] QA gate criteria all checked and signed off
- [ ] QA Agent formal sign-off recorded (name + date)

**Gate Signed Off By:** _________________________ **Date:** _____________

---

*Proceed to Phase 7: Launch & Release only after all gate items are checked.*
