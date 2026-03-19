# Race Design Template

> **Instructions:** Copy the Template Fields section below for each new race you create. Fill in every field. The five fully populated example races follow the template.

---

## Template Fields

Fill out the following for each race:

```
Race Name:
Lore Summary (2-3 paragraphs):
  - Origins and history
  - Cultural identity and values
  - Relationship with the world and other races

Stat Modifiers (relative to a neutral baseline of 0):
  HP:   [+/−x or "none"]
  MP:   [+/−x or "none"]
  STR:  [+/−x or "none"]
  DEF:  [+/−x or "none"]
  MAG:  [+/−x or "none"]
  RES:  [+/−x or "none"]
  SPD:  [+/−x or "none"]
  LCK:  [+/−x or "none"]

Growth Rate Modifiers (applied to class base growth per level):
  [Stat]: ×[modifier]  (e.g., MAG: ×1.2 means 20% more MAG per level)

Passive Racial Ability:
  Name:        [Ability Name]
  Trigger:     [Always active / Conditional — describe trigger]
  Effect:      [Full mechanical description with exact numbers]
  Notes:       [Edge cases, interactions, stacking rules]

Active Racial Skill:
  Name:        [Skill Name]
  MP Cost:     [x]
  Cooldown:    [x turns]
  Targeting:   [Single / All enemies / All allies / All combatants]
  Element:     [Element or Non-Elemental]
  Effect:      [Full mechanical description with exact numbers and durations]
  Notes:       [Edge cases, scaling, combos]

Recommended Classes:     [List of classes that synergize well with this race]
Discouraged Classes:     [List of classes where racial penalties create friction]
Unique Narrative Role:   [How this race typically fits into story/party roles]

Visual Design:
  Color Palette — Skin/Scales:  [Hex codes]
  Color Palette — Hair/Feature: [Hex codes]
  Color Palette — Clothing/Armor: [Hex codes]
  Color Palette — Eye Color:    [Hex codes]
  Distinctive Features:         [e.g., pointed ears, horns, wings, small stature]
  Sprite Notes:                 [Any special sprite considerations — glow effects, etc.]

Audio Notes:
  Voice Archetype: [e.g., warm and earthy / ethereal and high-pitched / gruff and resonant]
  Racial Skill SFX: [Brief description of the sound design for the active racial skill]
```

---

---

## Race 1: Humans

### Lore

Humans are the most numerous and widespread race in Aethoria. Where Elves measure their history in millennia and Dwarves in the deep memory of stone, Humans measure theirs in generations — and it is precisely this brevity that shapes their character. They build, they lose, they rebuild. They form empires and watch them crumble, then lay the foundations for the next one before the dust has settled. Critics from longer-lived races call this restlessness; Humans call it ambition.

Culturally, Humans are the great synthesizers of Aethoria. Their cities draw traders and travelers from every corner of the world, and their institutions — the Merchant Consortium, the Royal Academies, the Adventurer's Guilds — are designed to absorb and integrate outside knowledge with a speed that no other race can match. A Human child who grows up near an Elven archive will study magic with a ferocity that shames some Elves twice their age. A Human soldier who trains under a Dwarf veteran will develop a resilience that surprises even their teacher.

This adaptability is their defining trait and their greatest strength. Humans are not the most powerful at any single discipline, but they are the most *capable* — the race that produces warriors, mages, healers, bards, and everything in between in roughly equal measure. In a party of specialists, a Human is often the one who fills whatever gap exists, quietly and without complaint. They are also, it should be noted, the race most likely to start a war, end a war, profit from a war, and then write an epic poem about it.

### Stat Modifiers

| Stat | Modifier |
|---|---|
| HP | +5% of base value |
| MP | +5% of base value |
| STR | +5% of base value |
| DEF | +5% of base value |
| MAG | +5% of base value |
| RES | +5% of base value |
| SPD | +5% of base value |
| LCK | +5% of base value |

> **Note:** The Human bonus is a flat +5% applied to all base stats — no individual stat is enhanced or penalized. This makes Humans the strongest in absolute numbers when combined with a well-rounded class, but they never achieve the extreme highs of a specialized race.

