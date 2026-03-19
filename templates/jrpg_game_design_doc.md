# JRPG Game Design Document Template

> **Instructions:** Replace all placeholder values in `[brackets]` with your project-specific content. Tables and formulas may be modified to suit your design.

---

## Executive Summary

| Field | Value |
|---|---|
| Project Title | [Game Title] |
| Studio / Developer | [Studio Name] |
| Document Version | 1.0 |
| Last Updated | [YYYY-MM-DD] |
| Lead Designer | [Name] |
| Status | [Draft / In Review / Approved] |

**Elevator Pitch:**
> [One to three sentences describing the game's core experience, unique selling points, and emotional promise to the player.]

**Key Features (bullet list):**
- [Feature 1: e.g., Turn-based combat with real-time reaction windows]
- [Feature 2: e.g., Five playable races with unique ability trees]
- [Feature 3: e.g., Branching narrative with multiple endings]
- [Feature 4: e.g., Procedurally generated dungeon floors]
- [Feature 5: e.g., Crafting and equipment enhancement system]

---

## Game Overview

| Field | Detail |
|---|---|
| Title | [Working Title] |
| Genre | JRPG / Turn-Based RPG |
| Platform(s) | [PC (Windows/Linux/macOS), Nintendo Switch, PlayStation 5, Xbox Series X] |
| Engine | Godot 4.x |
| Target Audience | Ages 13–35; fans of Final Fantasy, Persona, Octopath Traveler |
| Player Count | Single-player |
| Estimated Playtime | Main Story: ~40 hours; 100% Completion: ~80 hours |
| ESRB Rating Target | T (Teen) — Fantasy Violence, Mild Language |
| Release Target | [Quarter, Year] |

### High-Level Concept
[2–3 paragraphs describing the game world, the central conflict, and what makes this title distinct from existing JRPGs.]

### Inspiration & References
| Reference Title | What We Borrow |
|---|---|
| Final Fantasy VI | Ensemble cast, emotional storytelling |
| Persona 5 | UI/UX polish, social systems |
| Octopath Traveler | HD-2D art direction |
| Fire Emblem | Strategic party composition |
| Chrono Trigger | Multi-target combo attacks |

---

## Core Pillars

> Core pillars are the 3–5 non-negotiable design values that every decision is measured against.

### Pillar 1: [Name — e.g., Tactical Depth]
**Statement:** [One sentence describing this pillar.]
**What it means in practice:**
- [Example decision guided by this pillar]
- [Example decision guided by this pillar]
**What it rules out:**
- [Design directions this pillar eliminates]

### Pillar 2: [Name — e.g., Emotional Investment]
**Statement:** [One sentence.]
**What it means in practice:**
- [Example]
- [Example]
**What it rules out:**
- [Example]

### Pillar 3: [Name — e.g., World Cohesion]
**Statement:** [One sentence.]
**What it means in practice:**
- [Example]
**What it rules out:**
- [Example]

### Pillar 4: [Name — e.g., Rewarding Progression]
**Statement:** [One sentence.]
**What it means in practice:**
- [Example]
**What it rules out:**
- [Example]

### Pillar 5 (Optional): [Name — e.g., Accessibility Without Compromise]
**Statement:** [One sentence.]
**What it means in practice:**
- [Example]

---

## Target Audience

### Primary Audience
- **Age range:** 16–30
- **Gaming experience:** Intermediate to experienced RPG players
- **Motivations:** Story immersion, character building, strategic combat, collecting/completing
- **Platforms:** PC, consoles

### Secondary Audience
- **Age range:** 13–15 and 31–40
- **Gaming experience:** Casual to intermediate
- **Motivations:** Story, visuals, nostalgia for classic JRPGs

### Player Personas

| Persona | Description | Key Needs |
|---|---|---|
| The Completionist | Wants to find everything, max all characters | Clear progression map, plenty of side content |
| The Story Seeker | Plays for narrative and character | Rich dialogue, meaningful choices, emotional moments |
| The Tactician | Optimizes every fight | Deep combat mechanics, meaningful builds, hard-mode options |
| The Casual Explorer | Plays at own pace | Easy mode, skippable cutscenes, clear quest guidance |

---

## Battle System

### Turn Order Algorithm
Turns are determined by each combatant's **SPD** stat with random variance.

```
Turn Score = SPD + Random(0, SPD * 0.1)
```

- Combatants act in descending Turn Score order.
- Ties broken by: Player characters > Enemies.
- Speed buffs/debuffs re-calculate Turn Score immediately.
- Status effect **Haste** multiplies SPD by 1.5 for Turn Score purposes.
- Status effect **Slow** multiplies SPD by 0.5 for Turn Score purposes.

### Action Types

| Action Type | Description | MP Cost |
|---|---|---|
| Attack | Basic physical attack using equipped weapon | 0 |
| Skill | Learned active skill from skill tree | Varies |
| Magic | Spell from equipped spell school | Varies |
| Item | Use a consumable item from inventory | 0 |
| Defend | Reduce incoming damage by 50% until next turn | 0 |
| Flee | Attempt to escape battle (50% base success + SPD modifier) | 0 |
| Limit Break | Special high-power move when Limit Gauge is full | 0 (uses Limit Gauge) |

### Damage Formulas

#### Physical Damage
```
Physical Damage = (ATK_STR * skill_power) - (TARGET_DEF * 0.5)
Minimum Damage  = 1
Critical Hit    = Physical Damage * 1.5  (triggered by LCK roll)
```

| Variable | Description |
|---|---|
| `ATK_STR` | Attacker's STR stat |
| `skill_power` | Multiplier defined per skill (e.g., 1.0 = 100% STR) |
| `TARGET_DEF` | Defender's DEF stat |

#### Magical Damage
```
Magical Damage = (ATK_MAG * spell_power) - (TARGET_RES * 0.3)
Minimum Damage = 1
Critical Hit   = Magical Damage * 1.5
```

| Variable | Description |
|---|---|
| `ATK_MAG` | Attacker's MAG stat |
| `spell_power` | Multiplier defined per spell (e.g., 1.2 = 120% MAG) |
| `TARGET_RES` | Defender's RES stat |

#### Elemental Modifier
```
Final Damage = Base Damage * Elemental Modifier
```

| Modifier Value | Meaning |
|---|---|
| 2.0 | Weakness |
| 1.0 | Neutral |
| 0.5 | Resistance |
| 0.0 | Immunity |
| -0.5 | Absorption (heals target) |

#### Critical Hit Rate
```
Crit Chance (%) = (ATK_LCK / TARGET_LCK) * 5 + base_crit_bonus
```
Base crit bonus defaults to 2%. Hard cap: 50%.

### Status Effect Table

| Status Effect | Category | Description | Duration | Cure Item |
|---|---|---|---|---|
| Poison | Damage-over-time | Lose 5% max HP per turn | Until cured / battle end | Antidote |
| Bleed | Damage-over-time | Lose 3% max HP per turn; stacks up to 3× | Until cured | Bandage |
| Burn | Damage-over-time | Lose 8% max HP per turn; lowers DEF 10% | 3 turns | Ice Shard |
| Freeze | Crowd Control | Cannot act; physical hit thaws and deals bonus damage | 2 turns | Warm Potion |
| Stun | Crowd Control | Skip next turn | 1 turn | Smelling Salts |
| Sleep | Crowd Control | Cannot act; any damage wakes target | 3 turns | Bell |
| Confuse | Crowd Control | Attacks random target (ally or enemy) | 3 turns | Clarity Herb |
| Silence | Debuff | Cannot use MP skills or magic | 3 turns | Echo Herb |
| Blind | Debuff | Physical attack accuracy reduced by 50% | 3 turns | Eye Drop |
| Slow | Debuff | SPD halved for turn-order purposes | 3 turns | Haste Tonic |
| Haste | Buff | SPD ×1.5 for turn-order purposes | 3 turns | — |
| Regen | Buff | Restore 5% max HP per turn | 5 turns | — |
| Protect | Buff | DEF increased by 30% | 3 turns | — |
| Shell | Buff | RES increased by 30% | 3 turns | — |
| Doom | Special | KO when counter reaches 0 | Countdown from 5 | Esuna |

### Limit Break System
- Limit Gauge fills when taking damage (10% per hit received, +5% per ally KO).
- At 100%, player may spend gauge to use their character's **Limit Break** skill.
- Limit Break skills are unique per character and not part of the skill tree.

---

## Skill System

### Skill Categories

| Category | Description | Targeting |
|---|---|---|
| Active — Damage | Deal damage to one or more targets | Single / AoE / Splash |
| Active — Status | Apply status effects | Single / AoE |
| Active — Heal | Restore HP/MP | Single / AoE |
| Active — Support | Buff allies or debuff enemies | Single / AoE |
| Passive — Stat | Permanently increase one or more stats | Self |
| Passive — Conditional | Trigger effect under specific conditions | Self |
| Passive — Aura | Passive bonus applies to all party members | Party |
| Reaction | Trigger in response to an event (e.g., taking damage) | Self / Single |

### Skill Tree Structure
Each class has **3 branches**, each with **10 skills**.
- Branches are unlocked by spending **Skill Points (SP)** earned on level-up.
- Each character earns **2 SP per level**.
- Skills within a branch must be unlocked in order (skill N requires skill N-1).
- Cross-branch synergy skills unlock when prerequisites in two different branches are met.

```
[Branch A: Offense]     [Branch B: Defense]     [Branch C: Utility]
    Skill A1                 Skill B1                 Skill C1
       │                        │                        │
    Skill A2                 Skill B2                 Skill C2
       │                        │                        │
    ...                      ...                      ...
       │                        │                        │
    Skill A10                Skill B10                Skill C10
```

### Skill Unlock Conditions
| Condition Type | Example |
|---|---|
| Level Requirement | Must be Level 15 to learn |
| SP Investment | Must have spent 5+ SP in this branch |
| Previous Skill | Must have learned the preceding skill |
| Story Flag | Unlocks after completing Chapter 4 |
| Item-based | Requires a Skill Tome to unlock |

---

## Magic System

### Spell Schools

| School | Element | Stat Used | Description |
|---|---|---|---|
| Pyromancy | Fire | MAG | Offensive fire spells; excels against Ice/Plant enemies |
| Cryomancy | Ice | MAG | Offensive ice spells; can freeze targets |
| Tempestcraft | Thunder | MAG | Offensive lightning; high crit rate |
| Geomancy | Earth | MAG | Offensive earth; high DEF-piercing |
| Aethermancy | Light | MAG | Offensive/healing hybrid |
| Umbramancy | Dark | MAG | Offensive/debuff hybrid |
| Restoration | Healing | MAG | Pure healing and revival |
| Chronomancy | Time | MAG | Haste, Slow, Stop; utility school |

### MP Cost Guidelines

| Spell Tier | Damage Range (% MAG) | MP Cost Range |
|---|---|---|
| Tier 1 (Basic) | 80–120% | 8–14 MP |
| Tier 2 (Advanced) | 150–200% | 20–30 MP |
| Tier 3 (Elite) | 250–350% | 40–55 MP |
| Tier 4 (Ultimate) | 400–600% | 60–80 MP |
| AoE penalty | −20% damage per target hit simultaneously | +50% MP cost |

### Elemental Affinity Chart

|  | Fire | Ice | Thunder | Earth | Light | Dark | Non-Elemental |
|---|---|---|---|---|---|---|---|
| Fire enemy | ×0.5 | ×2.0 | ×1.0 | ×1.0 | ×1.0 | ×1.0 | ×1.0 |
| Ice enemy | ×2.0 | ×0.5 | ×1.0 | ×1.0 | ×1.0 | ×1.0 | ×1.0 |
| Thunder enemy | ×1.0 | ×1.0 | ×0.5 | ×2.0 | ×1.0 | ×1.0 | ×1.0 |
| Earth enemy | ×1.0 | ×1.0 | ×2.0 | ×0.5 | ×1.0 | ×1.0 | ×1.0 |
| Light enemy | ×1.0 | ×1.0 | ×1.0 | ×1.0 | ×0.0 | ×2.0 | ×1.0 |
| Dark enemy | ×1.0 | ×1.0 | ×1.0 | ×1.0 | ×2.0 | ×0.0 | ×1.0 |
| Undead enemy | ×1.0 | ×1.0 | ×1.0 | ×1.0 | ×2.0 | ×0.5 | ×1.0 |

---

## Race System

### Race Comparison Table

| Race | HP Mod | MP Mod | STR Mod | DEF Mod | MAG Mod | RES Mod | SPD Mod | LCK Mod | Playstyle |
|---|---|---|---|---|---|---|---|---|---|
| Human | +5% all | +5% all | +5% all | +5% all | +5% all | +5% all | +5% all | +5% all | Balanced / All-rounder |
| Elf | 0 | +10 | −10 | −10 | +20 | +10 | +15 | +5 | Magical glass cannon |
| Dwarf | +20 | 0 | +20 | +15 | −10 | +5 | −15 | 0 | Physical tank |
| Draconian | +10 | +5 | +15 | +5 | +15 | +5 | −5 | 0 | Hybrid fighter |
| Sprite | −20 | +20 | −15 | −20 | +30 | +10 | +25 | +10 | Extreme mage |

### Racial Abilities
Each race has one **passive** racial ability and one **active** racial skill (see Race Design Template for full details).

| Race | Passive Ability | Active Racial Skill | Active MP Cost |
|---|---|---|---|
| Human | Quick Learner (+10% XP) | Rally (party STR+MAG 10%, 3 turns) | 15 |
| Elf | Arcane Affinity (MP−10%, spell dmg +5% per Elf) | Nature's Grasp (root+Earth DoT) | 20 |
| Dwarf | Stone Skin (−15% phys dmg, Stun immune) | War Cry (party STR+20%, DEF+10%) | 18 |
| Draconian | Dragon Scales (−5% all dmg; −15% at HP<25%) | Dragon Breath (150% MAG cone) | 25 |
| Sprite | Fey Step (20% evade; on evade recover 5% MP) | Phantasm (AoE Confuse + SPD−30%) | 30 |

---

## Party System

### Party Composition Rules
- **Active party size:** 4 characters
- **Reserve size:** Up to 4 additional characters (swappable in towns or via Tactical Retreat skill)
- **Role balance recommendation:** 1 Tank, 1 Healer, 1 DPS, 1 Flex (Support/DPS/Mage)

### Formation System

| Formation Name | Layout | Bonus |
|---|---|---|
| Standard | 2 front / 2 back | No bonus; default formation |
| Vanguard | 3 front / 1 back | Front row STR +10%; back row RES −20% |
| Fortress | 1 front / 3 back | Front row DEF +30%; back row SPD +10% |
| Delta | Rotating triangle | SPD +5% all; slight physical dmg bonus |
| Magic Circle | 4 back row | MAG +15% all; DEF −30% all |

### Row Rules
- **Front row:** Takes full physical damage; deals full physical damage.
- **Back row:** Takes 50% physical damage; deals 50% physical damage. Magic damage unaffected.
- Some weapons (bows, staves) have full effectiveness from back row.

### Synergy Bonuses
When specific character combinations are in the active party:
| Combo | Members Required | Bonus |
|---|---|---|
| Elemental Trio | 3 different element mages | All spell damage +10% |
| Shield Wall | 2 Warriors or Knights | Shared DEF shield (absorbs 5% damage for team) |
| Twin Blades | 2 Rogues/Rangers | Crit rate +15% for both |
| Ancient Bond | Elf + Sprite | Magic cooldowns −1 for both |

---

## Progression System

### Experience Points (XP) Curve

```
XP required for level N = Base_XP * (N ^ exponent)
Base_XP  = 100
exponent = 1.8
```

| Level | XP to Next Level | Cumulative XP |
|---|---|---|
| 1 | 100 | 0 |
| 5 | 680 | 2,400 |
| 10 | 2,512 | 12,600 |
| 20 | 9,131 | 74,500 |
| 30 | 19,800 | 245,000 |
| 50 | 57,000 | 1,200,000 |
| 99 | 270,000 | 8,500,000 |

### Stat Growth Per Level

Each class has a stat growth profile. Values below are **base points added per level**.

| Class | HP/Lv | MP/Lv | STR/Lv | DEF/Lv | MAG/Lv | RES/Lv | SPD/Lv | LCK/Lv |
|---|---|---|---|---|---|---|---|---|
| Warrior | 25 | 5 | 4 | 3 | 1 | 2 | 2 | 1 |
| Mage | 12 | 20 | 1 | 1 | 5 | 3 | 2 | 2 |
| Ranger | 18 | 10 | 3 | 2 | 2 | 2 | 4 | 3 |
| Healer | 15 | 18 | 1 | 2 | 4 | 4 | 2 | 2 |
| Knight | 30 | 5 | 3 | 5 | 1 | 3 | 1 | 1 |
| Bard | 14 | 15 | 2 | 2 | 3 | 3 | 3 | 4 |

### Equipment Tiers

| Tier | Name | Availability | Approximate Stat Bonus Range |
|---|---|---|---|
| 1 | Common | From start | +2–5 per stat |
| 2 | Uncommon | Chapter 2+ | +6–12 per stat |
| 3 | Rare | Chapter 4+ | +13–25 per stat |
| 4 | Epic | Chapter 7+ | +26–50 per stat |
| 5 | Legendary | Post-game / hidden | +51–100 per stat + unique effect |
| 6 | Artifact | Post-game boss drops | +80–150 per stat + powerful unique effect |

---

## Item/Equipment System

### Item Categories

| Category | Subcategory | Examples |
|---|---|---|
| Consumable | Recovery | Potion (HP), Ether (MP), Elixir (HP+MP), Phoenix Down (revive) |
| Consumable | Status Cure | Antidote, Antidote+, Bandage, Smelling Salts, Esuna Herb |
| Consumable | Battle Enhancer | Power Seed (+STR temp), Magic Incense (+MAG temp) |
| Consumable | Crafting | Monster parts, ore, herbs, crystals |
| Key Item | Story | Quest items, dungeon keys, covenant shards |
| Equipment | Weapon | Sword, Axe, Staff, Bow, Dagger, Spear, Tome |
| Equipment | Armor | Light, Medium, Heavy armor sets |
| Equipment | Helmet | Helmets, Hats, Circlets, Hoods |
| Equipment | Accessory | Rings, Amulets, Bracelets, Belts |

### Equipment Slots

| Slot | Characters Who Use | Notes |
|---|---|---|
| Weapon | All | Determines base ATK type (Physical/Magical/Ranged) |
| Off-hand | Warriors, Knights | Shield (adds DEF) or second weapon (dual-wield) |
| Armor | All | Heaviness affects SPD penalty |
| Helmet | All | May grant elemental resistance |
| Accessory 1 | All | Rings, amulets — passive bonuses |
| Accessory 2 | All (unlocked at Lv 20) | Second accessory slot |

### Enhancement System
Equipment can be upgraded at a Blacksmith NPC using materials.

| Enhancement Level | Material Cost | Stat Bonus Added |
|---|---|---|
| +1 | 2× Ore | +10% base stats |
| +2 | 4× Ore + 1× Gem | +20% base stats |
| +3 | 8× Ore + 3× Gem | +30% base stats |
| +4 | 15× Ore + 5× Gem + 1× Crystal | +45% base stats |
| +5 | 30× Ore + 10× Gem + 5× Crystal | +60% base stats + unlock special effect slot |

---

## World Design

### World Map Regions

| Region | Name | Description | Terrain | Recommended Level |
|---|---|---|---|---|
| 1 | [Starting Region] | Protagonist's homeland; tutorial area | Grasslands, forests | 1–10 |
| 2 | [Desert Region] | Harsh desert kingdom; trade hub | Desert, sandstorm zones | 11–20 |
| 3 | [Northern Reaches] | Frozen tundra; ancient ruins | Snow, ice plains | 21–30 |
| 4 | [Volcanic Archipelago] | Chain of volcanic islands; fire tribes | Lava fields, ocean | 31–40 |
| 5 | [Sky Realm] | Floating continents; endgame zone | Cloud platforms, storms | 41–50 |

### Travel System
- **World Map movement:** Real-time overworld traversal with visible random encounter zones.
- **Fast travel:** Unlocked by visiting a location for the first time; available via World Map menu.
- **Airship:** Unlocked in Chapter 7; required to reach Sky Realm and post-game areas.
- **Encounter rate:** Adjustable in Settings (Low / Normal / High); affects XP gain.

### Encounter Zones

| Zone Type | Encounter Trigger | Flee Difficulty |
|---|---|---|
| Grasslands | Step-on random encounter (10% chance per tile) | Easy |
| Dungeons | Scripted encounters + random (15% per tile) | Medium |
| Boss rooms | Scripted only | Cannot flee |
| Towns | No encounters | — |
| Safe paths | No encounters | — |

---

## Dungeon Design

### Dungeon Types

| Type | Description | Key Features |
|---|---|---|
| Linear | Single path with branching dead-ends for loot | Tutorial-friendly |
| Hub-and-spoke | Central room with 3–5 branching areas | Optional challenges |
| Maze | Complex multi-floor navigation | Map fill exploration |
| Puzzle | Solve puzzles to progress; fewer battles | Heavy environmental focus |
| Gauntlet | Wave-based battles with rest points | No exploration |

### Puzzle Types
| Puzzle Type | Description | Example |
|---|---|---|
| Elemental | Use spell/element to activate switches | Fire lights torches to open door |
| Weight | Place objects on pressure plates | Push stone blocks onto switches |
| Sequence | Activate switches in correct order | Colored tile pattern |
| Stealth | Avoid patrolling enemies | Guard sight-cone avoidance |
| Cipher | Translate in-world script clues | Ancient rune translation |
| Mirror | Redirect light beams to targets | Crystal prism puzzles |

### Boss Room Layout
```
┌─────────────────────────────────────┐
│  Pre-boss save point (Waystone)     │
│  [Optional shop chest / last heal]  │
│                                     │
│  ┌─────────── Boss Arena ─────────┐ │
│  │  Entry trigger cutscene zone   │ │
│  │                                │ │
│  │  [Environmental hazards here]  │ │
│  │                                │ │
│  │         BOSS POSITION          │ │
│  │                                │ │
│  └────────────────────────────────┘ │
└─────────────────────────────────────┘
```
**Boss design rules:**
- All bosses have 2+ attack patterns (Phase 1 and Phase 2 triggered at ~50% HP).
- Bosses drop unique items or equipment on defeat.
- Bosses are never immune to all status effects; each has at least 1–2 weaknesses.

---

## Town Design

### Town Building Types

| Building Type | NPC Roles | Services |
|---|---|---|
| Inn | Innkeeper | Full HP/MP recovery; save point; rumor hints |
| Weapon Shop | Merchant | Buy/sell weapons; enhancement preview |
| Armor Shop | Merchant | Buy/sell armor and accessories |
| Item Shop | Shopkeeper | Buy/sell consumables and crafting materials |
| Blacksmith | Smith NPC | Enhance equipment; craft unique items |
| Guild Hall | Guildmaster, Request Board | Accept side quests; collect quest rewards |
| Tavern | Barkeep, patrons | Lore dialogue; recruit optional party members |
| Magic Library | Scholar NPC | Buy spell tomes; lore encyclopaedia |
| Stables / Port | Travel NPC | Fast-travel services; unlock new routes |

### NPC Dialogue Guidelines
- All shopkeeper NPCs have at least 3 lines of unique flavor dialogue.
- Quest giver NPCs always have: intro dialogue, in-progress dialogue, completion dialogue.
- Optional story NPCs update their dialogue after each major story chapter.

---

## Story Overview

### Three-Act Structure

#### Act 1 — The Inciting World (~Chapters 1–3)
**Goal:** Establish the world, protagonist, and central conflict.
- Protagonist's ordinary world is disrupted.
- Party begins to form.
- First antagonist proxy is encountered.
- World-level threat is introduced.
- Act ends with protagonist committing to the journey.

**Key Events:**
1. [Inciting incident description]
2. [First dungeon and boss]
3. [Revelation / hook for Act 2]

#### Act 2 — Rising Stakes (~Chapters 4–7)
**Goal:** Escalate the conflict; test the party; reveal deeper layers.
- Party crosses into broader world.
- Betrayal or major twist.
- Party is separated or weakened.
- Protagonist faces self-doubt or loss.
- Act ends with renewed determination and assembled team.

**Key Events:**
1. [Political complication]
2. [Mid-game twist / betrayal]
3. [Darkest moment]
4. [Reunion / preparation for final act]

#### Act 3 — Resolution (~Chapters 8–10)
**Goal:** Confront the true antagonist; resolve all character arcs; deliver the ending.
- True nature of the threat revealed.
- Final dungeon sequence.
- Multiple possible endings (Normal and True).
- Post-game content unlocked.

**Key Events:**
1. [True antagonist reveal]
2. [Penultimate trial]
3. [Final battle — Phase 1 and Phase 2]
4. [Ending branch trigger condition]

### Normal Ending Summary
[2–3 sentence description.]

### True Ending Conditions and Summary
[2–3 sentence description of unlock conditions and outcome difference.]

---

## Characters

### Protagonist Template

| Field | Value |
|---|---|
| Name | [Name] |
| Race | [Race] |
| Age | [Age] |
| Class | [Class] |
| Role | [Tank/DPS/Healer/Support/Mage] |
| Starting Stats | HP [x] / MP [x] / STR [x] / DEF [x] / MAG [x] / RES [x] / SPD [x] |
| Backstory | [2–3 sentences] |
| Motivation | [What drives them forward] |
| Flaw | [Their internal struggle] |
| Arc | [How they change over the story] |

### Antagonist Template

| Field | Value |
|---|---|
| Name | [Name] |
| True Identity | [Optional: former hero / corrupted figure] |
| Motivation | [What they want and why they believe they are right] |
| Method | [How they pursue their goal] |
| Phase 1 Boss Stats | HP [x] / STR [x] / MAG [x] / DEF [x] / RES [x] / SPD [x] |
| Phase 2 Boss Stats | HP [x * 0.6 remaining] / enhanced stats |
| Weakness | [Element or status] |

### Party Member Template

| Field | Value |
|---|---|
| Name | [Name] |
| Race | [Race] |
| Class | [Class] |
| Join Condition | [Chapter / event when they join] |
| Role | [Their combat role] |
| Unique Mechanic | [What sets them apart mechanically] |
| Personal Arc | [Their story over the game] |

---

## Quests

### Main Quest Structure

| Chapter | Quest Name | Objective | Reward |
|---|---|---|---|
| 1 | [Quest Name] | [Objective] | [XP, Gold, Item] |
| 2 | [Quest Name] | [Objective] | [XP, Gold, Item] |
| ... | ... | ... | ... |

### Side Quest Types

| Type | Description | Example |
|---|---|---|
| Fetch | Collect N items and return | Gather 10 Herbs for the doctor |
| Escort | Accompany NPC safely to destination | Guard merchant through bandit road |
| Hunt | Defeat a specific monster or boss | Kill the Wyvern in the Cursed Woods |
| Investigation | Talk to NPCs and solve a mystery | Find who stole the artifact |
| Upgrade Chain | Multi-stage quest to upgrade unique item | Reforge the ancient sword in 4 steps |
| Relationship | Spend time with a party member | Unlock Aria's personal subplot |

### Quest Reward Guidelines

| Difficulty | XP Reward | Gold Reward | Item Reward |
|---|---|---|---|
| Easy (Tier 1) | 200–500 | 100–300 | Common item |
| Medium (Tier 2) | 600–1,200 | 400–800 | Uncommon item |
| Hard (Tier 3) | 1,500–3,000 | 1,000–2,500 | Rare item |
| Epic (Tier 4) | 3,500–8,000 | 3,000–6,000 | Epic item |

---

## UI/UX Design

### HUD Elements (In-Battle)

| Element | Position | Description |
|---|---|---|
| Party status bars | Bottom-left | HP/MP bars and status icons for 4 party members |
| Enemy status | Top-right | HP bar(s) with enemy name; status icons |
| Turn order queue | Top-center | Next 8 turns shown as character icons |
| Action menu | Bottom-right | Attack / Skill / Magic / Item / Defend / Flee |
| Limit gauge | Bottom-left under each character | Fills on damage taken |
| Dialogue box | Bottom-center | Battle dialogue and flavor text |

### Menu Navigation

```
Main Menu
├── Items
│   ├── Consumables
│   ├── Key Items
│   └── Materials
├── Equipment
│   └── Per-character slot management
├── Skills
│   └── Per-character skill tree view
├── Party
│   └── Manage active / reserve members
├── Map
│   └── World map and dungeon map
├── Journal
│   ├── Quests (Active / Completed)
│   ├── Bestiary
│   └── Lore Entries
└── Settings
    ├── Audio
    ├── Display
    ├── Gameplay
    └── Accessibility
```

### Accessibility Features
| Feature | Description |
|---|---|
| Text size scaling | Small / Medium / Large / Extra Large |
| Colorblind mode | Deuteranopia / Protanopia / Tritanopia filters |
| Button remapping | Full controller and keyboard remapping |
| Auto-battle | Optional AI auto-fill for battle actions |
| Difficulty selection | Easy / Normal / Hard / Custom |
| Subtitle styling | Background box, font choice, speed control |
| Screen shake toggle | On / Off |
| Flash reduction | Reduce battle flash effects |

---

## Audio Design

### Music Zones

| Zone | Track Style | Example Reference | Loop? |
|---|---|---|---|
| Title Screen | Orchestral — emotional, sweeping | [Reference] | Yes |
| World Map — Act 1 | Light adventurous, flute-led | [Reference] | Yes |
| World Map — Act 2 | Tension-building, string-heavy | [Reference] | Yes |
| World Map — Act 3 | Urgent, percussion-driven | [Reference] | Yes |
| Town — Day | Cheerful, acoustic instruments | [Reference] | Yes |
| Town — Night | Mellow, piano-led | [Reference] | Yes |
| Dungeon — Cave | Ambient, low strings, tension | [Reference] | Yes |
| Dungeon — Temple | Ethereal, choir elements | [Reference] | Yes |
| Standard Battle | Energetic, fast tempo | [Reference] | Yes |
| Boss Battle | Intense, full orchestra | [Reference] | No |
| Final Boss — Phase 1 | Powerful, choir + orchestra | [Reference] | No |
| Final Boss — Phase 2 | Chaotic, distorted, climactic | [Reference] | No |
| Victory Fanfare | Short jingle — classic JRPG | [Reference] | No |
| Game Over | Somber, brief | [Reference] | No |
| Ending Credits | Emotional, full arrangement | [Reference] | No |

### SFX Triggers

| Category | Trigger | SFX Description |
|---|---|---|
| Combat | Physical attack lands | Sharp impact thud; weapon-type variant |
| Combat | Magic spell cast | Element-specific sound signature |
| Combat | Status effect applied | Soft negative chord |
| Combat | Critical hit | Enhanced impact + short sparkle |
| Combat | Character KO | Collapse sound + brief silence |
| UI | Menu open/close | Soft click / swipe |
| UI | Confirm selection | Clean mid-tone click |
| UI | Cancel | Soft lower-pitch click |
| UI | Level up | Rising chime sequence |
| World | Chest open | Wooden creak + shimmer |
| World | Door open | Stone grinding or wood creak |
| World | Save game | Gentle chime sequence |
| World | Ambience — forest | Birds, rustling leaves, wind |
| World | Ambience — dungeon | Dripping water, distant echoes |

---

## Technical Requirements

### Engine & Version
| Requirement | Value |
|---|---|
| Engine | Godot 4.x (stable release) |
| Rendering Backend | Forward+ (PC) / Mobile (Switch) |
| Scripting Language | GDScript (primary); C# (performance-critical modules only) |
| Version Control | Git + GitHub / GitLab |

### Target Platforms

| Platform | API / Mode | Target FPS | Resolution |
|---|---|---|---|
| PC (Windows) | Vulkan / D3D12 | 60 fps | 1920×1080 native; up to 4K |
| PC (Linux) | Vulkan | 60 fps | 1920×1080 |
| macOS | Metal | 60 fps | 2560×1600 |
| Nintendo Switch | OpenGL ES 3 | 30 fps | 1280×720 handheld |

### Minimum PC Specifications

| Component | Minimum | Recommended |
|---|---|---|
| OS | Windows 10 64-bit | Windows 11 64-bit |
| CPU | Intel Core i3-8100 / AMD Ryzen 3 2200G | Intel Core i5-10400 / AMD Ryzen 5 3600 |
| RAM | 4 GB | 8 GB |
| GPU | NVIDIA GTX 960 / AMD RX 470 (2 GB VRAM) | NVIDIA GTX 1660 / AMD RX 5500 XT (4 GB VRAM) |
| Storage | 4 GB available space | 8 GB (SSD recommended) |
| DirectX | Version 12 | Version 12 |

---

## Godot Project Structure

### Scene Tree Overview
```
res://
├── scenes/
│   ├── autoloads/
│   │   ├── GameManager.tscn       # Global state, scene transitions
│   │   ├── AudioManager.tscn      # BGM/SFX playback
│   │   ├── SaveManager.tscn       # Save/load system
│   │   ├── EventBus.tscn          # Global signal bus
│   │   └── DataManager.tscn       # Load JSON data resources
│   ├── battle/
│   │   ├── BattleScene.tscn       # Main battle controller
│   │   ├── BattleUI.tscn          # HUD and menus
│   │   ├── Combatant.tscn         # Base combatant node
│   │   ├── PlayerCombatant.tscn   # Player-controlled combatant
│   │   └── EnemyCombatant.tscn    # AI combatant
│   ├── world/
│   │   ├── WorldMap.tscn
│   │   ├── Town.tscn
│   │   └── Dungeon.tscn
│   ├── ui/
│   │   ├── MainMenu.tscn
│   │   ├── PauseMenu.tscn
│   │   ├── InventoryMenu.tscn
│   │   └── SkillTreeMenu.tscn
│   └── characters/
│       └── [CharacterName].tscn
├── scripts/
│   ├── battle/
│   ├── world/
│   ├── ui/
│   ├── data/
│   └── utils/
├── resources/
│   ├── characters/      # CharacterData resources
│   ├── skills/          # SkillData resources
│   ├── items/           # ItemData resources
│   ├── enemies/         # EnemyData resources
│   └── spells/          # SpellData resources
├── assets/
│   ├── sprites/
│   ├── tilesets/
│   ├── audio/
│   ├── fonts/
│   └── shaders/
└── data/
    └── *.json           # Balancing data, dialogue, quest data
```

### Autoloads (Singletons)
| Autoload Name | Script | Purpose |
|---|---|---|
| GameManager | game_manager.gd | Central game state; current chapter, flags |
| AudioManager | audio_manager.gd | Play/stop/fade BGM and SFX |
| SaveManager | save_manager.gd | Read/write save files (JSON) |
| EventBus | event_bus.gd | Decoupled signal routing |
| DataManager | data_manager.gd | Preload and cache data resources |
| DialogueManager | dialogue_manager.gd | Drive cutscene and dialogue sequences |

### Custom Resource Types
| Resource Class | Extends | Fields |
|---|---|---|
| `CharacterData` | Resource | name, race, class, base stats, growth rates, skill_tree_id |
| `SkillData` | Resource | name, type, element, mp_cost, cooldown, effect_script |
| `ItemData` | Resource | name, category, effect, value, sprite |
| `EnemyData` | Resource | name, stats, loot_table, skill_list, weaknesses |
| `SpellData` | Resource | name, school, element, mp_cost, power, targeting |

---

## Art Direction

### Visual Style
- **Overall style:** HD-2D — high-resolution 2D sprites on 3D layered backgrounds.
- **Camera:** Fixed isometric or top-down perspective for exploration; full-screen for battle.
- **Inspiration:** Octopath Traveler, Triangle Strategy, Sea of Stars.

### Color Theory Guidelines
| Mood | Palette Description | Usage |
|---|---|---|
| Hope / Adventure | Warm golds, sky blues, soft greens | Act 1 environments |
| Mystery / Intrigue | Deep purples, muted teal, shadow grey | Act 2 environments, dungeons |
| Darkness / Despair | Desaturated palette + red accents | Darkest story moments |
| Victory / Triumph | Bright golds, warm whites, sunrise orange | Ending sequences |

### Style Guide Rules
1. Sprites are pixel art at 32×32 base unit.
2. Outlines are 1 px in darker hue of the fill color (not black).
3. Limited palette per character: max 16 colors per sprite sheet.
4. Environments use a wider palette but follow a dominant color per zone.
5. UI uses clean vector-style elements; no pixel art in menus.
6. All cutscene portraits are high-resolution illustrated art (not pixel art).

---

## Asset Pipeline

### Naming Conventions
```
[type]_[subject]_[variant]_[state].[ext]

Examples:
  spr_aria_silverwind_idle.png
  spr_aria_silverwind_attack.png
  env_dungeon_cave_bg_layer1.png
  ui_button_confirm_normal.png
  ui_button_confirm_hover.png
  sfx_battle_sword_hit_01.ogg
  bgm_town_day.ogg
  bgm_boss_final_phase1.ogg
```

### Folder Structure
```
assets/
├── sprites/
│   ├── characters/
│   │   ├── player/
│   │   └── enemies/
│   ├── ui/
│   ├── icons/
│   └── effects/
├── tilesets/
│   ├── world/
│   └── dungeons/
├── backgrounds/
│   ├── battle/
│   └── environment/
├── audio/
│   ├── bgm/
│   ├── sfx/
│   └── voice/  (if applicable)
└── fonts/
```

### Godot Import Settings

| Asset Type | Import Preset | Notes |
|---|---|---|
| Sprite sheets | 2D Pixel; Nearest filter; no mipmaps | Prevent blurring of pixel art |
| UI textures | 2D; Linear filter | Smooth scaling for UI |
| Background art | 2D; Nearest or Linear depending on style | Match to art style |
| Audio — BGM | Import as OGG Vorbis; stream mode | Keep memory usage low |
| Audio — SFX | Import as WAV; uncompressed for short clips | Low-latency playback |
| Fonts | Dynamic font; preload common sizes | Used across all UI |

---

## Testing Strategy

### Test Phases

| Phase | Name | Description | Owner |
|---|---|---|---|
| 1 | Unit Testing | Test individual systems (damage formulas, status logic) | Developer |
| 2 | Integration Testing | Test system interactions (battle + inventory + save) | Developer |
| 3 | Internal Playtesting | Full chapter runs by team; collect feedback | Team |
| 4 | Alpha Testing | Closed test; select external testers; focus on crashes | QA Lead |
| 5 | Beta Testing | Wider test group; full game content; balance feedback | QA Team |
| 6 | Gold Testing | Final pre-launch pass; platform certification checks | All |

### Bug Severity Levels

| Severity | Name | Description | Resolution SLA |
|---|---|---|---|
| S0 | Critical / Blocker | Game crash, data loss, softlock, game-breaking exploit | Fix before next build |
| S1 | Major | Feature broken, serious imbalance, significant visual artifact | Fix within current sprint |
| S2 | Minor | Non-blocking issue; cosmetic bug; typo in dialogue | Fix before beta |
| S3 | Trivial | Very minor visual issue; preference-based feedback | Fix if time permits |

### Balance Testing Checklist
- [ ] All damage formulas produce positive values at minimum stats
- [ ] Level 1 character can defeat tutorial enemies without items
- [ ] No skill or equipment combination breaks the damage cap unexpectedly
- [ ] Final boss is defeatable at intended level with normal gear
- [ ] Status effect durations feel meaningful without being overwhelming
- [ ] XP curve does not require grinding between story segments

---

## Launch Plan

### Release Platforms and Dates

| Platform | Target Date | Notes |
|---|---|---|
| PC (Steam) | [Target Date] | Primary launch platform |
| PC (GOG) | [Target Date] | DRM-free release day-and-date with Steam |
| Nintendo Switch | [Target Date + 3 months] | Requires additional optimization pass |
| PlayStation 5 | [TBD] | Pending platform approval |

### Pricing

| Region | Price (USD equivalent) |
|---|---|
| PC | $19.99 |
| Console | $24.99 |
| Collector's Edition (if applicable) | $49.99 |

### Marketing Milestones

| Milestone | Target Date | Activities |
|---|---|---|
| Announcement Trailer | [Date] | Website launch, social media, press release |
| Demo Release | [Date] | Steam Next Fest participation; itch.io free demo |
| Review Copies Sent | [Date − 2 weeks] | Press, streamers, content creators |
| Launch Day | [Date] | Launch trailer, social push, stream event |
| Post-launch Patch | [Date + 2 weeks] | Community feedback fixes |
| DLC / Expansion (if applicable) | [Date + 6 months] | Additional content drop |

### Post-Launch Content Plan
| Content | Type | Estimated Timeframe |
|---|---|---|
| Patch 1.1 — Balance pass | Free update | 2–4 weeks post-launch |
| Patch 1.2 — Quality of life | Free update | 6–8 weeks post-launch |
| DLC Pack 1 — New story arc | Paid DLC | 4–6 months post-launch |
| New Game+ mode | Free update | 3 months post-launch |
