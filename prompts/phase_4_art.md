# Phase 4: Art Production

## Overview

This phase defines all visual asset requirements for the game. The **Game Artist** produces every sprite, tile, UI element, and animation following the technical specifications and style guide in this document. All assets must meet the delivery format standards before being integrated into Godot 4.

---

## Objective

Produce a complete set of pixel art assets that:
- Match the established art style resolution and palette rules
- Cover every required asset category with no gaps
- Are named, organized, and formatted correctly for Godot 4 import
- Pass the quality gate before integration into Phase 3 scenes

---

## 1. Art Style Guide

### 1.1 Resolution Standards

| Context | Native Resolution | Display Resolution | Notes |
|---|---|---|---|
| Game world | 320×180 pixels | 1280×720 pixels | 4× integer scaling |
| Pixel art unit | 1 native pixel | 4×4 display pixels | No sub-pixel anti-aliasing |
| UI layer | 1280×720 | 1280×720 | Drawn at display resolution, not scaled |

**Rendering Rules:**
- All sprites must be rendered with **Nearest Neighbor** filtering only. No bilinear or trilinear filtering.
- Camera zoom must be integer (1×, 2×, 4×). No fractional zoom.
- All pixel art assets are created at native resolution and scaled up by Godot.

### 1.2 Tile Sizes

| Use Case | Tile Size (native pixels) | Notes |
|---|---|---|
| World map tiles | 16×16 | Overworld terrain: grass, forest, mountain, water, desert, snow |
| Dungeon tiles | 16×16 | Walls, floors, doors, traps, chests — 4-directional wall variants |
| Town tiles | 16×16 | Buildings, interiors, roads, decoration tiles |
| Battle sprites | 32×32 | Per character/enemy sprite sheet bounding box (content may vary) |
| UI portraits | 48×48 | Used in dialogue box and character status panels |
| Large portraits | 96×96 | Full character portrait for character select and story cutscenes |
| Battle backgrounds | 320×180 | Full native resolution; each terrain type needs one |
| Status icons | 16×16 | One icon per status effect (11 total) |
| Item icons | 16×16 | One icon per item category minimum |

---

## 2. Color Palette Rules

### 2.1 Per-Sprite Limits

- Maximum **16 colors** per sprite sheet (counting all animation frames as one sheet)
- This includes all shades used for shading, outlines, and highlights
- Transparency (alpha = 0) does not count as a color
- Semi-transparency (alpha > 0, alpha < 255) is prohibited — all pixels are either fully opaque or fully transparent

### 2.2 Consistent Palette Per Race

Each playable race has a **master palette** (defined in Section 8). All character sprites belonging to a race must draw from that race's palette without substitution. This ensures visual coherence when characters of the same race appear together.

NPC characters not affiliated with a specific race use a **neutral NPalette** (8 reserved colors: 2 skin tones, 2 cloth neutrals, 2 earth tones, black, off-white).

### 2.3 UI Palette

The UI uses its own palette, separate from sprite palettes:
- Background dark: `#1a1c2c`
- Background mid: `#29366f`
- Highlight: `#f4f4f4`
- HP bar fill: `#2ce87a`
- HP bar low: `#e83b3b`
- MP bar fill: `#3b79e8`
- XP bar fill: `#f7e26b`
- Border: `#566c86`
- Selected: `#f5a623`
- Text primary: `#f4f4f4`
- Text secondary: `#a8b5c2`

---

## 3. Required Assets List

### 3.1 Character Sprites

Each playable character and major NPC requires a **battle sprite sheet** at 32×32 native pixels per frame. All animations must be on a single horizontal sprite sheet with consistent frame spacing.

#### Animation Set Per Character

| Animation | Frame Count | FPS | Notes |
|---|---|---|---|
| **Idle** | 4 frames | 8 fps | Subtle breathing/bob loop |
| **Walk** | 8 frames | 12 fps | Used on world map and in towns |
| **Run** | 6 frames | 16 fps | Used when Haste is active |
| **Attack** | 4 frames | 12 fps | Physical attack swing |
| **Hurt** | 2 frames | 10 fps | Hit flash + recoil (hold last frame 0.2s) |
| **Death** | 6 frames | 8 fps | Falls/fades; hold last frame |
| **Victory** | 4 frames | 8 fps | Post-battle celebration pose loop |

**Naming convention for frames:**
```
[character_id]_[animation_name]_[frame_number_zero_padded_2digits].png
```

