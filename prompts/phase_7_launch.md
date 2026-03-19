# Phase 7: Launch & Release

## Overview

This phase covers all activities from final build to public release and post-launch maintenance. The **Game Launcher** coordinates export configuration, platform verification, store page setup, and post-launch support. Nothing is published until every item in the pre-launch checklist is verified.

---

## Objective

Deliver a polished, correctly configured release build on all target platforms, with all legal, credits, and store requirements satisfied, and a post-launch support process in place.

---

## 1. Godot 4 Export Configuration

### 1.1 Windows (64-bit)

**Export Preset Settings:**
```
Platform: Windows Desktop
Architecture: x86_64
Export Path: builds/windows/GameTitle.exe
Icon: res://assets/ui/icons/app_icon_256.ico  (256×256, ICO format)
File Version: [SemVer string, e.g., 1.0.0.0]
Product Version: [SemVer string]
Company Name: [Studio name]
Product Name: [Game title]
```

**Required Files Alongside Executable:**
- `GameTitle.exe`
- `GameTitle.pck` (embedded in exe or alongside it)
- No other DLLs required for standard Godot 4 export

**Export Flags:**
- [ ] Embed PCK: Yes (produces single-file executable)
- [ ] Debug Symbols: No (release build)
- [ ] Optimize: Speed

**Pre-export Verification:**
- [ ] Run exported build on a clean Windows machine without Godot installed
- [ ] Verify no "missing DLL" errors on startup
- [ ] Verify saves write to `%APPDATA%/GameTitle/` correctly

---

### 1.2 Linux (64-bit)

**Export Preset Settings:**
```
Platform: Linux/X11
Architecture: x86_64
Export Path: builds/linux/GameTitle.x86_64
Icon: res://assets/ui/icons/app_icon_256.png  (256×256 PNG)
```

**Post-export Steps:**
1. Set executable bit: `chmod +x GameTitle.x86_64`
2. Create distribution archive: `zip -r GameTitle_Linux.zip GameTitle.x86_64`
3. Test on both Ubuntu LTS and a Fedora-based system if possible

**Pre-export Verification:**
- [ ] Run on clean Ubuntu 22.04 LTS (no Godot installed)
- [ ] Verify X11 window opens at correct resolution
- [ ] Verify saves write to `~/.local/share/GameTitle/` correctly
- [ ] Check for X11 vs. Wayland compatibility (Godot 4 supports both)

---

### 1.3 macOS (Universal — x86_64 + arm64)

**Export Preset Settings:**
```
Platform: macOS
Architecture: Universal (x86_64 + arm64)
Export Path: builds/macos/GameTitle.dmg
Bundle Identifier: com.studiname.gametitle
App Version: [SemVer]
Icon: res://assets/ui/icons/app_icon.icns  (multi-size ICNS)
```

**Code Signing (required for distribution without "damaged app" warning):**
- [ ] Sign with Apple Developer certificate: `codesign --deep --force --verify --verbose --sign "Developer ID Application: Your Name" GameTitle.app`
- [ ] Notarize with Apple: `xcrun notarytool submit GameTitle.zip --apple-id ... --team-id ... --password ...`
- [ ] Staple notarization ticket: `xcrun stapler staple GameTitle.app`

**If unable to sign/notarize:** Document in release notes. Players must right-click → Open on first launch.

**Pre-export Verification:**
- [ ] Test on Apple Silicon Mac (arm64)
- [ ] Test on Intel Mac (x86_64)
- [ ] Verify saves write to `~/Library/Application Support/GameTitle/` correctly

---

### 1.4 Web / HTML5

**Export Preset Settings:**
```
Platform: Web
Export Path: builds/web/index.html
Progressive Web App: No (unless specifically designed for offline play)
GDNative: Disabled
Thread Support: Disabled (itch.io requires COOP/COEP headers for threads; disable for compatibility)
```

