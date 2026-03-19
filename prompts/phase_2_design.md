# Phase 2: Game Design Document

## Overview

This phase translates the creative bible from Phase 1 into a precise, implementable design specification. The **Game Designer** produces all system designs; the **Game Director** reviews and approves before any development begins in Phase 3. Every mechanic documented here must be complete enough that a developer can implement it without asking design questions.

---

## Objective

Produce a Game Design Document (GDD) that fully specifies:
- Battle system mechanics
- Skill and magic systems
- Race and class systems
- Party and progression systems
- Enemy design framework

All systems must be internally balanced, reference the Phase 1 creative bible for thematic consistency, and include enough numerical detail to be directly implemented.

---

## 1. Battle System Specification

### 1.1 Turn Order Algorithm — Speed-Based ATB

The battle system uses an **Active Time Battle (ATB)** model where each combatant has a gauge that fills based on their SPD stat.

**ATB Fill Rate Formula:**
```
fill_rate = base_fill_rate * (combatant.SPD / average_party_SPD)
base_fill_rate = 100 units per second (at standard game speed)
```

**Turn Resolution:**
- When a combatant's ATB gauge reaches 100, they enter the READY state.
- If multiple combatants reach READY simultaneously (within the same tick), resolve by: highest SPD first. Ties broken by: party members before enemies. Further ties broken by: party member order (slot 1 → 4).
- While a combatant is in READY state, their gauge holds at 100 until they act.
- After acting, gauge resets to 0 and begins filling again.
- Haste status: fill_rate × 1.5
- Slow status: fill_rate × 0.5
- Stun/Sleep: fill_rate = 0 (gauge does not fill)

**ATB Pause Rules:**
- During action animation: all other ATB gauges pause (default setting).
- Optional "Active" mode: gauges continue filling during animations (unlockable difficulty setting).

**Game Speed Settings:**
- Slow: base_fill_rate × 0.6
- Normal: base_fill_rate × 1.0
- Fast: base_fill_rate × 1.4

---

### 1.2 Action Types

#### Attack
- Deals physical damage using the formula:
  ```
  damage = (ATK * 2 - target.DEF) * weapon_modifier * random(0.9, 1.1)
  minimum damage = 1
  ```
- Critical hit threshold: if random(0,1) < crit_chance, damage × 1.5
- Default crit_chance = 0.05 (5%); modified by LCK stat and equipment

#### Skill
- Uses a skill from the character's learned skill list
- Costs MP (or TP depending on skill type)
- Obeys cooldown rules (cooldown begins counting down after the skill resolves)
- See Section 2 for full Skill System specification

#### Magic
- Uses a spell from the character's learned spell list
- Always costs MP
- Elemental damage uses elemental weakness chart (Section 3.3)
- See Section 3 for full Magic System specification

#### Item
- Uses a consumable from the party inventory
- Does not cost MP
- Items have no cooldown
- Item use does not interrupt ATB of other combatants

#### Defend
- Character enters Defend stance until their next turn
- Defend effects:
  - Incoming physical damage reduced by 50%
  - Incoming magical damage reduced by 25%
  - ATB gauge fills at 1.25× speed while defending (quick recovery)
- Defend ends automatically when the character's next ATB turn arrives

#### Flee
- Attempt to escape battle
- Success rate formula:
  ```
  flee_chance = 0.25 + ((avg_party_AGI - avg_enemy_AGI) / 100)
  flee_chance clamped to range [0.05, 0.95]
  ```
- On success: battle ends, no XP or loot awarded
- On failure: character loses their turn; all enemies get +10% ATB
- Boss encounters: flee always fails (flee_chance forced to 0)

---

### 1.3 Status Effects

All status effects have a **duration** measured in turns (number of times the affected character acts) unless otherwise noted. Tick effects trigger at the start of the affected character's turn.

