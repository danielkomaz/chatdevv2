# Phase 5: Sound Design

## Overview

This phase defines all music and sound effects required for the game. The **Sound Designer** produces every audio asset following the technical specifications in this document. All assets must be formatted, named, and delivered for direct use in Godot 4 before integration begins.

---

## Objective

Produce a complete audio library including:
- All background music tracks with defined mood, instrumentation, and loop points
- All sound effects with trigger mappings to Godot nodes
- Correct file formats and loop metadata for seamless playback
- Verified volume levels and bus routing

---

## 1. Music Track List

Each track is documented with mood, key, tempo (BPM), instrumentation, approximate length, and loop behavior. All music must loop unless marked otherwise.

---

### Track 01 — Title Screen Theme

| Field | Value |
|---|---|
| **Filename** | `bgm_title_screen.ogg` |
| **Mood** | Epic, mysterious, hopeful — the world is broken but worth saving |
| **Key** | D minor |
| **Tempo** | 72 BPM |
| **Length** | ~90 seconds |
| **Loop** | Yes — loop point at 8 seconds (after non-looping intro) |
| **Instrumentation** | Orchestral strings (lush, slow), solo piano melody, distant choir, subtle percussion, fading in over 4 bars |
| **Structure** | 8s intro → 40s main theme A → 22s theme B (choir rises) → 20s return to A |
| **Notes** | Should feel like looking at a vast broken world from above. Volume builds gradually. |

---

### Track 02 — World Map Theme

| Field | Value |
|---|---|
| **Filename** | `bgm_world_map.ogg` |
| **Mood** | Adventurous, expansive, forward-moving |
| **Key** | G major |
| **Tempo** | 100 BPM |
| **Length** | ~120 seconds |
| **Loop** | Yes — seamless full-loop |
| **Instrumentation** | Acoustic guitar lead, orchestral brass swells, light percussion (snare brushes), flute countermelody |
| **Structure** | 4-bar intro → 32-bar main theme → 16-bar secondary (more strings) → repeat from main |
| **Notes** | Upbeat but not frantic. Should make traversal feel purposeful and exciting. |

---

### Track 03 — Town Theme (Peaceful)

| Field | Value |
|---|---|
| **Filename** | `bgm_town_peaceful.ogg` |
| **Mood** | Warm, safe, relaxed — the feeling of being somewhere civilized |
| **Key** | C major |
| **Tempo** | 80 BPM |
| **Length** | ~100 seconds |
| **Loop** | Yes — seamless full-loop |
| **Instrumentation** | Acoustic guitar, light piano, soft woodwinds (oboe/flute), gentle percussion |
| **Structure** | Verse (A) → Bridge (B, slightly livelier) → Return to A |
| **Notes** | Used for smaller villages, rest areas. No dramatic swells. Cozy and unpretentious. |

---

### Track 04 — Town Theme (Bustling)

| Field | Value |
|---|---|
| **Filename** | `bgm_town_bustling.ogg` |
| **Mood** | Lively, mercantile, slightly chaotic — a city that never stops |
| **Key** | F major |
| **Tempo** | 116 BPM |
| **Length** | ~90 seconds |
| **Loop** | Yes — seamless full-loop |
| **Instrumentation** | Lute/harpsichord melody, upright bass, hand drums, accordion, crowd-noise undertone |
| **Structure** | Intro jingle (4 bars) → Main theme (dance-like) → Countermelody → Repeat |
| **Notes** | Used for major trade cities (Velmoor etc.). Energetic but not aggressive. |

---

### Track 05 — Dungeon Theme (Tense)

| Field | Value |
|---|---|
| **Filename** | `bgm_dungeon_tense.ogg` |
| **Mood** | Alert, tense, danger lurking — the party is on edge |
| **Key** | E minor |
| **Tempo** | 88 BPM |
| **Length** | ~100 seconds |
| **Loop** | Yes — seamless full-loop |
| **Instrumentation** | Low strings ostinato, sparse piano, distant percussive taps, occasional brass stabs |
| **Structure** | Continuous tension loop with two variation sections |
| **Notes** | No clear melody — primarily atmospheric. Should make players feel watched. |

---

### Track 06 — Dungeon Theme (Dark)