**itch.io HTML5 Requirements:**
- Upload as ZIP file containing: `index.html`, `index.js`, `index.wasm`, `index.pck`, `index.audio.worklet.js`
- Set "This file will be played in the browser" in itch.io upload settings
- In itch.io embed settings: set viewport dimensions to 1280×720

**Web-Specific Limitations to Document:**
- Save data uses IndexedDB (browser storage). Players should be warned that clearing browser data deletes saves.
- Audio autoplay may require first user interaction before BGM starts (Godot 4 handles this natively).
- No access to `user://` persistent storage between browser sessions without additional configuration.

**Pre-export Verification:**
- [ ] Test in Chrome, Firefox, and Safari (latest stable)
- [ ] Verify audio plays after first click
- [ ] Verify full-screen toggle works (F key or button)
- [ ] Verify saves persist between page refreshes (IndexedDB working)

---

## 2. Launch Checklist — 100+ Items

### Category A: Pre-Launch Technical (35 items)

#### Build Integrity
- [ ] A-001: All 4 platform exports produced from the same source commit
- [ ] A-002: Export commit is tagged in version control (e.g., `v1.0.0`)
- [ ] A-003: PCK embedded in Windows executable (single-file build)
- [ ] A-004: Linux executable bit set (`chmod +x`)
- [ ] A-005: macOS app is signed and notarized (or waiver documented)
- [ ] A-006: Web export tested in Chrome, Firefox, and Safari

#### Save System
- [ ] A-007: Save system tested on all 4 platforms
- [ ] A-008: Save files write to OS-appropriate user directory (not game folder)
- [ ] A-009: All 3 save slots tested independently
- [ ] A-010: Save file from one session loadable in a fresh game launch
- [ ] A-011: Corrupted save file handled without crash (error message shown)
- [ ] A-012: New game correctly clears old save state from memory

#### Controls & Input
- [ ] A-013: Keyboard controls functional and documented in-game
- [ ] A-014: Controller support tested (Xbox, PlayStation, generic USB)
- [ ] A-015: All actions are remappable via Settings menu
- [ ] A-016: Remapped controls persist across sessions via save/config
- [ ] A-017: Mouse input fully functional where applicable (menus, UI)
- [ ] A-018: No input conflicts between keyboard and controller when both connected

#### Audio
- [ ] A-019: BGM plays on all 4 platforms without distortion
- [ ] A-020: SFX plays without audio channel starvation in busy battles
- [ ] A-021: Volume settings (BGM/SFX/UI) apply immediately and persist
- [ ] A-022: Game launches without audio error even if audio device is unavailable
- [ ] A-023: Audio ducking during dialogue verified

#### Video & Display
- [ ] A-024: Game launches at 1280×720 resolution by default
- [ ] A-025: Windowed and fullscreen modes both function
- [ ] A-026: Alt+Enter (or equivalent) toggles fullscreen correctly
- [ ] A-027: Resolution change applies without requiring restart
- [ ] A-028: No visual artifacts at 1280×720 or 1920×1080 display
- [ ] A-029: Game renders correctly on 16:9, 16:10, and 4:3 aspect ratios (letterboxed)

#### Performance
- [ ] A-030: 60 FPS maintained in battle with 4 party members + 4 enemies + effects
- [ ] A-031: 60 FPS maintained on world map
- [ ] A-032: Scene load times under 250ms (target under 100ms)
- [ ] A-033: Memory usage does not exceed 512MB peak
- [ ] A-034: No memory leaks after 60 minutes of continuous play
- [ ] A-035: Game exits cleanly (no orphaned processes after window close)

---

### Category B: Content Completeness (26 items)

#### Story & Narrative
- [ ] B-001: All main quest scenes playable from start to final ending
- [ ] B-002: All cutscenes present and trigger at correct story points
- [ ] B-003: No "Lorem ipsum" or placeholder text in any dialogue
- [ ] B-004: All character names consistent across all scenes
- [ ] B-005: Ending plays and credits roll correctly
- [ ] B-006: All three save slots work across the full game length