**Examples:**
```
kael_idle_00.png
kael_idle_01.png
kael_idle_02.png
kael_idle_03.png
kael_attack_00.png
```

**Alternatively (preferred for Godot SpriteFrames):** A single horizontal sprite sheet per character:
```
kael_sheet.png  (contains all animations left-to-right, top-to-bottom)
```

---

### 3.2 Enemy Sprites

Each enemy requires: idle (4 frames), hurt (2 frames), death (4 frames), and one unique attack animation (3–6 frames). Boss enemies also require a phase-transition animation (6–8 frames).

Enemy sprite sheets follow the same naming convention:
```
[enemy_id]_sheet.png
```

Minimum enemy sprites required:
- 3 grunt types per dungeon tier (15 total for 5 tiers)
- 1 boss sprite per major story dungeon (minimum 3 bosses for Phase 1 story content)
- Elite variants of grunts (reskins acceptable for Tier 1–2, unique for Tier 3+)

---

### 3.3 Tileset Specifications

#### World Tileset (`world_tileset.png`)

- 16×16 per tile, organized in a 16-tile-wide sheet
- Required tile types:

| Category | Tiles Required |
|---|---|
| Terrain base | Grass (3 variants), Forest, Mountain, Water, Desert, Snow, Volcanic, Swamp |
| Terrain features | Cliff edges (8 directional), Beach transitions, Forest edge tiles |
| Props | Trees (small/large), Rocks, Flowers, Ruins |
| Roads | Path (8 directional + crossroads) |
| Transitions | Auto-tile connections for all terrain-to-terrain edges |

#### Dungeon Tileset (`dungeon_tileset.png`)

- 16×16 per tile
- Required tile types:

| Category | Tiles Required |
|---|---|
| Walls | Stone wall (top/bottom/left/right/corner variations — 16 directional variants) |
| Floors | Stone floor (3 variants), Cracked, Wet, Ornate |
| Doors | Door (closed/open, horizontal/vertical) |
| Hazards | Spikes (active/inactive), Pressure plate, Lava pool |
| Decorations | Pillars, Torches (animated 4 frames), Wall sconces, Cracks |
| Interactables | Chest (closed/open), Lever (up/down), Switch |

#### Town Tileset (`town_tileset.png`)

- 16×16 per tile
- Required tile types:

| Category | Tiles Required |
|---|---|
| Ground | Cobblestone, Dirt path, Grass, Town square tile |
| Buildings | Building walls (exterior), Windows, Rooftops, Chimneys |
| Interiors | Wood floor, Stone floor, Rugs, Fireplaces, Shelves |
| Props | Barrels, Crates, Market stalls, Benches, Signs |
| Decorations | Flowers (potted/wild), Fences, Lampposts, Wells |

---

### 3.4 UI Elements

All UI elements are produced at display resolution (1280×720 pixel coordinates) but must remain pixel-art-consistent in style.

#### HP/MP/XP Bars

| Element | Size | Notes |
|---|---|---|
| HP bar frame | 80×10 px | Full outer frame at 1280×720 coords |
| HP bar fill | 76×6 px | Inner fill, colors from UI palette |
| MP bar frame | 60×8 px | Slightly narrower |
| MP bar fill | 56×4 px | Blue fill |
| XP bar frame | 200×6 px | Used in status screen |
| Boss HP bar | 400×14 px | Wide bar for boss encounter, centered |

#### Menu Panels

| Element | Size | Notes |
|---|---|---|
| Action menu panel | 120×120 px | 6 action buttons (Attack/Skill/Magic/Item/Defend/Flee) |
| Dialogue box | 960×120 px | Bottom-aligned, full-width minus margins |
| Inventory panel | 640×400 px | Left = item list, right = preview |
| Status panel | 320×200 px | Per character in pause menu |
| Target selector arrow | 12×12 px | Animated 4 frames, blink |

#### Icons

| Icon Set | Count | Size |
|---|---|---|
| Status effect icons | 11 | 16×16 each (one per status in GDD) |
| Element icons | 8 | 16×16 each (Fire/Ice/Lightning/Earth/Holy/Dark/Time/None) |
| Item category icons | 8 | 16×16 each (Consumable/Weapon/Armor/Accessory/Key/Shield/Helmet/Boots) |
| Menu cursor | 1 | 8×8, animated 2 frames |
| Formation icons | 4 | 32×32 each |
| Class icons | 4+ | 16×16 each (one per class) |