| Field | Value |
|---|---|
| **Filename** | `bgm_dungeon_dark.ogg` |
| **Mood** | Dread, oppressive, ancient evil — deep within corrupted places |
| **Key** | B minor (with chromatic alterations) |
| **Tempo** | 60 BPM |
| **Length** | ~110 seconds |
| **Loop** | Yes — seamless full-loop |
| **Instrumentation** | Deep synth drones, dark choir (wordless), cello, dissonant pipe organ fragments, slow metallic percussion |
| **Structure** | Evolving ambient loop with subtle melodic motif emerging and fading |
| **Notes** | Used in Voidweaver territories and final act dungeons. Should feel suffocating. |

---

### Track 07 — Battle Theme (Normal)

| Field | Value |
|---|---|
| **Filename** | `bgm_battle_normal.ogg` |
| **Mood** | Urgent, driving, competent — a fight you intend to win |
| **Key** | A minor |
| **Tempo** | 148 BPM |
| **Length** | ~90 seconds |
| **Loop** | Yes — loop after intro (intro plays once on battle start) |
| **Instrumentation** | Electric guitar riff (chiptune-adjacent), hard-hitting drums, synth bass, brass accents |
| **Structure** | 8-bar intro → main battle loop (A) → intensity section (B, more brass) → loop back to A |
| **Notes** | Should energize without being fatiguing over many battles. Memorable main riff essential. |

---

### Track 08 — Battle Theme (Boss)

| Field | Value |
|---|---|
| **Filename** | `bgm_battle_boss.ogg` |
| **Mood** | Desperate, epic, relentless — this matters and you know it |
| **Key** | D minor |
| **Tempo** | 160 BPM |
| **Length** | ~120 seconds |
| **Loop** | Yes — loop after intro |
| **Instrumentation** | Full orchestra with choir, driving drums, electric guitar lead over orchestral backing, intense brass section |
| **Structure** | Dramatic 12-bar intro → Main battle section (A) → Epic choir swell (B) → Phase 2 variation → Loop A |
| **Notes** | Must feel meaningfully different from normal battle. The choir is critical. Phase 2 variation triggered by code at 50% boss HP (cross-fade). |

---

### Track 09 — Victory Fanfare (Short)

| Field | Value |
|---|---|
| **Filename** | `jingle_victory_short.ogg` |
| **Mood** | Triumphant, satisfying, quick |
| **Key** | G major |
| **Tempo** | 120 BPM |
| **Length** | ~5 seconds |
| **Loop** | No (one-shot) |
| **Instrumentation** | Brass fanfare, snare hit, cymbal crash |
| **Notes** | Plays after normal battles. Short enough not to feel tedious after many battles. |

---

### Track 10 — Victory Theme (Full)

| Field | Value |
|---|---|
| **Filename** | `jingle_victory_full.ogg` |
| **Mood** | Celebratory, earned, heroic |
| **Key** | G major |
| **Tempo** | 120 BPM |
| **Length** | ~18 seconds |
| **Loop** | No (one-shot) |
| **Instrumentation** | Full brass, strings, triumphant choir, drums, bells |
| **Notes** | Plays after boss victories and major story milestones. Party victory animations play during this. |

---

### Track 11 — Game Over

| Field | Value |
|---|---|
| **Filename** | `jingle_game_over.ogg` |
| **Mood** | Somber, failing, but not final — the world continues |
| **Key** | D minor |
| **Tempo** | 60 BPM |
| **Length** | ~12 seconds |
| **Loop** | No (one-shot) |
| **Instrumentation** | Slow piano descending motif, distant strings fading out |
| **Notes** | Should not feel punishing or mocking. Sad but dignified. |

---

### Track 12 — Final Boss Theme

| Field | Value |
|---|---|
| **Filename** | `bgm_final_boss.ogg` |
| **Mood** | World-ending urgency, tragic grandeur, everything on the line |
| **Key** | C# minor |
| **Tempo** | 168 BPM |
| **Length** | ~140 seconds |
| **Loop** | Yes — seamless full-loop after 16-bar intro |
| **Instrumentation** | Full orchestra, massive choir (Latin text, custom lyrics tied to world lore), heavy drums, electric guitar, pipe organ |
| **Structure** | 16-bar orchestral intro → Choir + rhythm section main theme → Bridge (quieter, piano motif from Track 01 references) → Climax → Loop |
| **Notes** | Must reference the Title Screen Theme melodically. Players should feel the full weight of the journey. |