#### Art Assets
- [ ] B-007: No placeholder "pink" default textures in any scene
- [ ] B-008: All 5 playable race sprites complete with all 7 animations
- [ ] B-009: All battle backgrounds present for all terrain types
- [ ] B-010: All spell effect animations complete for all 8 elements
- [ ] B-011: All UI elements present (HP/MP bars, menus, icons, portraits)
- [ ] B-012: All status effect icons present (11 icons)
- [ ] B-013: All item icons present

#### Audio
- [ ] B-014: All 14 BGM tracks present and trigger at correct moments
- [ ] B-015: Victory jingle (short) plays after all non-boss battles
- [ ] B-016: Victory theme (full) plays after all boss battles
- [ ] B-017: Game Over music plays on party wipe
- [ ] B-018: All SFX triggers produce the correct sound (no silent triggers)
- [ ] B-019: No audio tracks are silent (OGG files not empty/corrupted)

#### Systems
- [ ] B-020: All 50 Phase 6 test cases passed (verified by QA)
- [ ] B-021: All 5 equipment tiers have at least 3 items each available in game
- [ ] B-022: All 5 playable races selectable at character creation (if applicable)
- [ ] B-023: All skills in skill trees are learnable (no dead-end nodes)
- [ ] B-024: All 20+ spells are learnable through normal gameplay
- [ ] B-025: Quest log shows all completed, active, and failed quests correctly
- [ ] B-026: Credits screen lists all team members and third-party assets

---

### Category C: Store Pages — itch.io (20 items)

#### Page Content
- [ ] C-001: Game title matches in-game title exactly
- [ ] C-002: Short description (≤ 160 characters) written and proofread
- [ ] C-003: Full description written (see Section 5 for template)
- [ ] C-004: Features list in description accurate (5–8 bullet points)
- [ ] C-005: Controls section in description complete
- [ ] C-006: Credits section in description complete

#### Media
- [ ] C-007: Cover image provided (630×500 pixels, eye-catching, shows gameplay)
- [ ] C-008: Minimum 4 screenshots uploaded (1280×720, showing different game modes)
- [ ] C-009: Screenshots show: world map, battle scene, dialogue, town/menu
- [ ] C-010: No UI debug overlays visible in screenshots
- [ ] C-011: Optional: 30–60 second gameplay trailer video uploaded

#### Metadata
- [ ] C-012: Genre tags set: RPG, JRPG, Pixel Art, Turn-Based, Fantasy
- [ ] C-013: Platform checkboxes correct (Windows/Linux/macOS/HTML5 as applicable)
- [ ] C-014: Release type set (Full release, not Demo or Early Access)
- [ ] C-015: Pricing set and confirmed (or Free marked correctly)
- [ ] C-016: Content warning tags added if applicable (mild violence, etc.)

#### Files
- [ ] C-017: Windows ZIP uploaded and marked "Windows"
- [ ] C-018: Linux ZIP uploaded and marked "Linux"
- [ ] C-019: macOS ZIP/DMG uploaded and marked "macOS"
- [ ] C-020: HTML5 ZIP uploaded with "Play in browser" option enabled

---

### Category D: Legal & Credits (12 items)

- [ ] D-001: All third-party assets (fonts, audio libraries, art tools) have licenses reviewed
- [ ] D-002: All open-source licenses reproduced in game folder or credits
- [ ] D-003: No assets used without proper license (commercial, CC, or original)
- [ ] D-004: Godot Engine credit included (MIT license requirement)
- [ ] D-005: Credits screen in game lists all team members by role
- [ ] D-006: Credits screen lists all third-party tools and assets
- [ ] D-007: itch.io page lists third-party asset credits
- [ ] D-008: Privacy policy or note included if any analytics are collected
- [ ] D-009: No trademarks or copyrights infringed by game title, character names, or artwork
- [ ] D-010: EULA or license statement on itch.io page (if applicable)
- [ ] D-011: Age rating assessed and disclosed on store page
- [ ] D-012: Game Launcher reviewed legal checklist with a team member