| Status | Type | Duration | Tick Effect | Special Rules |
|---|---|---|---|---|
| **Poison** | Debuff | 5 turns | Lose 5% max HP | Stacks up to 3× (each stack adds 5%) |
| **Burn** | Debuff | 4 turns | Lose 8% max HP; -20% DEF | Fire damage removes Freeze; Burn removed by Ice |
| **Freeze** | Debuff | 3 turns | No action; ATB fills at 0.25× | Physical hits on Frozen target have +50% crit rate |
| **Sleep** | Debuff | 4 turns | No action; HP recovers 5% per turn | Removed by any damage; ATB does not fill |
| **Stun** | Debuff | 1 turn | Skip turn | ATB does not fill during stun |
| **Confuse** | Debuff | 3 turns | Act randomly (attack ally or enemy with basic attack) | 25% chance each turn to attack an ally |
| **Haste** | Buff | 5 turns | None | ATB fills at 1.5× speed |
| **Slow** | Debuff | 5 turns | None | ATB fills at 0.5× speed |
| **Regen** | Buff | 5 turns | Recover 8% max HP | Stacks with healing items |
| **Shield** | Buff | 3 turns | None | Absorbs up to (caster MAG × 4) damage before expiring |
| **Berserk** | Mixed | 4 turns | None | ATK × 1.75; can only use Attack action; DEF -30% |

**Status Application Rules:**
- Each status has a base application rate defined per skill/spell
- Target resistance formula: `final_chance = base_chance * (1 - target.RES_modifier)`
- Bosses have a blanket 50% reduction on all status durations (rounded down, minimum 1)
- Immune status: some enemies have full immunity (0% chance regardless of formula)
- Opposing statuses cancel each other (Haste cancels Slow and vice versa; Burn cancels Freeze and vice versa)

---

## 2. Skill System

### 2.1 Skill Trees

Each character class has a **skill tree** with three branches (typically: Offensive, Defensive/Support, Utility). Racial background unlocks a fourth **Racial Branch** per character (see Section 4).

Skill points are earned at each level-up (1 point per level, bonus points at levels 10/20/30/40/50). Prerequisite skills must be purchased before later-tier skills unlock.

### 2.2 Skill Documentation Format

Every skill must be documented using this exact format:

```
Skill Name: [Name]
Type: [Active / Passive / Reactive]
Element: [Physical / Fire / Ice / Lightning / Holy / Dark / Time / None]
MP Cost: [Integer or "—" for passive]
TP Cost: [Integer or "—" if not applicable]
Cooldown: [Number of turns, or 0 for no cooldown]
Level Requirement: [Minimum character level to unlock]
Skill Point Cost: [Points to unlock in skill tree]
Prerequisite: [Skill Name or "None"]
Damage Formula: [Formula or "—" for non-damaging]
Effect Description: [Full description of what the skill does]
```

### 2.3 Skill List (Minimum 30 Skills)

The following 32 skills span multiple classes and racial branches.

---

**CLASS: Warrior**

```
Skill Name: Power Strike
Type: Active
Element: Physical
MP Cost: 8
TP Cost: —
Cooldown: 1
Level Requirement: 1
Skill Point Cost: 1
Prerequisite: None
Damage Formula: ATK * 2.5 - target.DEF
Effect Description: A focused overhead strike. Deals 250% weapon damage to a 
  single target. Has a 15% chance to inflict Stun for 1 turn.

Skill Name: War Cry
Type: Active
Element: None
MP Cost: 12
TP Cost: —
Cooldown: 4
Level Requirement: 5
Skill Point Cost: 2
Prerequisite: Power Strike
Damage Formula: —
Effect Description: Rallies the party with a battle shout. All party members 
  gain +15% ATK for 4 turns. Does not affect enemies. Triggers at cast; no 
  animation delay on allies.

Skill Name: Shield Bash
Type: Active
Element: Physical
MP Cost: 10
TP Cost: —
Cooldown: 2
Level Requirement: 8
Skill Point Cost: 2
Prerequisite: Power Strike
Damage Formula: ATK * 1.5 - target.DEF
Effect Description: Strikes with equipped shield (or off-hand). Deals 150% 
  physical damage and applies Stun with 40% probability.

Skill Name: Stalwart Stance
Type: Active
Element: None
MP Cost: 6
TP Cost: —
Cooldown: 3
Level Requirement: 12
Skill Point Cost: 2
Prerequisite: Shield Bash
Damage Formula: —
Effect Description: Warrior braces and draws enemy attention. For 3 turns, 
  all single-target attacks from enemies are directed at this character. 
  Warrior gains Shield buff for 2 turns.

Skill Name: Blade Tempest
Type: Active
Element: Physical
MP Cost: 22
TP Cost: —
Cooldown: 4
Level Requirement: 18
Skill Point Cost: 3
Prerequisite: War Cry
Damage Formula: ATK * 1.8 - target.DEF (per hit)
Effect Description: A spinning blade attack that hits all enemies 2 times. 
  Each hit independently rolls for critical hits. Ignores 20% of target DEF.

Skill Name: Iron Resolve
Type: Passive
Element: None
MP Cost: —
TP Cost: —
Cooldown: —
Level Requirement: 15
Skill Point Cost: 2
Prerequisite: Stalwart Stance
Damage Formula: —
Effect Description: Passive. When HP falls below 25%, ATK increases by 30% 
  and DEF increases by 20% until end of battle or HP is healed above 25%.
```

