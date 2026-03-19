# Skill Tree Template

> **Instructions:** Copy the Template Fields section to design your own skill tree. The fully worked Warrior class example follows, demonstrating how to populate all three branches.

---

## Template Fields

```
Class Name:
Skill Tree Theme: [What is the narrative identity of this class's skills?]
Stat Priority:    [Which stats does this class's skill tree most care about?]
Role(s):          [Tank / DPS / Healer / Support / Mage / Hybrid]

Branch 1 Name:    [Theme — e.g., Offense / Blade Arts / Fire Magic]
Branch 2 Name:    [Theme — e.g., Defense / Iron Will / Healing]
Branch 3 Name:    [Theme — e.g., Utility / Leadership / Debuff]

For each skill (30 skills total — 10 per branch):
  Skill Name:    [Name]
  Skill Number:  [Branch letter + number, e.g., A1, A2 ... A10]
  Type:          [Active / Passive / Reaction]
  Element:       [Fire / Ice / Thunder / Earth / Light / Dark / Physical / Non-Elemental / —]
  MP Cost:       [x or 0 for passive]
  Cooldown:      [x turns or — for passive / instant]
  Level Req:     [Minimum character level to unlock this skill]
  SP Cost:       [Skill Points required — default 1 per skill; capstone skills may cost 2]
  Effect:        [Mechanical description with formula where applicable]
  Combo Notes:   [Optional — what this skill combos with]

Capstone Synergy: [What bonus unlocks when all three branch capstone skills are learned?]
```

---

---

# ✅ Example: Warrior Class Skill Tree

**Class:** Warrior
**Theme:** A master of physical combat who can cut through enemies, absorb punishment, and inspire their allies to greater heights. Warriors are defined by their ability to escalate — the longer a fight goes, the more dangerous they become.
**Stat Priority:** STR > DEF > HP > SPD
**Roles:** DPS / Tank / Support (Leadership branch)

---

## Branch 1: Offense — Blade Arts

> *The Blade Arts branch transforms a competent soldier into a force of nature. Skills in this branch escalate in power and creativity, moving from reliable basics to reality-defying finishing strikes. A full Blade Arts Warrior has the highest single-target damage ceiling of any physical class.*

### Unlock Path
```
Power Strike (A1) → Rend (A2) → Whirlwind Slash (A3) → Blade Storm (A4) → Armor Pierce (A5)
→ Cross Slash (A6) → Limit Breaker (A7) → Thousand Cuts (A8) → Godslayer Strike (A9)
→ Blade of Judgment (A10) ★ CAPSTONE
```

### Branch A Skills

| # | Skill Name | Type | Element | MP Cost | Cooldown | Level Req | SP | Effect |
|---|---|---|---|---|---|---|---|---|
| A1 | Power Strike | Active | Physical | 8 | 0 | Lv 1 | 1 | Deal damage to a single enemy equal to **STR × 1.5 − DEF**. Reliable, no conditions. Your first real damage skill. |
| A2 | Rend | Active | Physical | 12 | 1 | Lv 5 | 1 | Deal **STR × 1.2 − DEF** damage to a single enemy. On hit, apply **Bleed** — target loses 3% max HP per turn for 4 turns (stackable up to 3 times). |
| A3 | Whirlwind Slash | Active | Physical | 18 | 2 | Lv 10 | 1 | Spin and hit **all enemies** for **STR × 1.0 − DEF** damage. Excellent for clearing groups. Each target rolls independently for Bleed if A2 is known (passive bonus unlock). |
| A4 | Blade Storm | Active | Physical | 25 | 3 | Lv 15 | 1 | Strike **3 times**, each hit targeting a random enemy for **STR × 1.8 − DEF**. Multiple hits can land on same target. Crits apply independently per hit. |
| A5 | Armor Pierce | Active | Physical | 20 | 2 | Lv 20 | 1 | Strike a single enemy for **STR × 2.0** (ignores DEF entirely — DEF multiplier is 0). Ideal against heavily armored enemies. Does not ignore percentage damage reduction effects. |
| A6 | Cross Slash | Active | Physical | 30 | 3 | Lv 25 | 1 | Deal **STR × 2.5 − DEF** damage to a single enemy. 20% chance to apply **Stun** (target skips next turn). If used against a Stunned target, damage is increased to STR × 3.0. |
| A7 | Limit Breaker | Active | Physical | 40 | 4 | Lv 30 | 1 | Can only be used when caster's HP is below 50%. Deal **STR × 3.0 − DEF** to a single target. If used while HP is below 25%, damage multiplier increases to **STR × 4.0**. Bonus: restores 10% of max HP on use. |
| A8 | Thousand Cuts | Active | Physical | 35 | 4 | Lv 35 | 1 | Strike a single target **8 times**, each hit dealing **STR × 0.5 − (DEF / 8)** damage. Each hit rolls independently for crits. Exceptional against targets with Bleed stacks (8 bleed activation chances per use). |
| A9 | Godslayer Strike | Active | Physical | 50 | 5 | Lv 40 | 1 | Deal **STR × 4.0 − (DEF × 0.5)** to a single target (reduces but does not ignore DEF). If the target is a boss-tier enemy, add a bonus **STR × 1.0** damage that ignores all defenses. |
| A10 | Blade of Judgment | Active | Physical/Light | 60 | 6 | Lv 50 | 2 | **★ CAPSTONE** — Channel physical mastery and inner light into a sweeping strike that hits **all enemies** for **STR × 5.0 + MAG × 1.0 − DEF**. The Light element component cannot be resisted by non-immune enemies. Leaves all surviving enemies with −15% DEF for 3 turns. |