---

### Track 13 — Ending Theme

| Field | Value |
|---|---|
| **Filename** | `bgm_ending.ogg` |
| **Mood** | Bittersweet resolution, sacrifice honored, quiet hope |
| **Key** | D major (relative of D minor from title — same key, resolved) |
| **Tempo** | 76 BPM |
| **Length** | ~180 seconds |
| **Loop** | No (plays through credits, fades at end) |
| **Instrumentation** | Piano solo opening, strings join, choir (wordless humming), acoustic guitar counter-melody, full ensemble finale |
| **Structure** | Piano solo (40s) → Strings join (40s) → Choir enters (40s) → Full ensemble (40s) → Fade (20s) |
| **Notes** | Should feel like a journey completed. The major key resolution is intentional — this is the same melody as the title, now in major. |

---

### Track 14 — Secret Area Theme

| Field | Value |
|---|---|
| **Filename** | `bgm_secret_area.ogg` |
| **Mood** | Otherworldly, curious, ancient — you found something most people don't |
| **Key** | F# minor |
| **Tempo** | 82 BPM |
| **Length** | ~80 seconds |
| **Loop** | Yes — seamless full-loop |
| **Instrumentation** | Music box lead, reverse-reverb pads, sparse harp arpeggios, distant wind chimes, unusual percussion |
| **Notes** | Should feel like you've stepped outside of normal reality. Playful but strange. |

---

## 2. Sound Effects Library

### 2.1 UI Sounds

| SFX Name | Filename | Godot Node Name | Trigger |
|---|---|---|---|
| Cursor Move | `sfx_ui_cursor_move.wav` | `SFXCursorMove` | Menu item hover/scroll |
| Confirm | `sfx_ui_confirm.wav` | `SFXConfirm` | Button press / dialogue advance |
| Cancel | `sfx_ui_cancel.wav` | `SFXCancel` | Back button / escape menu |
| Menu Open | `sfx_ui_menu_open.wav` | `SFXMenuOpen` | Any menu panel slides/appears |
| Menu Close | `sfx_ui_menu_close.wav` | `SFXMenuClose` | Any menu panel dismissed |

**Specs:** Short (< 200ms), clean click/chime aesthetic. No reverb on UI sounds.

---

### 2.2 Battle Sounds

| SFX Name | Filename | Godot Node Name | Trigger |
|---|---|---|---|
| Sword Hit | `sfx_battle_sword_hit.wav` | `SFXSwordHit` | Physical attack lands |
| Miss Swoosh | `sfx_battle_miss.wav` | `SFXMiss` | Attack misses target |
| Critical Hit | `sfx_battle_critical.wav` | `SFXCritical` | Critical hit lands |
| Magic Cast — Fire | `sfx_magic_cast_fire.wav` | `SFXMagicCastFire` | Fire spell/skill cast begins |
| Magic Cast — Ice | `sfx_magic_cast_ice.wav` | `SFXMagicCastIce` | Ice spell cast begins |
| Magic Cast — Lightning | `sfx_magic_cast_lightning.wav` | `SFXMagicCastLightning` | Lightning spell cast begins |
| Magic Cast — Earth | `sfx_magic_cast_earth.wav` | `SFXMagicCastEarth` | Earth spell cast begins |
| Magic Cast — Holy | `sfx_magic_cast_holy.wav` | `SFXMagicCastHoly` | Holy spell cast begins |
| Magic Cast — Dark | `sfx_magic_cast_dark.wav` | `SFXMagicCastDark` | Dark spell cast begins |
| Magic Cast — Time | `sfx_magic_cast_time.wav` | `SFXMagicCastTime` | Time spell cast begins |
| Skill Use (Generic) | `sfx_battle_skill_generic.wav` | `SFXSkillGeneric` | Non-elemental skill activated |
| Item Use | `sfx_battle_item_use.wav` | `SFXItemUse` | Consumable used in battle |
| Level Up | `sfx_level_up.wav` | `SFXLevelUp` | Character levels up |
| Status Applied | `sfx_status_applied.wav` | `SFXStatusApplied` | Any status effect applied |
| Status Cure | `sfx_status_cured.wav` | `SFXStatusCured` | Status effect removed |
| Flee Success | `sfx_flee_success.wav` | `SFXFleeSuccess` | Party successfully flees |
| Flee Fail | `sfx_flee_fail.wav` | `SFXFleeFail` | Flee attempt fails |
| Enemy Defeated | `sfx_enemy_defeated.wav` | `SFXEnemyDefeated` | Enemy HP reaches 0 |