---

**CLASS: Mage**

```
Skill Name: Arcane Bolt
Type: Active
Element: None
MP Cost: 6
TP Cost: —
Cooldown: 0
Level Requirement: 1
Skill Point Cost: 1
Prerequisite: None
Damage Formula: MAG * 2.0
Effect Description: A raw burst of magical energy. Deals 200% magic damage 
  to one target. No elemental affiliation; unaffected by elemental resistance.

Skill Name: Focus
Type: Active
Element: None
MP Cost: 0
TP Cost: —
Cooldown: 3
Level Requirement: 3
Skill Point Cost: 1
Prerequisite: Arcane Bolt
Damage Formula: —
Effect Description: Character concentrates, restoring 15% of max MP and 
  granting +20% MAG for next 2 spells cast.

Skill Name: Spell Surge
Type: Passive
Element: None
MP Cost: —
TP Cost: —
Cooldown: —
Level Requirement: 10
Skill Point Cost: 2
Prerequisite: Focus
Damage Formula: —
Effect Description: Passive. Spells that land a critical hit deal 200% 
  damage instead of 150%. (Stacks with other crit damage bonuses.)

Skill Name: Mana Shield
Type: Reactive
Element: None
MP Cost: 14
TP Cost: —
Cooldown: 5
Level Requirement: 14
Skill Point Cost: 2
Prerequisite: Focus
Damage Formula: —
Effect Description: When the Mage takes damage that would reduce HP below 
  30%, this skill triggers automatically (if not on cooldown). Converts 
  the excess damage into MP drain instead of HP loss.

Skill Name: Overload
Type: Active
Element: None
MP Cost: 30
TP Cost: —
Cooldown: 6
Level Requirement: 22
Skill Point Cost: 3
Prerequisite: Spell Surge
Damage Formula: MAG * 5.0
Effect Description: Channels all available magical energy into one burst. 
  Deals 500% magic damage to one target. After use, Mage's MP is reduced 
  by 20% of max (in addition to cast cost) and ATB gauge resets to 0.
```

---

**CLASS: Rogue**

```
Skill Name: Quick Strike
Type: Active
Element: Physical
MP Cost: 5
TP Cost: —
Cooldown: 0
Level Requirement: 1
Skill Point Cost: 1
Prerequisite: None
Damage Formula: ATK * 1.6 - target.DEF
Effect Description: A fast attack with +15% base critical hit rate. 
  Deals 160% physical damage.

Skill Name: Pickpocket
Type: Active
Element: None
MP Cost: 4
TP Cost: —
Cooldown: 0
Level Requirement: 4
Skill Point Cost: 1
Prerequisite: Quick Strike
Damage Formula: —
Effect Description: Attempt to steal one item from a target enemy. 
  Success rate: 40% + (LCK / 10)%. Stolen item is added to party inventory. 
  Does not deal damage. Fails against bosses.

Skill Name: Shadow Step
Type: Active
Element: None
MP Cost: 10
TP Cost: —
Cooldown: 3
Level Requirement: 8
Skill Point Cost: 2
Prerequisite: Quick Strike
Damage Formula: ATK * 2.8 - target.DEF
Effect Description: Teleports behind target and delivers a critical backstab. 
  Always deals a guaranteed critical hit (150% modifier). Deals 280% physical 
  damage. Rogue gains Haste for 1 turn after use.

Skill Name: Smoke Bomb
Type: Active
Element: None
MP Cost: 8
TP Cost: —
Cooldown: 4
Level Requirement: 12
Skill Point Cost: 2
Prerequisite: Shadow Step
Damage Formula: —
Effect Description: Throws a smoke bomb at all enemies. All enemies have 
  their hit accuracy reduced by 40% for 2 turns. Does not stack.

Skill Name: Exploit Weakness
Type: Passive
Element: None
MP Cost: —
TP Cost: —
Cooldown: —
Level Requirement: 16
Skill Point Cost: 3
Prerequisite: Smoke Bomb
Damage Formula: —
Effect Description: Passive. When attacking a target that has any debuff 
  active, all damage dealt by this character increases by 25%.
```

---

**CLASS: Healer**