### Branch A Passive Bonuses (granted by learning skills, no SP cost)
- Learning A2 (Rend): All Branch A physical skills have a 5% chance to apply Bleed on hit.
- Learning A5 (Armor Pierce): DEF reduction from all sources is increased by 10% for this character.
- Learning A8 (Thousand Cuts): Multi-hit skills deal +5% damage per hit beyond the first.

---

## Branch 2: Defense — Iron Will

> *The Iron Will branch builds the Warrior into an immovable object. Skills in this branch move from passive resilience bonuses to active defensive techniques to party-protecting abilities. A full Iron Will Warrior is among the most durable characters in the game, capable of surviving attacks that would kill any other class.*

### Unlock Path
```
Guard Stance (B1) → Parry (B2) → Fortify (B3) → Shield Bash (B4) → Iron Skin (B5)
→ Stalwart (B6) → Last Stand (B7) → Provoke (B8) → Unbreakable (B9)
→ Bastion (B10) ★ CAPSTONE
```

### Branch B Skills

| # | Skill Name | Type | Element | MP Cost | Cooldown | Level Req | SP | Effect |
|---|---|---|---|---|---|---|---|---|
| B1 | Guard Stance | Passive | — | 0 | — | Lv 1 | 1 | **Permanently** increase this character's DEF by 10%. Always active; cannot be dispelled. |
| B2 | Parry | Active | Physical | 10 | 1 | Lv 5 | 1 | Declare before this character's turn ends. If a physical attack targets this character before their next turn, automatically counter with **DEF × 2** damage to the attacker. Only works once per activation. |
| B3 | Fortify | Active | Support | 15 | 3 | Lv 10 | 1 | Raise this character's DEF and RES by **30%** for 2 turns. Stacks with Guard Stance and equipment bonuses. |
| B4 | Shield Bash | Active | Physical | 14 | 2 | Lv 15 | 1 | Strike with shield for **DEF × 1.5** damage to a single enemy. 30% chance to apply **Stun**. Scales with DEF rather than STR — uniquely powerful for high-DEF builds. |
| B5 | Iron Skin | Passive | — | 0 | — | Lv 20 | 1 | **Permanently** reduce all incoming physical damage by 10% (applied after DEF calculation). Stacks multiplicatively with racial damage reduction and Guard Stance. |
| B6 | Stalwart | Passive | — | 0 | — | Lv 25 | 1 | This character is **immune to Stun**. Additionally, the Sleep status effect's duration is halved (rounded up) when applied to this character. |
| B7 | Last Stand | Passive | — | 0 | — | Lv 30 | 1 | When this character's HP falls below 25% of maximum, their DEF and STR are automatically increased by **40%**. This increase remains active until HP is restored above 25%. Cannot be dispelled; is not a buff status. |
| B8 | Provoke | Active | Support | 12 | 2 | Lv 35 | 1 | **Taunt** all enemies — for the next 2 turns, all enemy single-target attacks and skills are redirected to this character. AoE abilities are unaffected. The Warrior must survive this window; use with Fortify or Last Stand for maximum effect. |
| B9 | Unbreakable | Active | Support | 30 | 5 | Lv 40 | 1 | This character becomes **immune to all status effects** for 3 turns. Does not remove existing status effects; prevents new ones only. An exceptional response to status-heavy enemies. |
| B10 | Bastion | Active | Support | 45 | 6 | Lv 50 | 2 | **★ CAPSTONE** — Raise a magical barrier around the **entire party**. Each party member (including this character) gains a shield that absorbs damage equal to 50% of the Warrior's DEF stat. The shield lasts until it absorbs its maximum value or for 3 turns, whichever comes first. Multiple shields on the same character stack. |