---

### 2.3 World/Environment Sounds

| SFX Name | Filename | Godot Node Name | Trigger |
|---|---|---|---|
| Footstep — Grass | `sfx_step_grass.wav` | `SFXStepGrass` | Player step on grass tile |
| Footstep — Stone | `sfx_step_stone.wav` | `SFXStepStone` | Player step on stone/dungeon tile |
| Footstep — Wood | `sfx_step_wood.wav` | `SFXStepWood` | Player step on wooden floor tile |
| Footstep — Sand | `sfx_step_sand.wav` | `SFXStepSand` | Player step on desert tile |
| Footstep — Snow | `sfx_step_snow.wav` | `SFXStepSnow` | Player step on snow tile |
| Door Open | `sfx_door_open.wav` | `SFXDoorOpen` | Door interaction activated |
| Door Close | `sfx_door_close.wav` | `SFXDoorClose` | Door closes behind player |
| Chest Open | `sfx_chest_open.wav` | `SFXChestOpen` | Treasure chest opened |
| Chest Empty | `sfx_chest_empty.wav` | `SFXChestEmpty` | Already-opened chest interacted with |
| Teleport | `sfx_teleport.wav` | `SFXTeleport` | Warp tile or teleport spell activates |
| Save Crystal | `sfx_save_crystal.wav` | `SFXSaveCrystal` | Player interacts with save point |
| Item Pickup | `sfx_item_pickup.wav` | `SFXItemPickup` | Item collected from floor/overworld |

---

### 2.4 Character Sounds

| SFX Name | Filename | Godot Node Name | Trigger |
|---|---|---|---|
| Character Hurt (Generic) | `sfx_char_hurt.wav` | `SFXCharHurt` | Party member takes damage |
| Character Death | `sfx_char_death.wav` | `SFXCharDeath` | Party member reaches 0 HP |
| Character Victory Shout | `sfx_char_victory.wav` | `SFXCharVictory` | Post-battle victory animation plays |
| Enemy Hurt (Generic) | `sfx_enemy_hurt.wav` | `SFXEnemyHurt` | Enemy takes any damage |
| Boss Roar | `sfx_boss_roar.wav` | `SFXBossRoar` | Boss battle begins or phase changes |

---

## 3. Godot 4 Audio Implementation Notes

### 3.1 AudioStreamPlayer vs. AudioStreamPlayer2D

| Node Type | When to Use |
|---|---|
| `AudioStreamPlayer` | UI sounds, BGM, battle sounds, global SFX with no positional component |
| `AudioStreamPlayer2D` | Footsteps, door sounds, ambient world sounds that need to fade with distance |

All `AudioStreamPlayer2D` nodes should have:
- `max_distance` set to 240 pixels (15 tiles × 16px)
- `attenuation` set to 1.0 (linear falloff)

### 3.2 BGM Streaming

BGM tracks must be imported as `AudioStreamOggVorbis`. Loop settings are embedded in the OGG file metadata:
- Set `loop` to `true` in Godot import settings
- Set `loop_offset` in seconds to match the documented loop point (e.g., 8 seconds for Track 01)

### 3.3 SFX Pooling

AudioManager maintains a pool of 8 `AudioStreamPlayer` nodes for SFX. The `play_sfx(sfx_name)` method selects the first idle player. If all 8 are playing, the oldest is interrupted. This prevents audio channel exhaustion during busy battle scenes.

### 3.4 Audio Bus Layout