```
Skill Name: Mend
Type: Active
Element: Holy
MP Cost: 8
TP Cost: —
Cooldown: 0
Level Requirement: 1
Skill Point Cost: 1
Prerequisite: None
Damage Formula: MAG * 2.5 (healing)
Effect Description: Heals one party member for 250% of caster's MAG stat. 
  Cannot target enemies.

Skill Name: Cleanse
Type: Active
Element: Holy
MP Cost: 10
TP Cost: —
Cooldown: 1
Level Requirement: 4
Skill Point Cost: 1
Prerequisite: Mend
Damage Formula: —
Effect Description: Removes one negative status effect from a party member. 
  Priority order: Stun > Freeze > Sleep > Confuse > Burn > Poison > Slow.

Skill Name: Group Heal
Type: Active
Element: Holy
MP Cost: 20
TP Cost: —
Cooldown: 3
Level Requirement: 10
Skill Point Cost: 2
Prerequisite: Mend
Damage Formula: MAG * 1.8 per target (healing)
Effect Description: Heals all party members for 180% of caster's MAG.

Skill Name: Revive
Type: Active
Element: Holy
MP Cost: 35
TP Cost: —
Cooldown: 5
Level Requirement: 15
Skill Point Cost: 3
Prerequisite: Group Heal
Damage Formula: —
Effect Description: Revives a KO'd party member with 30% of their max HP. 
  Cannot be used on enemies.

Skill Name: Sanctuary
Type: Active
Element: Holy
MP Cost: 40
TP Cost: —
Cooldown: 8
Level Requirement: 25
Skill Point Cost: 3
Prerequisite: Revive
Damage Formula: —
Effect Description: Creates a holy aura around the party for 3 turns. 
  All party members gain Regen. All healing received is increased by 30%. 
  Undead enemies take 10% max HP as Holy damage per tick while the aura 
  is active.
```

---

**RACIAL BRANCH: Draconian**

```
Skill Name: Dragon's Roar
Type: Active
Element: Fire
MP Cost: 15
TP Cost: —
Cooldown: 4
Level Requirement: 6
Skill Point Cost: 2
Prerequisite: None (Draconian only)
Damage Formula: MAG * 2.2 per target
Effect Description: A cone of fire that hits all enemies. Each target has 
  a 30% chance to receive Burn status for 3 turns.

Skill Name: Scale Armor
Type: Passive
Element: None
MP Cost: —
TP Cost: —
Cooldown: —
Level Requirement: 1
Skill Point Cost: 1
Prerequisite: None (Draconian only)
Damage Formula: —
Effect Description: Passive racial trait. Draconian characters permanently 
  have +15% Fire resistance and +10% base DEF. Cannot be removed.

Skill Name: Warclan Oath
Type: Active
Element: None
MP Cost: 20
TP Cost: —
Cooldown: 6
Level Requirement: 20
Skill Point Cost: 3
Prerequisite: Dragon's Roar
Damage Formula: —
Effect Description: Invokes the ancient battle oath. Draconian character 
  and one chosen ally both gain Berserk and Haste for 3 turns. The Berserk 
  penalty (restricted to Attack only) does not apply to the ally — only 
  the ATK boost and speed boost.
```

---

## 3. Magic System

### 3.1 Spell Schools

| School | Description | Primary Stats | Accessible By |
|---|---|---|---|
| **Elemental** | Fire, Ice, Lightning, Earth attacks | MAG, SPD | Mage, Draconian (Fire), Sprite (all) |
| **Holy** | Healing, undead damage, purification | MAG, RES | Healer, Elf |
| **Dark** | Curse, drain, void damage | MAG, LCK | Dark Mage, Draconian (advanced) |
| **Time** | Haste, Slow, Stop, rewind effects | MAG, SPD | Time Mage, Sprite |
| **Support** | Barrier, enhance, field effects | MAG, RES | Healer, Mage (advanced) |

### 3.2 Spell List (Minimum 20 Spells)

Each spell uses the same documentation format as skills (with Element always specified):