### Growth Rate Modifiers

| Stat | Modifier |
|---|---|
| All stats | ×1.05 (5% bonus to all class growth rates) |

### Passive Racial Ability — Quick Learner

**Trigger:** Always active.
**Effect:** Humans gain 10% bonus XP from all sources — battle XP, quest XP, story XP, and exploration XP. Skill Points (SP) earned per level-up are increased from 2 to 3 for Human characters. Human characters unlock the second tier of a skill branch (skills 4–6) one level earlier than the stated level requirement.
**Notes:** The XP bonus stacks multiplicatively with XP bonus equipment and consumables. The SP bonus does not stack with class abilities that also grant bonus SP — take the higher value.

### Active Racial Skill — Rally

**MP Cost:** 15
**Cooldown:** 5 turns
**Targeting:** All party members
**Element:** Non-Elemental
**Effect:** The Human lets out an inspiring battle cry, instantly boosting all party members' STR and MAG by 10% for 3 turns. Additionally, Rally cures the Confusion and Sleep status effects from all affected party members. The stat boost applies to the Human themselves as well.
**Notes:** Stacks with other STR/MAG buffs. Does not stack with a second casting of Rally (refresh timer only). Particularly effective as an opener or recovery move when the party is debuffed.

### Recommended Classes
Warrior, Mage, Ranger, Healer, Knight, Bard — all classes. Humans have no class exclusions and no penalties that disadvantage any role.

### Discouraged Classes
None. Humans are the ideal race for players who are undecided on a playstyle.

### Unique Narrative Role
Humans function well as protagonists and as the "everyman" anchor of a mixed-race party. Their flexibility means they are often the character who bridges cultural gaps between party members of different races.

### Visual Design

| Element | Palette |
|---|---|
| Skin tones | `#F5CBA7`, `#E8A87C`, `#C68642`, `#A0522D`, `#8D5524`, `#6B3A2A` |
| Hair colors | `#2C1810`, `#8B4513`, `#DAA520`, `#F5F5DC`, `#1C1C1C`, `#C0C0C0` |
| Eye colors | `#4A90D9`, `#2E7D32`, `#795548`, `#607D8B`, `#9C27B0` |
| Armor accents | `#708090`, `#C0C0C0`, `#FFD700`, `#8B0000` |

**Distinctive Features:** No supernatural features. Humans read as the "normal" baseline — no glowing eyes, no unusual proportions, no visible magic aura.
**Sprite Notes:** Human sprites rely on clothing and equipment variety rather than race-specific effects to communicate personality.

### Audio Notes
**Voice Archetype:** Highly varied — the broadest range of voice archetypes belongs to Humans.
**Racial Skill SFX:** A sharp, inspiring shout followed by a rising brass stinger (1.5 seconds). Party members' sprites briefly flash a warm golden hue.

---

---

## Race 2: Elves

### Lore

The Elves of Aethoria are among the oldest sentient races, and they have never entirely forgiven the world for not appreciating this. They were tending great arcane libraries and forging pacts with elemental forces when Humans were still painting on cave walls and Dwarves were debating the finer points of metallurgical theory. This history grants Elves a depth of knowledge and a quality of magical aptitude unmatched by any other race — and, if one is being honest, a certain insufferable patience.

Elves are deeply connected to what they call the *Aetherweft* — the invisible lattice of magical energy that underlies all of Aethoria's natural world. Every forest, every river, every stone has a resonance in the Aetherweft, and Elves are born with the ability to perceive and interact with these resonances. This manifests practically as superior spellcasting efficiency: an Elf mage who has spent a century studying a spell has an intuitive shorthand for its magical structure that allows them to cast it with less energy than most mortals would need.

Culturally, Elves are organized into city-states called Groves, each governed by a council of elder arcanists and nature-speakers. The Groves are generally neutral in mortal politics — they consider the rise and fall of kingdoms a short-term phenomenon — but they maintain close diplomatic ties with each other and will unite with startling speed when something threatens the Aetherweft itself. The Shattered Covenant is, to Elven eyes, the most serious threat to the Aetherweft in recorded history, which is why a small but significant number of Elves have stepped outside their traditional neutrality to act.