---

### 3.5 Spell Effects (Animated)

Each elemental spell school requires a hit effect animation and a cast animation. All animations play at 320×180 native resolution (or a sub-region of it).

| Element | Cast Animation | Hit Animation | Frames | FPS |
|---|---|---|---|---|
| **Fire** | Flame spiral rising from caster | Explosion burst with embers | 8 / 6 | 12 |
| **Ice** | Frost crystals forming at caster hands | Ice shard shatter on contact | 6 / 8 | 10 |
| **Lightning** | Arc from caster to sky | Lightning bolt strike | 4 / 5 | 16 |
| **Earth** | Ground cracking at caster feet | Rock spires erupting | 8 / 8 | 10 |
| **Holy** | Radiant glow emanating from caster | Cross-shaped light burst | 6 / 6 | 12 |
| **Dark** | Shadow tendrils from floor | Dark void impact circle | 8 / 6 | 10 |
| **Time** | Clock face ghosting over caster | Hourglass distortion effect | 6 / 4 | 12 |
| **Physical** | Weapon trail motion blur | Impact dust cloud | 3 / 4 | 16 |

Each animation is a PNG sprite sheet, horizontal layout:
```
effect_fire_cast.png
effect_fire_hit.png
effect_ice_cast.png
[etc.]
```

---

### 3.6 Battle Backgrounds

One unique background per terrain type. Each background is a single layered image: far layer (parallax 0.2×), mid layer (parallax 0.5×), near layer (parallax 1.0×).

| Terrain Type | Background Theme |
|---|---|
| Plains | Rolling hills, afternoon sky, distant windmills |
| Forest | Dense tree trunks, dappled light, undergrowth |
| Dungeon (stone) | Stone corridor, torchlight, shadow |
| Mountain | Rocky plateau, volcanic peaks, ash sky |
| Town (indoor) | Tavern/shop interior, wooden beams |
| Snow | Snowfield, blizzard haze, ice formations |
| Desert | Sand dunes, heat shimmer, ruins in distance |
| Final Boss | Shattered god-forge interior, void rift |

Each background: `bg_[terrain_type]_far.png`, `bg_[terrain_type]_mid.png`, `bg_[terrain_type]_near.png`

---

## 4. Animation Naming Conventions

All animation names in Godot's `SpriteFrames` resource must follow this exact convention:

```
[character_or_enemy_id]_[animation_name]
```

Standard animation names (use these exact strings in SpriteFrames):
- `idle`
- `walk`
- `run`
- `attack`
- `hurt`
- `death`
- `victory`
- `cast` (for magic-users)
- `phase_change` (bosses only)

File naming:
```
[character_id]_sheet.png   — the raw sprite sheet PNG
```

Tileset PNG files:
```
world_tileset.png
dungeon_tileset.png
town_tileset.png
```

UI files stored in `res://assets/ui/[category]/[element_name].png`

---

## 5. Art Pipeline

All assets progress through these stages in order:

### Stage 1: Sketch
- Rough pencil or digital sketch establishing silhouette, proportions, pose
- Submit to Game Director for silhouette approval before pixel work begins
- Silhouette must read clearly at 32×32 scale

### Stage 2: Pixel Linework
- Block out at native resolution (32×32 for characters, 16×16 for tiles)
- Black or darkest-palette-color outline, 1px thick
- No anti-aliasing at this stage

### Stage 3: Color Blocking
- Fill in flat colors using the race/category master palette
- Verify color count does not exceed 16 per sheet
- Submit palette swatch alongside sprite for review

### Stage 4: Shading
- Add shading using darker palette colors (2–3 shade levels maximum)
- Add highlights using lightest palette color (1 highlight level maximum)
- Consistent light source: upper-left at 45° for all sprites

### Stage 5: Animation
- Duplicate base frame for each animation state
- Modify key-pose frames; rely on Godot's SpriteFrames for interpolation-free playback
- Test loop in Godot AnimationPlayer before finalizing

### Stage 6: Integration
- Export as PNG with transparent background
- Import to Godot with settings:
  - Compression: Lossless
  - Filter: Nearest
  - Mipmaps: Off
  - Texture Format: RGBA8
- Assign to SpriteFrames or TileSet resource as appropriate
- Test at game resolution (1280×720) for pixel correctness

---

## 6. Asset Delivery Format