```
Master Bus (Volume: 0 dB)
├── BGM Bus (default -3 dB, user-adjustable)
│   └── Effect: Reverb (wet 15%, room size 0.4) — subtle ambiance
├── SFX Bus (default 0 dB, user-adjustable)
│   └── Effect: Limiter (ceiling -1 dB) — prevents clipping on stacked SFX
└── UI Bus (default -2 dB, user-adjustable)
    └── No effects
```

All `AudioStreamPlayer` nodes for BGM must route to the BGM Bus. SFX players route to SFX Bus. UI sound players route to UI Bus.

Volume settings are saved via SaveManager as normalized floats (0.0–1.0) and applied to bus dB using:
```gdscript
AudioServer.set_bus_volume_db(bus_index, linear_to_db(volume_float))
```

---

## 4. Format Specifications

| Type | Format | Bit Depth | Sample Rate | Channels | Looping |
|---|---|---|---|---|---|
| **Music (BGM)** | OGG Vorbis | N/A | 44100 Hz | Stereo | Yes (loop metadata embedded) |
| **Sound Effects** | WAV | 16-bit PCM | 44100 Hz | Mono (preferred) or Stereo | No |
| **Jingles** | OGG Vorbis | N/A | 44100 Hz | Stereo | No |

**OGG Quality:** Target quality setting 6 (range 0–10). Do not use quality below 5 for music.

**WAV normalization:** All SFX must be normalized to -6 dBFS peak. No SFX should clip above -1 dBFS.

**File naming:** All lowercase, underscores only:
```
bgm_title_screen.ogg
sfx_ui_confirm.wav
jingle_victory_short.ogg
```

**Directory structure in Godot project:**
```
res://assets/audio/bgm/        — all OGG music tracks
res://assets/audio/sfx/        — all WAV sound effects
res://assets/audio/jingles/    — all OGG jingles
```

---

## 5. Volume and Bus Mixing Guidelines

### Master Mix Targets

| Bus | Target Level | Notes |
|---|---|---|
| BGM | -12 dBFS RMS | Music should not overpower dialogue or UI |
| SFX | -8 dBFS peak | Combat sounds need presence |
| UI | -10 dBFS peak | Subtle; not distracting |

### Relative Balance

- During dialogue: BGM ducked to 40% volume (fade to 40% over 0.5s, return to 100% after dialogue ends)
- During victory fanfare: BGM fades out; jingle plays at full level; BGM fades back in after jingle completes
- During battle: BGM bus active; SFX bus active; UI bus active at reduced level

### Frequency Guidance

- BGM: full range 20 Hz–20 kHz; sub-bass (below 60 Hz) kept subtle to avoid rumble on laptop speakers
- SFX: UI sounds should emphasize 1 kHz–4 kHz range (cuts through mix clearly)
- SFX impact sounds (sword, magic): keep transient punch in 200 Hz–600 Hz range

---

## 6. Completion Checklist

- [ ] All 14 music tracks produced and exported as OGG Vorbis
- [ ] All track loop points verified and embedded in OGG metadata
- [ ] Track 07 (Battle Normal) has distinct intro that plays once before loop
- [ ] Track 08 (Boss Battle) has a Phase 2 variation segment documented and delivered
- [ ] Track 12 (Final Boss) references Track 01 (Title) melodically
- [ ] Track 13 (Ending) resolves Title theme in major key
- [ ] All 5 UI sound effects produced (< 200ms, no reverb)
- [ ] All 18 battle sound effects produced
- [ ] All 12 world/environment sound effects produced
- [ ] All 5 character sound effects produced
- [ ] All WAV files normalized to -6 dBFS peak
- [ ] All OGG files encoded at quality setting 6 or above
- [ ] All files named according to naming convention
- [ ] All files organized in correct directory structure
- [ ] Godot AudioManager configured with 4 audio buses
- [ ] BGM bus uses AudioStreamOggVorbis with loop settings
- [ ] SFX pool of 8 AudioStreamPlayer nodes implemented in AudioManager
- [ ] Volume settings persist via SaveManager
- [ ] BGM ducking during dialogue verified in integration test
- [ ] Victory jingle transition (BGM out → jingle → BGM in) verified
- [ ] Sound Designer formal sign-off recorded (name + date)

**Gate Signed Off By:** _________________________ **Date:** _____________

---

*Proceed to Phase 6: Testing & QA only after all gate items are checked.*