### Stat Modifiers

| Stat | Modifier |
|---|---|
| HP | none |
| MP | +10 |
| STR | −10 |
| DEF | −10 |
| MAG | +20 |
| RES | +10 |
| SPD | +15 |
| LCK | +5 |

> **Design note:** Elves are the quintessential magical glass cannon. They hit extremely hard with spells and act early in turn order, but fold quickly to physical attacks. Party composition should account for their fragility.

### Growth Rate Modifiers

| Stat | Modifier |
|---|---|
| MAG | ×1.2 per level |
| MP | ×1.1 per level |
| SPD | ×1.1 per level |
| STR | ×0.9 per level |
| DEF | ×0.9 per level |

### Passive Racial Ability — Arcane Affinity

**Trigger:** Always active.
**Effect:** All MP costs for this character's skills and spells are reduced by 10% (rounded down, minimum cost of 1). Additionally, all spell damage dealt by this character is increased by 5% for each Elf currently in the active battle party, including themselves. Maximum stack: +15% with three Elves active.
**Notes:** The MP reduction applies before equipment modifiers. The spell damage bonus applies after all other damage calculation steps. "Spells" includes all skills tagged as the Magic category but not Active physical skills.

### Active Racial Skill — Nature's Grasp

**MP Cost:** 20
**Cooldown:** 4 turns
**Targeting:** All enemies
**Element:** Earth
**Effect:** Summon thorny vines from the earth beneath all enemies. Targets are rooted in place for 2 turns (cannot act, cannot flee). Each rooted target takes damage equal to 80% of the caster's MAG stat as Earth-elemental damage at the start of each of their turns while rooted. Flying-type enemies are immune to the root but still take 50% damage each turn.
**Notes:** Root can be resisted by Stun-immune enemies (same resistance category). Damage component respects elemental affinity — Earth-weak enemies take double damage. Pairs exceptionally well with slow AoE spells, as rooted enemies cannot move out of sustained damage areas.

### Recommended Classes
Mage, Ranger, Druid, Summoner, Time Mage, Illusionist

### Discouraged Classes
Warrior, Knight, Berserker (the STR and DEF penalties significantly impair physical roles)

### Unique Narrative Role
Elves often function as the "lore keeper" and exposition delivery character in a party. Their age means they frequently have relevant historical knowledge about ancient threats.

### Visual Design

| Element | Palette |
|---|---|
| Skin tones | `#E8D5B7`, `#D4B896`, `#C5A882`, `#B8997A` |
| Hair colors | `#F5F5DC`, `#FFFFF0`, `#90EE90`, `#FFFFFF`, `#C0C0C0`, `#E0E0E0` |
| Clothing / robes | `#228B22`, `#2E8B57`, `#00CED1`, `#4682B4`, `#6A0DAD` |
| Eye color / glow | `#00FF7F`, `#7FFFD4`, `#40E0D0`, `#98FB98` |

**Distinctive Features:** Pointed ears extending approximately 4cm beyond the human ear position. Slightly larger eyes with a faint luminescent quality in low light. Taller and more slender than humans on average.
**Sprite Notes:** Elf sprites should include a subtle passive glow effect on eyes (animated as a very slow pulse). Magic cast animations should have notably more particle effects than other races.

### Audio Notes
**Voice Archetype:** Measured, melodic, and precise. Sentences tend to be longer and more grammatically formal. Even in battle, Elf dialogue sounds like it is being read from a particularly dramatic text.
**Racial Skill SFX:** A deep earth rumble building for 0.5 seconds, followed by a burst of wooden cracking and vine rustling. Green light pulses from the ground at enemy positions.

---

---

## Race 3: Dwarves

### Lore

Dwarves were, by their own account, made from stone by the First Shaper, and they take this seriously. Every Dwarf city is built underground — not because Dwarves fear sunlight (though they do find it faintly rude) but because stone is honest in ways that the surface world is not. Stone holds the memory of pressure. Stone does not change unless you insist upon it. Stone, in the Dwarven philosophical tradition, is the correct way for things to be.