```
Spell Name: Fireball
School: Elemental (Fire)
MP Cost: 14
Cast Time: Instant
Cooldown: 0
Level Requirement: 3
Target: Single enemy
Damage Formula: MAG * 3.0
Effect: Deals fire damage. 20% chance to apply Burn (4 turns).

Spell Name: Blizzard
School: Elemental (Ice)
MP Cost: 14
Cast Time: Instant
Cooldown: 0
Level Requirement: 3
Target: Single enemy
Damage Formula: MAG * 3.0
Effect: Deals ice damage. 20% chance to apply Freeze (3 turns).

Spell Name: Thunderstrike
School: Elemental (Lightning)
MP Cost: 14
Cast Time: Instant
Cooldown: 0
Level Requirement: 3
Target: Single enemy
Damage Formula: MAG * 3.0
Effect: Deals lightning damage. 25% chance to apply Stun (1 turn).

Spell Name: Stone Spike
School: Elemental (Earth)
MP Cost: 12
Cast Time: Instant
Cooldown: 0
Level Requirement: 3
Target: Single enemy
Damage Formula: MAG * 2.5
Effect: Deals physical-element magic damage. Ignores 30% of target DEF.

Spell Name: Inferno
School: Elemental (Fire)
MP Cost: 30
Cast Time: Instant
Cooldown: 2
Level Requirement: 15
Target: All enemies
Damage Formula: MAG * 2.8 per target
Effect: Deals fire damage to all enemies. 30% Burn chance per target.

Spell Name: Glacial Storm
School: Elemental (Ice)
MP Cost: 30
Cast Time: Instant
Cooldown: 2
Level Requirement: 15
Target: All enemies
Damage Formula: MAG * 2.8 per target
Effect: Deals ice damage to all enemies. Slow applied to all targets for 2 turns.

Spell Name: Chain Lightning
School: Elemental (Lightning)
MP Cost: 28
Cast Time: Instant
Cooldown: 2
Level Requirement: 15
Target: 3 random enemies (can hit same target multiple times)
Damage Formula: MAG * 2.6 per hit
Effect: Arcs between enemies. Each hit has 20% Stun chance.

Spell Name: Quake
School: Elemental (Earth)
MP Cost: 32
Cast Time: Instant
Cooldown: 3
Level Requirement: 18
Target: All ground-based enemies (does not affect flying)
Damage Formula: MAG * 3.5 per target
Effect: Massive ground upheaval. Ignores 50% DEF. Flying enemies immune.

Spell Name: Cure
School: Holy
MP Cost: 10
Cast Time: Instant
Cooldown: 0
Level Requirement: 1
Target: Single ally
Damage Formula: MAG * 2.0 (healing)
Effect: Restores HP. Also deals (MAG * 2.0) Holy damage if cast on undead.

Spell Name: Cura
School: Holy
MP Cost: 22
Cast Time: Instant
Cooldown: 0
Level Requirement: 12
Target: Single ally
Damage Formula: MAG * 4.0 (healing)
Effect: Stronger version of Cure. Heals and removes Poison.

Spell Name: Curaga
School: Holy
MP Cost: 45
Cast Time: Instant
Cooldown: 1
Level Requirement: 25
Target: Single ally
Damage Formula: MAG * 7.0 (healing)
Effect: Major heal. Removes Poison and Burn. Cures KO if target is at exactly 0 HP.

Spell Name: Holy Smite
School: Holy
MP Cost: 35
Cast Time: Instant
Cooldown: 3
Level Requirement: 20
Target: Single enemy
Damage Formula: MAG * 5.0
Effect: Pure Holy damage. Deals double damage to undead and dark-element enemies.

Spell Name: Shadow Drain
School: Dark
MP Cost: 18
Cast Time: Instant
Cooldown: 2
Level Requirement: 8
Target: Single enemy
Damage Formula: MAG * 2.5
Effect: Deals Dark damage and heals caster for 50% of damage dealt.

Spell Name: Cursed Seal
School: Dark
MP Cost: 24
Cast Time: Instant
Cooldown: 3
Level Requirement: 14
Target: Single enemy
Damage Formula: —
Effect: Applies Poison + Slow simultaneously. 70% application rate. No damage.

Spell Name: Void Touch
School: Dark
MP Cost: 40
Cast Time: Instant
Cooldown: 4
Level Requirement: 22
Target: Single enemy
Damage Formula: MAG * 4.5
Effect: Ignores elemental resistance entirely. Has 15% chance to reduce target 
  to 1 HP regardless of damage calculation (does not work on bosses).

Spell Name: Haste
School: Time
MP Cost: 16
Cast Time: Instant
Cooldown: 2
Level Requirement: 10
Target: Single ally
Damage Formula: —
Effect: Applies Haste status for 5 turns.

Spell Name: Slow
School: Time
MP Cost: 14
Cast Time: Instant
Cooldown: 2
Level Requirement: 10
Target: Single enemy
Damage Formula: —
Effect: Applies Slow status for 5 turns. 80% success rate vs. non-boss.

Spell Name: Stop
School: Time
MP Cost: 30
Cast Time: Instant
Cooldown: 5
Level Requirement: 24
Target: Single enemy
Damage Formula: —
Effect: Applies Stun for 3 turns. ATB does not fill while stopped. 
  50% success rate vs. non-boss. Fails against bosses.

Spell Name: Time Warp
School: Time
MP Cost: 50
Cast Time: Instant
Cooldown: 8
Level Requirement: 35
Target: Single ally
Damage Formula: —
Effect: Resets target's ATB gauge to 100 (immediate extra turn). 
  Cannot be used on the caster.

Spell Name: Barrier Wall
School: Support
MP Cost: 20
Cast Time: Instant
Cooldown: 3
Level Requirement: 12
Target: Single ally
Damage Formula: —
Effect: Applies Shield buff. Shield absorbs damage equal to (caster MAG × 5).

Spell Name: Empower
School: Support
MP Cost: 18
Cast Time: Instant
Cooldown: 3
Level Requirement: 10
Target: Single ally
Damage Formula: —
Effect: Raises target's ATK and MAG by 25% for 4 turns.
```