### Branch B Passive Bonuses
- Learning B3 (Fortify): Self-healing items and HP recovery effects are 15% more effective on this character.
- Learning B5 (Iron Skin): This character's Parry counter (B2) deals +20% damage.
- Learning B9 (Unbreakable): The duration of Provoke (B8) is extended to 3 turns.

---

## Branch 3: Leadership — Warlord's Call

> *The Warlord's Call branch makes the Warrior the best party member in the game. Skills in this branch focus on supporting allies, disrupting enemies, and scaling the entire party's power. A full Leadership Warrior may not deal the highest individual damage, but a party led by one is considerably stronger than a party without.*

### Unlock Path
```
Encourage (C1) → Battle Cry (C2) → Tactical Retreat (C3) → Morale Boost (C4) → Inspire (C5)
→ Veteran's Eye (C6) → Rally the Fallen (C7) → Commander's Aura (C8) → Decisive Blow (C9)
→ Legendary Warrior (C10) ★ CAPSTONE
```

### Branch C Skills

| # | Skill Name | Type | Element | MP Cost | Cooldown | Level Req | SP | Effect |
|---|---|---|---|---|---|---|---|---|
| C1 | Encourage | Active | Support | 8 | 2 | Lv 1 | 1 | Remove **Fear** and **Confusion** from one ally and restore a small amount of HP equal to **STR × 0.3**. Simple but valuable in early fights. |
| C2 | Battle Cry | Active | Support | 15 | 3 | Lv 5 | 1 | Raise the entire party's STR by **15%** for 2 turns (including this character). Does not stack with itself; refreshes on recast. Stacks with Human's Rally for a combined 25%+ bonus. |
| C3 | Tactical Retreat | Active | Support | 20 | 4 | Lv 10 | 1 | Swap this character out for a **reserve party member** mid-battle. The incoming reserve member acts immediately on their first turn (does not wait for the next round). Provides invaluable flexibility in long encounters. |
| C4 | Morale Boost | Active | Support | 20 | 3 | Lv 15 | 1 | Restore HP equal to **STR × 0.5** to **all party members**. Scales well with high STR builds. Not a substitute for a dedicated Healer but provides meaningful sustain. |
| C5 | Inspire | Active | Support | 25 | 4 | Lv 20 | 1 | Apply **Haste** (SPD × 1.5 for turn order) to all party members for 2 turns. In a fast party, this can enable two full party turns before the enemy acts once. |
| C6 | Veteran's Eye | Passive | — | 0 | — | Lv 25 | 1 | This character can see all enemy HP values and elemental weaknesses automatically without needing to scan or use items. Additionally, weaknesses are highlighted in the skill selection menu. |
| C7 | Rally the Fallen | Active | Support | 40 | 6 | Lv 30 | 1 | **Revive all KO'd party members** simultaneously with 25% of their maximum HP. One of the most powerful recovery tools available to a non-Healer class. High MP cost is a deliberate tradeoff. |
| C8 | Commander's Aura | Passive | — | 0 | — | Lv 35 | 1 | All party members deal **5% more damage per Warrior currently in the active party** (including this character). With two Warriors active, the entire party deals 10% more damage. Aura bonus is always active while Warrior is in party. |
| C9 | Decisive Blow | Active | Physical | 35 | 5 | Lv 40 | 1 | Deal **STR × 2.5 − DEF** to a single enemy. If the target's current HP is below **15%** of their maximum HP after this hit, they are **instantly killed** (does not work on bosses with Undying Phase mechanics). |
| C10 | Legendary Warrior | Passive | — | 0 | — | Lv 50 | 2 | **★ CAPSTONE** — All skills in Branch A (Blade Arts) and Branch B (Iron Will) have their MP costs reduced by **20%** (stacks with racial and equipment MP reductions). Additionally, all offensive damage dealt by this character is increased by a flat **20%** after all other modifiers. The pinnacle of Warrior mastery. |