| Requirement | Specification |
|---|---|
| File format | PNG, 32-bit RGBA |
| Background | Fully transparent (alpha = 0) for all sprites and icons |
| Color depth | 8-bit indexed PNG preferred (reduces file size, preserves palette) |
| Compression | Lossless (PNG default) |
| File naming | All lowercase, underscores, no spaces: `kael_sheet.png` |
| Directory structure | `res://assets/characters/`, `res://assets/enemies/`, `res://assets/tilesets/`, `res://assets/ui/`, `res://assets/effects/`, `res://assets/backgrounds/` |

Sprite sheets must include a matching `.import` settings file (Godot auto-generates these, but Artist must verify settings after first import).

---

## 7. Color Palette Definitions for All 5 Races

All hex values are in `#RRGGBB` format (fully opaque). Each palette is limited to 16 colors.

### Human Palette
| Swatch | Name | Hex | Usage |
|---|---|---|---|
| ■ | Outline | `#1a1a2e` | Sprite outline |
| ■ | Skin Dark | `#8b5e3c` | Shadow on skin |
| ■ | Skin Mid | `#c68642` | Base skin tone |
| ■ | Skin Light | `#e8a97e` | Highlight skin |
| ■ | Hair Dark | `#2c1810` | Shadow on hair |
| ■ | Hair Mid | `#5c3317` | Base hair (brown) |
| ■ | Hair Light | `#8b5e3c` | Hair highlight |
| ■ | Cloth Dark | `#1f3a5f` | Shadow on clothing |
| ■ | Cloth Mid | `#2e5090` | Base clothing (blue) |
| ■ | Cloth Light | `#4d7ab5` | Cloth highlight |
| ■ | Metal Dark | `#3a3a3a` | Shadow on metal |
| ■ | Metal Mid | `#7a7a7a` | Base metal |
| ■ | Metal Light | `#c8c8c8` | Metal highlight |
| ■ | Eye Color | `#4a9eda` | Eyes |
| ■ | Leather | `#7a4f2a` | Belts, boots |
| ■ | Off-White | `#f0e8d0` | Shirt, bandages |

### Elf Palette
| Swatch | Name | Hex | Usage |
|---|---|---|---|
| ■ | Outline | `#0d1f0d` | Sprite outline |
| ■ | Skin Dark | `#6b8f71` | Shadow on skin |
| ■ | Skin Mid | `#a8c5a0` | Base skin (pale green-tinted) |
| ■ | Skin Light | `#d4e8cf` | Highlight skin |
| ■ | Hair Dark | `#1a3320` | Shadow on hair |
| ■ | Hair Mid | `#2d6e40` | Base hair (dark green) |
| ■ | Hair Light | `#4d9e60` | Hair highlight |
| ■ | Cloth Dark | `#1a2e1a` | Shadow on clothing |
| ■ | Cloth Mid | `#2e5e2e` | Base clothing (forest green) |
| ■ | Cloth Light | `#4e8e4e` | Cloth highlight |
| ■ | Gold Dark | `#7a5a10` | Shadow on gold trim |
| ■ | Gold Mid | `#c49a20` | Base gold |
| ■ | Gold Light | `#f0c840` | Gold highlight |
| ■ | Eye Color | `#a0e040` | Bioluminescent green eyes |
| ■ | Bark | `#5a3a1a` | Wooden accessories |
| ■ | Leaf | `#7abf5e` | Leaf/vine decorations |

### Dwarf Palette
| Swatch | Name | Hex | Usage |
|---|---|---|---|
| ■ | Outline | `#1a0e00` | Sprite outline |
| ■ | Skin Dark | `#7a4520` | Shadow on skin |
| ■ | Skin Mid | `#bf7040` | Base skin (ruddy) |
| ■ | Skin Light | `#d89870` | Highlight skin |
| ■ | Hair Dark | `#4a1500` | Shadow on hair |
| ■ | Hair Mid | `#8b3000` | Base hair (auburn) |
| ■ | Hair Light | `#c05010` | Hair highlight |
| ■ | Cloth Dark | `#2a1a0a` | Shadow on clothing |
| ■ | Cloth Mid | `#5a3820` | Base clothing (leather brown) |
| ■ | Cloth Light | `#8a5c3a` | Cloth highlight |
| ■ | Iron Dark | `#202020` | Shadow on iron |
| ■ | Iron Mid | `#505050` | Base iron armor |
| ■ | Iron Light | `#909090` | Iron highlight |
| ■ | Gem | `#e04040` | Gemstone accents (ruby) |
| ■ | Forge Glow | `#ff8020` | Heated metal glow effects |
| ■ | Off-White | `#e8e0d0` | Fur trim, teeth |