---

### 3.3 Elemental Weakness Chart

| Attacker ↓ / Defender → | Fire | Ice | Lightning | Earth | Holy | Dark | Physical | None |
|---|---|---|---|---|---|---|---|---|
| **Fire** | 0.5× | 2.0× | 1.0× | 1.0× | 1.0× | 1.0× | — | 1.0× |
| **Ice** | 2.0× | 0.5× | 1.0× | 1.0× | 1.0× | 1.0× | — | 1.0× |
| **Lightning** | 1.0× | 1.0× | 0.5× | 2.0× | 1.0× | 1.0× | — | 1.0× |
| **Earth** | 1.0× | 1.0× | 2.0× | 0.5× | 1.0× | 1.0× | — | 1.0× |
| **Holy** | 1.0× | 1.0× | 1.0× | 1.0× | 0.5× | 2.0× | — | 1.0× |
| **Dark** | 1.0× | 1.0× | 1.0× | 1.0× | 2.0× | 0.5× | — | 1.0× |

Notation: `2.0×` = weakness (double damage), `0.5×` = resistance (half damage), `1.0×` = neutral

**Absorption:** Some enemies absorb a specific element (damage heals them instead). Document per enemy in the Enemy Design section.

**Nullification:** Some enemies are fully immune (0× modifier). Document per enemy.

---

## 4. Race System

### 4.1 Race Stat Modifiers

Base stats are defined per class. Racial modifiers are additive percentage bonuses applied to the base class stats at character creation and scale with leveling.

| Race | HP% | MP% | ATK% | DEF% | MAG% | RES% | SPD% | LCK% |
|---|---|---|---|---|---|---|---|---|
| **Human** | +5% | +5% | +0% | +0% | +0% | +0% | +5% | +10% |
| **Elf** | -5% | +15% | -5% | -5% | +15% | +10% | +10% | +5% |
| **Dwarf** | +15% | -10% | +10% | +20% | -15% | +15% | -10% | +0% |
| **Draconian** | +10% | +0% | +15% | +10% | +5% | -5% | -5% | -5% |
| **Sprite** | -10% | +20% | -10% | -15% | +20% | +5% | +20% | +10% |

### 4.2 Unique Racial Abilities

Each race has one passive and one active racial ability that cannot be removed.

**Human**
- Passive — Adaptable: Gains +1 extra Skill Point per level-up. Equipment restrictions (class-based) are relaxed by one tier.
- Active — Rally (10 MP, Cooldown 6): Inspire one ally, granting them an immediate 50% ATB fill and +10% to all stats for 2 turns.

**Elf**
- Passive — Forest Grace: +15% evasion against physical attacks. Elemental spells cost 10% less MP.
- Active — Nature's Veil (12 MP, Cooldown 5): Enter a semi-transparent state for 2 turns. All enemy single-target physical attacks have a 50% chance to miss this character.

**Dwarf**
- Passive — Stone Skin: The first hit taken each battle that would deal more than 20% max HP is reduced to exactly 20% max HP damage. Resets per battle.
- Active — Forge Oath (0 MP, Cooldown 8): Increases own DEF by 50% and RES by 30% for 3 turns. Also removes one debuff.

**Draconian**
- Passive — Scale Armor: +15% Fire resistance and +10% base DEF (documented in Skill Section 2.3).
- Active — Dragon's Roar: Documented in Skill Section 2.3.