This does not mean Dwarves are rigid. It means they are *deliberate*. Dwarven engineers spend decades on a design before they cut the first stone. Dwarven warriors train their techniques for years before they use them in the field. Dwarven smiths know that the quality of a weapon is determined long before the final quench — in the choice of ore, in the patience of the forging, in the number of times one is willing to do it again when it isn't right. Their culture prizes mastery above all other values, and a Dwarf who claims expertise they don't possess is considered among the lowest moral category of being.

The Dwarves' relationship with the surface world has always been transactional but not unfriendly. They mine and forge what others cannot; others grow food and manufacture textiles that would take Dwarves years to produce underground. The mutual dependency has kept a rough peace for millennia. When the Covenant began to show fractures, the Dwarf clans sent their finest Stone Sentinels to the surface — not out of idealism, but because the Aetherweft runs through the deep stone as well as the sky, and they have a vested interest in its stability.

### Stat Modifiers

| Stat | Modifier |
|---|---|
| HP | +20 |
| MP | none |
| STR | +20 |
| DEF | +15 |
| MAG | −10 |
| RES | +5 |
| SPD | −15 |
| LCK | none |

> **Design note:** Dwarves are the definitive physical tank. Exceptional survivability and damage output in the physical category, but they act late in the turn order and are poor magic users. Position them in the front row always.

### Growth Rate Modifiers

| Stat | Modifier |
|---|---|
| HP | ×1.2 per level |
| STR | ×1.2 per level |
| DEF | ×1.15 per level |
| MAG | ×0.8 per level |
| SPD | ×0.9 per level |

### Passive Racial Ability — Stone Skin

**Trigger:** Always active.
**Effect:** All incoming physical damage dealt to this character is reduced by 15% (applied after DEF calculation). This character is completely immune to the Stun status effect. Additionally, Bleed stacks on this character are reduced in effectiveness by 50% (a Bleed stack deals half the normal HP loss per turn).
**Notes:** The 15% reduction stacks multiplicatively with DEF-boosting spells and equipment effects. The Stun immunity cannot be removed by any enemy ability. This immunity extends to effects that would impose a "skip turn" mechanic by different names.

### Active Racial Skill — War Cry

**MP Cost:** 18
**Cooldown:** 5 turns
**Targeting:** All party members
**Element:** Non-Elemental
**Effect:** A thunderous battle shout that fills allies with unstoppable fury. All party members (including the Dwarf) gain +20% STR and +10% DEF for 3 turns. Additionally, War Cry immediately removes the Fear status effect from all party members.
**Notes:** Stacks with other STR buffs. Does not stack with itself (refresh only). Excellent opening move to amplify a physical-focused party's damage output significantly. Pairs very well with a Human's Rally for a combined STR+MAG+DEF boost.

### Recommended Classes
Warrior, Knight, Berserker, Smith (class unique to Dwarves in some campaigns)

### Discouraged Classes
Mage, Healer, Summoner (MAG penalty and low SPD make these roles inefficient)

### Unique Narrative Role
Dwarves often serve as the party's "anchor" — the reliable voice of practical wisdom who keeps the group grounded when idealism or emotion threatens to override judgment.

### Visual Design

| Element | Palette |
|---|---|
| Skin tones | `#A0785A`, `#8B6348`, `#7A5230`, `#6B4423` |
| Hair / beard | `#C0C0C0`, `#808080`, `#696969`, `#8B4513`, `#D2691E`, `#2C1810` |
| Armor / clothing | `#8B8680`, `#CD853F`, `#DAA520`, `#8B0000`, `#4A4A4A` |
| Eye colors | `#FF6B35`, `#B8860B`, `#8B4513`, `#5C5C5C` |

