# Editor Redesign: Consolidated Channel-Based Editor

## Summary

Removed Step 1 (Project Setup) entirely and consolidated all functionality into the main editor view. The app now opens directly into the editor with a channel-based multi-track timeline system.

## Changes Made

### Header Redesign
- Removed step pills (01 Project → 02 Edit → 03 Export)
- Added compact **layout switcher** (Full / Split / Quad) with SVG icon buttons
- Added **Upload Media** button that uploads files directly to active channel
- Kept Load/Save project buttons

### Channel System (replaces Lanes)
- `S.lanes = {main:[], second:[]}` → `S.channels = {A:[], B:[], C:[], D:[]}`
- **Full**: Channel A only
- **Split**: Channels A (top) + B (bottom)
- **Quad**: Channels A/B/C/D in 4 quadrants

### Dynamic Timeline
- Tracks generated dynamically based on layout mode
- Each channel track has a **"+"** button and supports **drag-and-drop** file upload
- Intro, Outro, and Audio tracks always present

### Bug Fixes Applied
| Bug | Root Cause | Fix |
|-----|-----------|-----|
| Preview flickering | `seekVideoTo` threshold too small (0.05s) | Increased to 0.15s |
| Outro not displaying | `drawFrame` used undefined `mainDur` | Changed to `maxChDur` |
| Process & Export not reacting | `processAndExport` referenced `S.lanes` | Migrated to `S.channels` |
| Export navigation | `goStep(3)` invalid | Changed to `goStep('export')` |
| Save/Load broken | Used `S.lanes` format | Updated to v4 channels format with v3 backward compat |
| Audio missing from timeline | `addLibraryTrack` omitted UI redraw | Added `renderTimeline()` to all audio insert/delete functions |
| Library audio fails to fetch | Remote server lacks CORS headers | Added fallback to construct `<audio>` using direct URL |

### Media Loading (Consistent Flow)
All 3 entry points use the same `uploadMedia()` function:
1. **Header** "Upload Media" button
2. **Timeline** "+" buttons per channel
3. **Drag-and-drop** files onto channel tracks

## Verification
- Zero console errors on load or interaction
- Layout switching dynamically updates timeline tracks
- "Process & Export" correctly shows "Add media first" toast when empty
- Upload Media button triggers file picker
- Save/load backwards-compatible with old project files