**Sprite**
- Passive — Windborne: Immune to Earth-element damage. Quake spell and ground-based AoE never targets Sprites.
- Active — Phase Shift (18 MP, Cooldown 7): Phases out of physical space for 1 turn. Becomes untargetable by all attacks. ATB fills at 2× during phase. Ends phase on own next turn.

### 4.3 Recommended Classes Per Race

| Race | Recommended Classes | Restricted Classes |
|---|---|---|
| **Human** | Any | None |
| **Elf** | Mage, Healer, Rogue | Heavy Armor Warrior |
| **Dwarf** | Warrior, Artificer | Time Mage |
| **Draconian** | Warrior, Dark Mage | Healer |
| **Sprite** | Time Mage, Mage, Rogue | Warrior, Heavy Artificer |

---

## 5. Party System

### 5.1 Party Composition
- Maximum 4 active party members in battle.
- Up to 8 characters in total roster (4 reserve).
- Reserve characters gain 50% of battle XP.
- Mid-dungeon swap: characters can swap in/out at save point crystals only (no mid-battle swap unless a skill enables it).

### 5.2 Formations

The active formation is selected before battle begins and can be changed at save points.

| Formation | DEF Modifier | ATK Modifier | SPD Modifier | MAG Modifier | Description |
|---|---|---|---|---|---|
| **Standard** | +0% | +0% | +0% | +0% | Balanced. No bonuses or penalties. Default formation. |
| **Aggressive** | -15% | +20% | +10% | +10% | All members positioned forward. High-risk, high-reward. |
| **Defensive** | +25% | -10% | -10% | -5% | Back-line protection. Survivability focused. |
| **Spread** | +0% | +5% | +5% | +5% | Dispersed formation. Reduces AoE damage taken by 20%. |

Formation bonuses apply to all active party members simultaneously.

### 5.3 Morale System

Party morale is a hidden stat (range 0–100, default 50). It fluctuates during battle based on events.

**Morale Gain Events:**
- Party member levels up: +5
- Enemy KO'd: +2
- Critical hit landed: +3
- Ally fully healed from critical HP: +4
- Boss phase broken: +8

**Morale Loss Events:**
- Party member KO'd: -8
- Missed attack: -1
- Status effect applied to party: -3
- Fleeing attempt fails: -5

**Morale Effects:**

| Range | Effect |
|---|---|
| 80–100 | Inspired: +10% to all stats, critical hit rate +5% |
| 50–79 | Normal: No modifier |
| 25–49 | Shaken: -5% to all stats |
| 0–24 | Broken: -15% to all stats, Flee success rate +20% |

---

## 6. Progression System

### 6.1 Leveling Curve

XP required to advance from level N to N+1:

```
xp_required(N) = floor(100 * N^1.8)
```

| Level | XP to Next Level | Cumulative XP |
|---|---|---|
| 1 | 100 | 0 |
| 2 | 287 | 100 |
| 3 | 519 | 387 |
| 4 | 793 | 906 |
| 5 | 1,105 | 1,699 |
| 10 | 3,162 | 12,045 |
| 15 | 6,310 | 38,524 |
| 20 | 10,469 | 88,682 |
| 25 | 15,588 | 168,064 |
| 30 | 21,617 | 283,743 |
| 35 | 28,516 | 441,881 |
| 40 | 36,248 | 647,052 |
| 45 | 44,779 | 903,736 |
| 50 | — (max) | 1,215,948 |

### 6.2 Stat Growth Per Level

Each class has defined stat growth amounts added per level-up (before racial modifiers):

| Stat | Warrior | Mage | Rogue | Healer |
|---|---|---|---|---|
| HP | +40 | +20 | +28 | +25 |
| MP | +8 | +25 | +12 | +22 |
| ATK | +4 | +1 | +3 | +1 |
| DEF | +4 | +1 | +2 | +2 |
| MAG | +1 | +5 | +1 | +4 |
| RES | +2 | +3 | +2 | +4 |
| SPD | +2 | +2 | +4 | +2 |
| LCK | +1 | +2 | +3 | +2 |

### 6.3 Equipment Tiers