### Branch C Passive Bonuses
- Learning C2 (Battle Cry): All party buff durations are extended by 1 turn for buffs this character applies.
- Learning C5 (Inspire): When this character uses a Support skill, they have a 15% chance to also recover 5% of their own max HP.
- Learning C8 (Commander's Aura): Provoke (B8) also grants this character a 10% damage boost while active.

---

## Full Capstone Synergy

**Requirement:** Learn all three branch capstone skills — Blade of Judgment (A10), Bastion (B10), Legendary Warrior (C10).

**Unlocked Ability: Warlord's Legacy (Passive)**
> Once all three capstones are learned, a permanent hidden passive activates:
> - The Warrior's Limit Break gauge fills 25% faster than normal.
> - When this character's HP falls below 30%, all branch skills become cost-free for 1 turn (emergency response window).
> - Battle Cry (C2) now additionally boosts the entire party's DEF by 10% in addition to STR.
> - Blade of Judgment (A10)'s cooldown is reduced from 6 turns to 4 turns.

---

## Skill Synergy Notes

### High-Priority Combos

**Rend + Thousand Cuts (A2 + A8)**
> Apply Bleed with Rend first, then use Thousand Cuts. Each of the 8 hits from Thousand Cuts has a chance to stack an additional Bleed. A single well-executed Rend → Thousand Cuts sequence can result in 3 Bleed stacks (maximum), dealing consistent damage-over-time while the Warrior sets up the next big hit.

**Guard Stance + Last Stand + Provoke (B1 + B7 + B8)**
> The core "Tank Loop." Activate Provoke to draw all attacks, then let Last Stand's passive kick in when HP drops low. With Guard Stance providing baseline DEF, Iron Skin reducing physical damage, and Last Stand providing the reactive boost, the Warrior effectively becomes harder to kill as the fight goes on.

**Battle Cry + Blade of Judgment (C2 + A10)**
> Apply Battle Cry to boost the entire party's STR, then immediately follow with Blade of Judgment. Since Blade of Judgment uses the Warrior's STR (now boosted by Battle Cry), the AoE damage is substantially higher than it would be without the setup. Best used to open a difficult encounter.

**Inspire + Battle Cry (C5 + C2)**
> Apply both buffs in sequence: Inspire gives the party a speed advantage, then Battle Cry amplifies their damage. The speed boost means the party may act again before enemies can counter the STR buff, compounding the advantage.

**Provoke + Unbreakable (B8 + B9)**
> Activate Unbreakable first (status immunity), then immediately use Provoke. While taunting all enemies, the Warrior is completely immune to status effects — no Poison, Blind, or Slow can land. Coordinate with a Healer to sustain HP during the taunt window.

**Limit Breaker + Morale Boost (A7 + C4)**
> Drop HP intentionally (or let it drop naturally) to trigger Limit Breaker's damage bonus, then use Morale Boost to heal the party without restoring the Warrior's own HP past the threshold. This is a high-risk strategy but produces exceptional damage numbers while also supporting the team.

**Decisive Blow + Thousand Cuts (C9 + A8)**
> Use Thousand Cuts to whittle a high-HP target down to near death (8 independent hits makes reaching the 15% threshold reliable), then follow with Decisive Blow for the instant kill. Particularly effective against mid-tier enemies that would otherwise survive a single big hit.

**Commander's Aura + Rally the Fallen (C8 + C7)**
> The Leadership synergy: keep the Warrior in the party to passively boost all allied damage, and hold Rally the Fallen in reserve as a panic button. In parties that include two Warriors, Commander's Aura stacks to a +10% bonus for all members, making it one of the strongest passive party bonuses available.

---

## Skill Upgrade Paths (Text Diagram)

### Branch A — The Escalating Blade
```
[A1] Power Strike ─────────────────────────────────────┐
       Basic STR hit; your foundation                  │
         │                                             │
[A2] Rend ──────────────────────────────── adds Bleed  │
       Bleed application                               │
         │                                             │
[A3] Whirlwind Slash ──────── expands to AoE           │
       Group damage tool                               │
         │                                             │
[A4] Blade Storm ─────────────── adds multi-hit        │
       Three-hit randomized version                    │
         │                                             │
[A5] Armor Pierce ────────────── strips DEF entirely   │
       Anti-armor specialist                           │
         │                                             │
[A6] Cross Slash ─────────────── adds Stun synergy     │
       Setup for cross-skill combos                    │
         │                                             │
[A7] Limit Breaker ─────────────── HP gate mechanic    │
       High-risk, high-reward                          │
         │                                             │
[A8] Thousand Cuts ──────────── bleed stacking engine  │
       Maximizes Bleed + multi-crit                    │
         │                                             │
[A9] Godslayer Strike ──── boss-tier extra hit         │
       The penultimate strike                          │
         │                                             │
[A10] Blade of Judgment ★ ─────── AoE + Light fusion  ─┘
       CAPSTONE: Everything you learned, combined
```

### Branch B — The Wall That Fights Back
```
[B1] Guard Stance ─────── baseline DEF boost (permanent)
         │
[B2] Parry ────────────── reactive counter
         │
[B3] Fortify ──────────── active burst defense
         │
[B4] Shield Bash ─────── DEF-scaling offense (crossover)
         │
[B5] Iron Skin ────────── second permanent damage reduction
         │
[B6] Stalwart ─────────── Stun immunity, Sleep resist
         │
[B7] Last Stand ───────── low-HP power spike (permanent)
         │
[B8] Provoke ──────────── aggro control
         │
[B9] Unbreakable ─────── status immunity window
         │
[B10] Bastion ★ ──────── party-wide barrier
       CAPSTONE: Your resilience becomes the party's shield
```

### Branch C — The General's Arc
```
[C1] Encourage ────────── basic status clear + minor heal
         │
[C2] Battle Cry ──────── party STR boost
         │
[C3] Tactical Retreat ─── mid-battle flexibility
         │
[C4] Morale Boost ─────── party HP recovery (STR-scaling)
         │
[C5] Inspire ──────────── party Haste
         │
[C6] Veteran's Eye ────── intelligence advantage (passive)
         │
[C7] Rally the Fallen ─── mass revive
         │
[C8] Commander's Aura ─── permanent party damage buff (passive)
         │
[C9] Decisive Blow ────── execute finisher
         │
[C10] Legendary Warrior ★ ─── everything costs less; +20% damage
       CAPSTONE: The sum of all battles; the complete warrior
```

### Cross-Branch Synergy Paths
```
A2 Rend ──────────────────────────────────> A8 Thousand Cuts
  [Bleed → stack it faster with multi-hits]

B1 Guard Stance + B5 Iron Skin ──────────> Highest physical DR in game
  [Combine for ~22% passive phys reduction before other effects]

C2 Battle Cry ───────────────────────────> A10 Blade of Judgment
  [Buff STR first, then dump it into the capstone AoE]

B8 Provoke + B9 Unbreakable ─────────────> Ultimate tank window
  [No status; all aggro; survive anything]

C8 Commander's Aura ─────────────────────> C4 Morale Boost
  [Higher party STR = stronger Morale Boost scaling]

A7 Limit Breaker + C7 Rally the Fallen ──> Emergency full-party reset
  [Use Limit Breaker, let HP stay low, revive fallen with Rally]
```