**Distinctive Features:** Compact and broad-shouldered; approximately 2/3 the height of a Human but nearly equal in body mass. Prominent beards (traditionally braided and adorned with clan rings for warriors). Thick, calloused hands. Heavy brow ridge.
**Sprite Notes:** Dwarf sprites benefit from heavier shading to emphasize mass. Armor should appear thick and functional. The War Cry animation should show the sprite vibrating slightly and emitting a sound wave effect ring.

### Audio Notes
**Voice Archetype:** Gruff, resonant, economical. Short sentences. Does not waste words. Occasional dry humor delivered completely deadpan.
**Racial Skill SFX:** A deep, resonant bellowing sound (0.8 seconds) followed by a bass thud as the sound wave hits the ground. Allies flash briefly in a warm amber.

---

---

## Race 4: Draconians

### Lore

Draconians do not call themselves the children of dragons — they call themselves the *continuation* of dragons, a distinction they consider critically important. True dragons, the ancient creatures of immense power that shaped Aethoria in the world's first age, did not die. They *transformed*. Over millennia, through processes that Draconian scholars describe as voluntary and that Elf scholars describe as poorly understood, the great dragons altered their forms — becoming smaller, more social, more capable of sustained civilized existence — while retaining the essential qualities that made them what they were: fierce, proud, elemental, and very nearly impossible to humble.

Draconian culture is built around two intersecting values: personal excellence and ancestral honor. Every Draconian is expected to identify the domain in which they are exceptional and to pursue mastery of that domain relentlessly. Failure is acceptable; mediocrity is not. Ancestral honor means that the achievements of one's lineage are both a gift and a burden — a Draconian born into a line of great warriors is expected to achieve something worthy of that line, or to forge an entirely new tradition that surpasses it.

The most politically visible fact about Draconians is their elemental affinity, determined at birth by which aspect of Draconic heritage is dominant in a given bloodline. Fire-lineage Draconians tend toward leadership and direct confrontation. Ice-lineage are strategists and observers. Thunder-lineage are innovators and risk-takers. Earth-lineage are builders and guardians. Dark-lineage are scholars and, often, considered by other Draconians with cautious respect. When the Covenant shattered, every Draconian lineage felt it — the Aetherweft's disruption registered as a physical discomfort in their elemental channels — and the response was immediate: Draconian Dragon Knights began appearing at the fracture points, whether invited or not.

### Stat Modifiers

| Stat | Modifier |
|---|---|
| HP | +10 |
| MP | +5 |
| STR | +15 |
| DEF | +5 |
| MAG | +15 |
| RES | +5 |
| SPD | −5 |
| LCK | none |

> **Design note:** Draconians are the hybrid race. Their balanced offensive bonuses (equal STR and MAG improvement) and moderate defensive bonuses make them the ideal "Battle Mage" or "Dragon Knight" — characters who blend physical and magical approaches in the same build.

### Growth Rate Modifiers

| Stat | Modifier |
|---|---|
| STR | ×1.15 per level |
| MAG | ×1.15 per level |
| HP | ×1.1 per level |

### Passive Racial Ability — Dragon Scales

**Trigger:** Always active; second tier triggers conditionally.
**Effect:** All incoming damage (physical and magical, all elements) dealt to this character is reduced by 5%. When this character's current HP falls below 25% of their maximum HP, this reduction increases to 15%, and additionally their STR and MAG are increased by 20% (Dragon's Fury). Dragon's Fury persists until the character is healed above 25% HP.
**Notes:** The base 5% damage reduction stacks multiplicatively with DEF, RES, and Shell effects. Dragon's Fury does not stack — if the character drops below 25%, is healed above, then drops below again, Dragon's Fury reactivates at the same values. Dragon's Fury is not a buff status and cannot be dispelled.

### Active Racial Skill — Dragon Breath