| Tier | Level Range | ATK Range | DEF Range | MAG Range | Acquisition |
|---|---|---|---|---|---|
| **Tier 1** | 1–10 | 10–30 | 8–25 | 8–25 | Starting gear, early shops |
| **Tier 2** | 11–20 | 31–65 | 26–55 | 26–55 | Mid-game shops, dungeon drops |
| **Tier 3** | 21–30 | 66–110 | 56–95 | 56–95 | Late-game shops, boss drops |
| **Tier 4** | 31–40 | 111–165 | 96–145 | 96–145 | Rare drops, crafting, side quest rewards |
| **Tier 5** | 41–50 | 166–250 | 146–220 | 146–220 | Legendary items, final boss area only |

---

## 7. Enemy Design Framework

### 7.1 Enemy Archetypes

| Archetype | Role | Stat Profile | Behavior |
|---|---|---|---|
| **Grunt** | Filler/weak attacker | Low HP, low DEF, low ATK | Attacks randomly, no strategy |
| **Bruiser** | Tank/physical damage | High HP, high DEF, high ATK | Targets low-DEF party members |
| **Caster** | Elemental attacker | Low HP, low DEF, high MAG | Uses highest-damage spell vs. weakest RES target |
| **Support** | Buff/heal enemies | Low HP, high RES | Heals and buffs allies before attacking |
| **Assassin** | Status inflictor | Low HP, high SPD, high LCK | Applies status effects, targets party healers |
| **Elite** | Sub-boss | Above-average all stats | Mix of abilities from multiple archetypes |
| **Boss** | Major encounter | 5–10× party HP, immune to many statuses | Phase-based behavior, mechanic changes at HP thresholds |

### 7.2 Boss Design Rules

1. All bosses must have **at least 2 phases**, triggered at HP thresholds (typically 50% and 15%).
2. Each phase change must visibly alter the boss (new animation, color shift, new move set).
3. Bosses are immune to: Stun, Sleep, Confuse, and Freeze.
4. Bosses have **50% duration reduction** on all other applied statuses.
5. Every boss must have:
   - A signature ability unique to that boss
   - At least one mechanic that requires party coordination (e.g., targeting specific limbs, using the correct element, protecting an NPC)
   - A defined loot table (see 7.3)
6. Boss HP scales to average party level at time of first encounter.

### 7.3 Loot Tables

Each enemy type has a loot table with weighted entries:

```
Enemy: [Enemy Name]
Common Drop (60–80% rate): [Item Name, quantity range]
Uncommon Drop (20–35% rate): [Item Name, quantity range]
Rare Drop (5–10% rate): [Item Name, quantity range]
Steal (via Pickpocket): [Item Name, quantity range]
Gold: [min]–[max] (affected by party LCK: +1% per 5 LCK above 20)
```

---

## 8. Collaboration Workflow

### Roles

| Role | Responsibilities |
|---|---|
| **Game Designer** | Produces all system documentation, creates numerical balance tables, maintains the GDD as the single source of truth |
| **Game Director** | Reviews for creative alignment with Phase 1, approves all major system decisions, flags balance concerns for iteration |

### Process

1. Game Designer reads the Phase 1 document fully before drafting any system.
2. Systems are drafted in order: Battle → Skills → Magic → Race → Party → Progression → Enemies.
3. After each major section, Game Director performs an inline review pass.
4. Game Designer revises based on feedback before proceeding to the next section.
5. Completed GDD is reviewed as a whole by Game Director for cross-system consistency.
6. Final sign-off granted before Phase 3 begins.

---

## 9. Completion Checklist

- [ ] Battle system ATB formula documented and verified
- [ ] All 6 action types fully specified
- [ ] All 11 status effects documented with duration, tick effect, and special rules
- [ ] Minimum 30 skills documented using the standard format
- [ ] All skill trees defined per class with branch structure
- [ ] Minimum 20 spells documented across all 5 schools
- [ ] Elemental weakness chart complete (all combinations)
- [ ] All 5 races have stat modifiers, passive ability, and active ability
- [ ] Recommended and restricted class lists per race complete
- [ ] All 4 formations documented with stat modifiers
- [ ] Morale system triggers and effects documented
- [ ] XP table covers levels 1–50
- [ ] Stat growth per level defined for all classes
- [ ] All 5 equipment tiers defined with level ranges and stat ranges
- [ ] All 7 enemy archetypes defined
- [ ] Boss design rules documented (minimum 6 rules)
- [ ] Loot table format defined with example
- [ ] Game Director has completed full-document review pass
- [ ] No placeholder values (all formulas and numbers are final)
- [ ] Game Director formal sign-off recorded (name + date)

**Gate Signed Off By:** _________________________ **Date:** _____________

---

*Proceed to Phase 3: Godot 4 Implementation only after all gate items are checked.*