---

### Category E: Post-Launch (17 items)

#### Announcement
- [ ] E-001: Social media announcement posts drafted and scheduled
- [ ] E-002: Press kit created (cover art, screenshots, description, team bio)
- [ ] E-003: Announcement posted to relevant communities (r/gamedev, itch.io feed, Discord servers)
- [ ] E-004: Notify any beta testers or wishlisters of launch
- [ ] E-005: Launch post on itch.io devlog

#### Bug Tracking
- [ ] E-006: Public bug report channel established (itch.io comments, GitHub Issues, or Discord)
- [ ] E-007: Bug report template posted publicly so players know how to report
- [ ] E-008: Bug tracking spreadsheet or tool active and accessible to team

#### Patch Process
- [ ] E-009: Patch release process documented (see SemVer section)
- [ ] E-010: Patch notes template ready (see Section 4)
- [ ] E-011: Hotfix build pipeline tested (can export and upload patch within 2 hours)

#### Monitoring
- [ ] E-012: itch.io analytics review scheduled (Day 1, Day 7, Day 30)
- [ ] E-013: Known Issues section on itch.io page with any outstanding Medium bugs documented
- [ ] E-014: Response plan for Critical post-launch bugs (who fixes, how fast)

#### Community
- [ ] E-015: Community Discord or forum created (optional but recommended)
- [ ] E-016: Feedback form or survey link posted for players
- [ ] E-017: Post-launch roadmap (even if short) communicated to players

---

## 3. Release Notes Template

Use this template for every release version. Post to itch.io devlog and pin on community page.

```markdown
# [Game Title] — Version [X.Y.Z] Release Notes

**Release Date:** [YYYY-MM-DD]
**Platform:** [Windows / Linux / macOS / Web / All]

---

## New Features

- [Feature 1 — brief description]
- [Feature 2 — brief description]
- [Feature N — brief description]

## Improvements

- [Improvement 1]
- [Improvement 2]

## Bug Fixes

- **[BUG-XXXX]** [System]: [Short description of what was fixed]
- **[BUG-XXXX]** [System]: [Short description of what was fixed]

## Known Issues

- [Issue 1 — brief description and workaround if available]
- [Issue 2 — brief description]

## How to Update

[Windows/Linux/macOS]: Download the new version from the itch.io page and replace your 
previous installation. Your save files are stored separately and will not be affected.

[Web]: Clear your browser cache and reload the game page to get the latest version.

---

Thank you for playing and for your feedback!
— [Team/Studio Name]
```

---

## 4. itch.io Page Template

### Short Description (≤ 160 characters)
```
A classic-style JRPG with deep tactical combat, five playable races, 
and a story of a fractured world fighting to survive. Free.
```

### Full Description