**MP Cost:** 25
**Cooldown:** 6 turns
**Targeting:** Cone — all enemies (front row takes full damage; back row takes 70% damage)
**Element:** Determined at character creation: Fire / Ice / Thunder / Earth / Dark
**Effect:** The Draconian channels their elemental ancestry, exhaling a cone of concentrated elemental energy. All enemies take damage equal to 150% of the caster's MAG stat in the chosen element. If the chosen element is Fire, targets have a 30% chance to be Burned. If Ice, 30% chance of Slow. If Thunder, 20% chance of Stun. If Earth, 20% chance of applying Weaken (−20% STR/MAG). If Dark, 25% chance of applying Silence.
**Notes:** The element chosen at character creation cannot be changed during a playthrough. Dragon Breath benefits from the Arcane Affinity bonus if the Draconian is in a party with Elves (unusual but powerful combination). The cone targeting hits both rows, distinguishing it from most single-target or pure-AoE skills.

### Recommended Classes
Dragon Knight, Battle Mage, Berserker, Paladin, Spellblade

### Discouraged Classes
Pure Healer (not a natural fit; MAG is high but the identity is offense-oriented)

### Unique Narrative Role
Draconians often carry a personal sense of destiny or lineage obligation that creates compelling tension in ensemble casts. A Draconian party member frequently has the most clearly defined personal honor code, which creates conflict when the party's choices compromise it.

### Visual Design

| Element | Palette |
|---|---|
| Scale colors (Fire lineage) | `#8B0000`, `#DC143C`, `#FF4500`, `#B22222` |
| Scale colors (Ice lineage) | `#00008B`, `#4169E1`, `#00CED1`, `#5F9EA0` |
| Scale colors (Thunder lineage) | `#FFD700`, `#DAA520`, `#B8860B`, `#4B0082` |
| Scale colors (Earth lineage) | `#2F4F4F`, `#006400`, `#556B2F`, `#8B7355` |
| Scale colors (Dark lineage) | `#1A1A2E`, `#2D1B69`, `#4B0082`, `#2F2F2F` |
| Accent colors | `#FFD700`, `#FF4500`, `#00CED1`, `#C0C0C0` |
| Eye colors | `#FF0000`, `#FFD700`, `#00FF00`, `#FF4500`, `#8B0000` |

**Distinctive Features:** Draconian sprites are notably taller than humans. Visible scale texture on skin (especially arms, neck, and back of hands). Small non-functional wings folded at the back (full wing spread only during Dragon Breath animation). Vertical slit pupils. A faint elemental aura that corresponds to their lineage element pulses around them during idle animation.
**Sprite Notes:** The Dragon Breath cast animation should be the most visually impressive of any racial skill — a long wind-up with scales lighting up in sequence from back to front, then a full-screen cone effect in the lineage element's color.

### Audio Notes
**Voice Archetype:** Deep, deliberate, and formal without being cold. Draconians speak as though every sentence has been considered. Occasional growl quality on consonants when emotional.
**Racial Skill SFX:** A deep rumbling inhale (1 second), followed by a massive elemental blast sound in the appropriate element (1.5 seconds). Fire: roaring inferno. Ice: crystalline shattering burst. Thunder: thunderclap and crackle. Earth: stone grinding and impact. Dark: low-frequency void tone with reverb trail.

---

---

## Race 5: Sprites

### Lore

No one is entirely certain how Sprites came to exist. Elf scholars argue they are a natural consequence of the Aetherweft condensing in areas of intense magical concentration — a kind of spontaneous crystallization of magical energy into self-aware form. Dwarven theologians, who tend toward skepticism about magical theories in general, suggest they are simply very small beings who got an unusual amount of magical residue on them at a formative stage. Sprites themselves generally respond to the question of their origin with a laugh, a shrug, and an immediate change of subject.

What is undeniable is what Sprites *are*: beings of near-pure magical energy wearing the thinnest possible film of physical form. Their bodies are small — never taller than a human child — and translucent at the edges, as if the physical world cannot quite commit to making them fully solid. They glow. They always glow. The glow color shifts with emotional state in ways they cannot fully control, which means that Sprites are, paradoxically, among the most honest beings in Aethoria despite their well-earned reputation for misdirection and trickery.