### Draconian Palette
| Swatch | Name | Hex | Usage |
|---|---|---|---|
| ■ | Outline | `#1a0500` | Sprite outline |
| ■ | Scale Dark | `#4a0800` | Shadow on scales |
| ■ | Scale Mid | `#8b1500` | Base scale (deep red) |
| ■ | Scale Light | `#c82000` | Scale highlight |
| ■ | Scale Alt | `#1a0000` | Underbelly/contrast scales (near-black) |
| ■ | Horn Dark | `#2a1a00` | Shadow on horns |
| ■ | Horn Mid | `#5a3a00` | Base horn |
| ■ | Horn Light | `#9a6a10` | Horn highlight |
| ■ | Eye Color | `#ff6600` | Glowing orange slit eyes |
| ■ | Cloth Dark | `#1a0a00` | Shadow on cloth wraps |
| ■ | Cloth Mid | `#3a1a00` | Base cloth (dark brown) |
| ■ | Cloth Light | `#5a3020` | Cloth highlight |
| ■ | Metal Dark | `#2a1500` | Shadow on dark metal |
| ■ | Metal Mid | `#5a3010` | Base metal (bronze) |
| ■ | Metal Light | `#c87820` | Bronze highlight |
| ■ | Flame | `#ff9500` | Fire breath / inner glow |

### Sprite (Race) Palette
| Swatch | Name | Hex | Usage |
|---|---|---|---|
| ■ | Outline | `#0a0a20` | Sprite outline |
| ■ | Skin Dark | `#5050a0` | Shadow on skin |
| ■ | Skin Mid | `#8080d0` | Base skin (ethereal blue) |
| ■ | Skin Light | `#b0b0f0` | Highlight skin |
| ■ | Hair Dark | `#8000a0` | Shadow on hair |
| ■ | Hair Mid | `#c000f0` | Base hair (vivid violet) |
| ■ | Hair Light | `#e060ff` | Hair highlight |
| ■ | Wing Dark | `#2020a0` | Shadow on wings |
| ■ | Wing Mid | `#4040d0` | Base wing membrane |
| ■ | Wing Light | `#8080ff` | Wing highlight (translucent look) |
| ■ | Cloth Dark | `#200040` | Shadow on clothing |
| ■ | Cloth Mid | `#500090` | Base clothing (deep violet) |
| ■ | Cloth Light | `#8000c0` | Cloth highlight |
| ■ | Glow | `#c0e0ff` | Magical glow core |
| ■ | Star | `#ffffc0` | Sparkle/star effects |
| ■ | Void | `#000010` | Near-black void accents |

---

## 8. Completion Checklist

- [ ] Art style guide reviewed and understood by Game Artist
- [ ] All character sprites complete: 5 playable races × all 7 animation states
- [ ] All enemy sprites complete: minimum 15 grunts + 3 bosses
- [ ] World tileset complete with all required tile types
- [ ] Dungeon tileset complete with all required tile types
- [ ] Town tileset complete with all required tile types
- [ ] All 8 battle backgrounds (far/mid/near layers) complete
- [ ] All 8 elemental spell effect animations complete (cast + hit per element)
- [ ] HP, MP, XP bar assets complete at specified sizes
- [ ] All menu panel assets complete
- [ ] 11 status effect icons complete (16×16 each)
- [ ] 8 elemental element icons complete
- [ ] Item category icons complete
- [ ] All 48×48 dialogue portraits produced for main characters
- [ ] All 96×96 large portraits produced for cutscene characters
- [ ] All assets named according to naming conventions
- [ ] All assets exported as PNG with transparent background
- [ ] All color palettes verified: no sprite exceeds 16 colors
- [ ] Palette definitions match hex values in Section 7 for all 5 races
- [ ] All assets imported into Godot with Nearest filter, no mipmaps
- [ ] Pixel-correctness verified at 1280×720 display resolution
- [ ] Game Artist formal sign-off recorded (name + date)

**Gate Signed Off By:** _________________________ **Date:** _____________

---

*Proceed to Phase 5: Sound Design only after all gate items are checked.*