```markdown
## About [Game Title]

[Elevator pitch from Phase 1 — 2–3 sentences]

[Game Title] is a turn-based JRPG where every decision matters. Lead a party 
of warriors, mages, rogues, and healers drawn from five ancient races through 
treacherous dungeons, war-torn kingdoms, and the ruins of a dead god's creation.

---

## Features

- **Deep Tactical Combat** — Speed-based ATB battle system with 6 action types, 
  11 status effects, and formation bonuses that reward strategic thinking.
- **Five Playable Races** — Human, Elf, Dwarf, Draconian, and Sprite, each with 
  unique passive and active racial abilities, stat modifiers, and skill branches.
- **Rich Skill & Magic Systems** — 30+ skills across multiple classes, 20+ spells 
  across 5 schools of magic, and elemental weakness interactions that reward 
  preparation.
- **Morale System** — Party morale rises and falls based on battle performance, 
  affecting stats and creating dynamic tension in tough fights.
- **Classic JRPG Story** — A three-act narrative with fully developed protagonist 
  and antagonist, moral complexity, and a world built from the ground up.
- **Handcrafted Pixel Art** — 320×180 native resolution pixel art with race-specific 
  palettes, animated spell effects, and layered battle backgrounds.
- **Original Soundtrack** — 14 original music tracks composed to match every 
  moment from peaceful towns to world-ending boss battles.

---

## Controls

| Action | Keyboard | Controller |
|---|---|---|
| Move | WASD / Arrow Keys | Left Stick / D-Pad |
| Confirm / Interact | Enter / Z | A / Cross |
| Cancel / Back | Escape / X | B / Circle |
| Open Menu | Tab / M | Start |
| Target Next | Right Arrow | Right |
| Target Previous | Left Arrow | Left |

All controls are fully remappable in the Settings menu.

---

## How to Play

[Brief 2–3 paragraph gameplay overview: starting the game, exploring the world, 
entering battles, managing the party. Keep spoiler-free.]

---

## Credits

| Role | Name |
|---|---|
| Game Director | [Name] |
| Story | [Name] |
| Game Design | [Name] |
| Programming | [Name] |
| Art | [Name] |
| Music & Sound | [Name] |
| QA | [Name] |

**Built with:** Godot Engine 4 (MIT License)

**Third-party assets:**
- [Asset Name] by [Creator] — [License]
- [Asset Name] by [Creator] — [License]

---

## Known Issues

[List any outstanding known issues at launch — be transparent]

---

*Feedback, bug reports, and suggestions welcome in the comments below!*
```

---

## 5. SemVer Versioning Procedure

The game uses **Semantic Versioning** (`MAJOR.MINOR.PATCH`).

### Version Number Definitions

| Part | Increment When | Example |
|---|---|---|
| **MAJOR** | A complete game remake, engine migration, or backwards-incompatible save format change | `1.0.0` → `2.0.0` |
| **MINOR** | New content added (new dungeon, new character, new story chapter), new features that don't break saves | `1.0.0` → `1.1.0` |
| **PATCH** | Bug fixes, balance tweaks, typo corrections, audio adjustments — no new features | `1.0.0` → `1.0.1` |

### Version History Procedure

1. All release versions are tagged in version control: `git tag v1.0.1 -m "Hotfix: battle flee crash"`
2. Version number is visible in the game's main menu (bottom-right corner, `VersionLabel` node)
3. Version number is visible on the itch.io upload (set in file description field)
4. Patch notes are posted to itch.io devlog for every release
5. Version string in `project.godot` is updated before export: `config/version="1.0.1"`

### Initial Release
- First public release: `v1.0.0`
- Pre-release candidate builds during QA: `v1.0.0-rc1`, `v1.0.0-rc2`
- Post-QA hotfixes in the first week: `v1.0.1`, `v1.0.2`
- First content update: `v1.1.0`

---

## 6. Completion Checklist

- [ ] All 4 platform exports produced and verified
- [ ] Windows export runs on clean machine without Godot installed
- [ ] Linux export executable bit set and tested on Ubuntu LTS
- [ ] macOS export tested on Apple Silicon and Intel
- [ ] Web export tested in Chrome, Firefox, and Safari
- [ ] 100-item pre-launch checklist completed (Categories A through E)
- [ ] itch.io page live with all required content (description, screenshots, files)
- [ ] All platform files uploaded and labeled correctly on itch.io
- [ ] Version tagged in version control: `git tag v1.0.0`
- [ ] Version number visible in main menu
- [ ] Release notes for v1.0.0 written and posted to itch.io devlog
- [ ] All legal and credits requirements verified (Category D)
- [ ] Post-launch monitoring plan in place (Category E)
- [ ] Bug report channel established and publicized
- [ ] Known issues documented on itch.io page
- [ ] Social media launch announcement posted
- [ ] Game Launcher formal sign-off recorded (name + date)

**Gate Signed Off By:** _________________________ **Date:** _____________

---

*Launch complete. Monitor itch.io analytics and player feedback. Address Critical bugs within 24 hours via hotfix. Good luck!*