Sprite culture — to the extent it can be called that — is organized around what they call the Dance, a philosophical framework in which all of existence is understood as an ongoing improvised performance and the correct response to any situation is the most interesting possible action. This makes Sprites extraordinary in a crisis (they are constitutionally incapable of freezing) and occasionally maddening in peacetime (they get bored). Their magical power is without parallel — a Sprite Archmage is a force of nature. Their physical resilience is without parallel in the opposite direction — a light breeze can ruin a Sprite's day. They are perfectly aware of this tradeoff and have decided it is worth it.

### Stat Modifiers

| Stat | Modifier |
|---|---|
| HP | −20 |
| MP | +20 |
| STR | −15 |
| DEF | −20 |
| MAG | +30 |
| RES | +10 |
| SPD | +25 |
| LCK | +10 |

> **Design note:** Sprites are the most extreme race in the game — the highest MAG and SPD of any race, the lowest HP and DEF. They require careful positioning (always back row) and ideally a defensive party member who can absorb or redirect incoming attacks. In the hands of a skilled player, a Sprite Mage is the single most damaging character in the game. In the hands of an incautious player, they will die in the first round of every boss fight.

### Growth Rate Modifiers

| Stat | Modifier |
|---|---|
| MAG | ×1.3 per level |
| MP | ×1.2 per level |
| SPD | ×1.2 per level |
| LCK | ×1.15 per level |
| HP | ×0.8 per level |
| DEF | ×0.8 per level |
| STR | ×0.7 per level |

### Passive Racial Ability — Fey Step

**Trigger:** Activates automatically when a physical attack is declared against this character (before damage is calculated).
**Effect:** This character has a 20% base chance to completely evade any incoming physical attack (the attack misses entirely; no damage is dealt). When an evasion occurs, this character immediately recovers MP equal to 5% of their maximum MP. Fey Step does not apply to magical attacks, AoE spells, or guaranteed-hit abilities.
**Notes:** The 20% evasion chance can be increased by LCK-boosting equipment and effects. Each point of LCK above the average (50) increases evasion chance by 0.2%, up to a hard cap of 45% evasion chance. Fey Step triggers visually as a brief flicker where the Sprite's sprite becomes fully translucent before reappearing slightly displaced.

### Active Racial Skill — Phantasm

**MP Cost:** 30
**Cooldown:** 7 turns
**Targeting:** All enemies
**Element:** Non-Elemental (Psychic / Illusory subtype)
**Effect:** The Sprite shatters the perceptual reality of all enemies simultaneously. Each enemy has an 80% chance to receive the Confuse status effect (they attack random targets — ally or enemy — for 3 turns). Additionally, all enemies have their SPD reduced by 30% for 3 turns regardless of whether the Confuse was successfully applied.
**Notes:** The 80% Confuse chance is independent per target — some enemies in a group may resist it while others don't. The SPD reduction is always applied (100% rate). Confuse-immune enemies still receive the SPD reduction. This skill pairs devastatingly with any follow-up AoE damage spell while enemies are confused and attacking each other.

### Recommended Classes
Mage, Time Mage, Illusionist, Summoner, Archmage (advanced class)

### Discouraged Classes
Warrior, Knight, Berserker (the HP and DEF penalties make front-row physical roles essentially nonviable)

### Unique Narrative Role
Sprites are narrative wild cards. They challenge the serious tone of a party with absurdist perspective, but their unique insight into magical phenomena — particularly the Aetherweft — makes them essential to understanding the Covenant. A Sprite party member often delivers the most important magical exposition in the most unexpected way.

### Visual Design

| Element | Palette |
|---|---|
| Body glow (base) | `#E0E0FF`, `#FFE4E1`, `#E0FFE0`, `#FFFDE0` |
| Body glow (agitated) | `#FF6B9D`, `#FF9966`, `#FFFF66` |
| Body glow (calm) | `#B0C4DE`, `#B0E0E6`, `#E6E6FA` |
| Wing colors | `#FF69B4`, `#00BFFF`, `#98FB98`, `#DDA0DD`, `#FFD700` |
| Particle effects | `#FFFFFF`, `#FFD700`, `#FF1493`, `#00FFFF`, `#ADFF2F` |
| Eye colors | `#FFFFFF` (full white iris), `#FFD700`, `#00FFFF` |

**Distinctive Features:** Sprites are 50–60% the height of an average Human sprite. Their body edges are semi-transparent and always emit a soft glow that pulses slowly. They have four wings (similar to dragonfly wings) that are always visible and always slowly in motion — Sprites hover rather than walk, meaning their movement animations show them floating slightly above ground level at all times. No visible hair; instead, a persistent aura of small floating light particles surrounds their head.
**Sprite Notes:** Sprite sprites require special handling: they should always be rendered with additive blending on the glow effect layer. The Phantasm cast animation should involve the entire screen briefly desaturating, with fracture lines spreading from the Sprite's position, before a burst of iridescent color.

### Audio Notes
**Voice Archetype:** High-pitched and musical, with speech that moves faster than seems entirely natural. Laughs frequently. Can shift from delighted to ominous in a single sentence without apparent effort.
**Racial Skill SFX:** A rising, glitchy tonal sweep (1.5 seconds) — like a music box being played at the wrong speed — followed by a sharp, dissonant chord as all enemy perception breaks. The Confuse effect landing on each enemy is marked by a small sound of breaking glass.

---

---

## Race Comparison Table

| Race | HP Mod | MP Mod | STR Mod | DEF Mod | MAG Mod | RES Mod | SPD Mod | LCK Mod | Passive Ability Summary | Active Skill | Active MP | Difficulty |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Human | +5% all | +5% all | +5% all | +5% all | +5% all | +5% all | +5% all | +5% all | +10% XP; +1 SP/level | Rally (party STR/MAG +10%) | 15 | ⭐ Beginner |
| Elf | 0 | +10 | −10 | −10 | +20 | +10 | +15 | +5 | MP costs −10%; spell dmg +5% per Elf | Nature's Grasp (AoE root + Earth DoT) | 20 | ⭐⭐⭐ Advanced |
| Dwarf | +20 | 0 | +20 | +15 | −10 | +5 | −15 | 0 | −15% phys dmg; Stun immune | War Cry (party STR+20%, DEF+10%) | 18 | ⭐⭐ Intermediate |
| Draconian | +10 | +5 | +15 | +5 | +15 | +5 | −5 | 0 | −5% all dmg; Dragon's Fury at HP<25% | Dragon Breath (150% MAG cone, element choice) | 25 | ⭐⭐⭐ Advanced |
| Sprite | −20 | +20 | −15 | −20 | +30 | +10 | +25 | +10 | 20% phys evade; recover 5% MP on evade | Phantasm (AoE Confuse + SPD−30%) | 30 | ⭐⭐⭐⭐ Expert |

### Elemental Affinity by Race

| Race | Primary Element Affinity | Secondary Affinity | Notable Weakness |
|---|---|---|---|
| Human | None (neutral) | None | None |
| Elf | Earth / Nature | Light | Fire (historical enmity) |
| Dwarf | Earth | Non-Elemental | Thunder (conductive armor) |
| Draconian | Varies by lineage | Secondary lineage element | Varies (see Dragon Breath notes) |
| Sprite | Light / Arcane | All elements (minor) | Dark |

### Class Compatibility Matrix

| Race \ Class | Warrior | Mage | Ranger | Healer | Knight | Bard | Berserker | Druid | Summoner |
|---|---|---|---|---|---|---|---|---|---|
| Human | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Elf | ⚠️ | ✅✅ | ✅✅ | ✅ | ⚠️ | ✅ | ❌ | ✅✅ | ✅✅ |
| Dwarf | ✅✅ | ⚠️ | ✅ | ⚠️ | ✅✅ | ⚠️ | ✅✅ | ⚠️ | ⚠️ |
| Draconian | ✅✅ | ✅✅ | ✅ | ⚠️ | ✅✅ | ⚠️ | ✅✅ | ⚠️ | ✅ |
| Sprite | ❌ | ✅✅ | ⚠️ | ✅ | ❌ | ✅ | ❌ | ✅ | ✅✅ |

> ✅✅ = Excellent synergy | ✅ = Good fit | ⚠️ = Possible but suboptimal | ❌ = Not recommended
