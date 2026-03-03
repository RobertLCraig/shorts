# Bambu Shorts Studio

A powerful, web-based video editing tool designed specifically for creating short-form vertical videos (9:16 aspect ratio) optimized for YouTube Shorts, TikTok, Instagram Reels, and other social platforms. Perfect for 3D printing creators, product demos, and time-lapses.

## Features

### 🎬 Multi-Channel Video Editor
- **Channel-Based Composition**: Up to 4 channels (A–D) with flexible layouts:
  - **Full**: Channel A fills the entire frame
  - **Split**: Channels A (top) + B (bottom) stacked vertically
  - **Quad**: Channels A/B/C/D in a 4-way quadrant grid
- **Direct Upload**: Upload videos via header button, per-channel "+" buttons, or drag-and-drop onto timeline tracks
- **Dynamic Timeline**: Visual multi-track timeline with time ruler, playhead, and per-channel clips

### 🎨 Content Enhancement
- **Intro/Outro Images**: Add multiple intro/outro images with:
  - Per-image duration sliders (1–10 seconds, 0.5s steps)
  - Full-size drag-to-position, scroll-to-zoom canvas editor (900px wide)
  - Thumbnail previews in the image list
  - Live preview in the canvas
- **Carousel Overlay**: Rotating product images with configurable:
  - Position (top-left/right, bottom-left/right)
  - Rotation interval (1–10s) via range slider
  - Size (small/medium/large) and shape (rounded/circle/square)
- **Text Overlay**: Add text to your videos with:
  - Configurable font size (20–120px), color picker, position (top/center/bottom)
  - Font style (bold/normal/italic)
  - Background options (none, shadow, or semi-transparent box)
  - Rendered on both preview and exported video
- **Thumbnail Generator**: Grab a frame from preview or upload custom thumbnail

### 🎵 Audio Management
- **Local Audio Upload**: Add multiple audio tracks with per-track volume control (sliders)
- **Built-in Audio Library**: Curated royalty-free music from Kevin MacLeod (Incompetech):
  - Upbeat tracks (Monkeys Spinning Monkeys, Sneaky Snitch, Fluffing a Duck, Upbeat Forever)
  - Lofi ambient (Local Forecast, Mining by Moonlight, After Lemons)
  - Chill (Carefree, Wholesome, Pixelland)
  - Cinematic (Impact Prelude, Cipher)
  - One-click add-to-project with automatic attribution
- **Project Audio**: Local audio files from the `audio/` directory
- **Audio Mixing**: All tracks mixed and exported together

### 🎯 Export & Distribution
- **Multi-Format Export**: MP4 (if supported) or WebM with configurable CRF/bitrate
- **Real-time Preview**: Scrub through the montage with play/pause and timeline control
- **Platform-Specific Cards**: YouTube Shorts, TikTok, Instagram Reels, Pinterest, Facebook Reels with:
  - Copy-paste descriptions
  - Auto-formatted hashtags
  - Direct upload links
- **Batch Download**:
  - Processed video
  - Thumbnail PNG
  - Project metadata ZIP (easy sharing/archiving)

### 💾 Project Management
- **Save/Load JSON**: Export project configuration (channel assignments, audio, metadata, settings)
- **Backward Compatible**: Loads v3 lane-based project files and migrates to v4 channel format
- **Persistent Settings**: Crop mode, speed, quality (CRF), dimensions

### ⚙️ Advanced Settings
- **Crop Modes**: Center-crop or blur-padding to fit frame
- **Speed Control**: 1×–8× playback speed (affects frame count and export time)
- **Video Quality (CRF)**: Very High, High, or Medium quality for MP4/WebM export
- **Crop Offset**: Fine-tune the horizontal crop position with a -100% to +100% slider
- **Metadata**: Title, description, model/shop URLs, and hashtags for platforms

## Getting Started

### Prerequisites
- Modern web browser (Chrome, Firefox, Safari, Edge) with:
  - Canvas API support
  - MediaRecorder API
  - Blob/File API
- ~500 MB disk space for video processing (temp files)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/bambu-shorts-studio.git
   cd bambu-shorts-studio
   ```

2. **Open in browser:**
   ```bash
   # Option A: Direct file open (limited to local files only)
   open video2short.html
   
   # Option B: Serve locally (recommended for full feature support)
   python3 -m http.server 8000
   # Then visit http://localhost:8000/video2short.html
   ```

### Quick Start

1. **Upload Videos**: Click "Upload Media" or drag files onto a channel track
2. **Choose Layout**: Use the header layout switcher (Full / Split / Quad)
3. **Add Audio**: Upload local audio files or pick from the built-in library
4. **Add Extras**: 
   - Upload intro/outro images with per-image duration sliders
   - Add carousel overlay images for product showcases
   - Add text overlay with customizable font, color, position, and background
5. **Preview**: Play through the montage and adjust settings in real-time
6. **Export**: Click "Process & Export" to render the final video (takes 1-5 min depending on duration)
7. **Distribute**: Download video, share to platforms with auto-formatted descriptions, or save project for later

## Technical Details

### Architecture
- **Single-file HTML app**: No build process required; just open in a browser
- **Canvas-based rendering**: All video composition happens on a `<canvas>` element
- **MediaRecorder API**: Frame-level rendering with automatic capture for precise export quality
- **Web Audio API**: Audio mixing and synchronized playback during export
- **Channel system**: State-managed channel assignments (`S.channels = {A:[], B:[], C:[], D:[]}`)

### Browser Compatibility
| Feature | Chrome | Firefox | Safari | Edge |
|---------|--------|---------|--------|------|
| Video Upload | ✅ | ✅ | ✅ | ✅ |
| Canvas Rendering | ✅ | ✅ | ✅ | ✅ |
| MediaRecorder | ✅ | ✅ | ⚠️ Limited | ✅ |
| MP4 Export | ✅ (H.264/AAC) | ❌ | ✅ | ✅ (H.264/AAC) |
| WebM Export | ✅ (VP9/Opus) | ✅ (VP8/Vorbis) | ❌ | ✅ (VP9/Opus) |

**Note**: MP4 support depends on browser codec availability. If unavailable, the app falls back to WebM.

### Video Dimensions
- **Canvas**: 1080px × 1920px (9:16 vertical short-form)
- **Target Frame Rate**: 30 FPS
- **Audio Sample Rate**: 48 kHz (inherited from audio context)

### Performance
- **Rendering**: ~30–60 minutes of video per minute of processing on a modern machine
- **Memory**: Typically 200–500 MB for 2–3 videos and audio
- **Export File Size**: ~10–50 MB (depends on quality/duration)

## Project Structure

```
bambu-shorts-studio/
├── video2short.html          # Single-file app (HTML + inline CSS + JS)
├── audio/                    # Local audio files (optional)
│   ├── ForwardAssemblyAIMusic1.mp4
│   └── ForwardAssemblyAIMusic2.mp4
├── README.md                 # This file
├── WALKTHROUGH.md            # Change log
└── .git/                     # Git repository
```

## Key Sections (video2short.html)

1. **HTML** (Lines 1–1700): 
   - Direct-to-editor layout (no setup step)
   - Header with layout switcher (Full/Split/Quad), Upload Media, Load/Save
   - Tabbed panel: Settings, Media, Text, Audio
   - Modal dialogs for audio library and image editor
   - Timeline with dynamic channel tracks, playhead, and time ruler

2. **CSS** (Lines 13–1660):
   - Dark theme with green accents
   - Responsive grid layout
   - Timeline track and clip styling
   - Animations and transitions

3. **JavaScript** (Lines 1700–3500):
   - **State Management** (`S`): Global state for videos, channels, audio, text overlay, settings
   - **Channel System** (`channelDuration`, `resolveTimeInChannel`, `removeFromAllChannels`)
   - **Video Logic** (`uploadMedia`, `setLayout`, `drawVideoSlice`)
   - **Playback Engine** (`computeMontageDuration`, `drawFrame`, `startPreviewLoop`)
   - **Text Overlay** (`drawTextOverlay`, `updateTextOverlay`, `setTextBg`)
   - **Audio Library** (`openAudioLibrary`, `addLibraryTrack`, `addProjectAudio`)
   - **Multi-Image Intro/Outro** (`handleIOMulti`, `resolveIOImage`, `drawIOImageOnCanvas`)
   - **Timeline** (`renderTimeline`, `updatePlayhead`, `seekTimelineFromTL`)
   - **Export Pipeline** (`processAndExport`, `setupExportPage`)
   - **UI Helpers** (`toast`, `esc`, `fmtTime`, `switchTab`)
   - **Image Editor** (`openIOEditor`, `drawEditor`, `ioEditorSave`)

## Configuration & Settings

All settings are stored in the global `S` object:

```javascript
S.layout         // 'full' | 'split' | 'quad'
S.channels       // { A: [], B: [], C: [], D: [] } — video id arrays
S.cropMode       // 'crop' | 'pad'
S.speed          // 1 | 2 | 4 | 8
S.crf            // 15 (very high) | 18 (high) | 23 (medium)
S.meta           // title, desc, fileUrl, shopUrl, tags
S.textOverlay    // { text, size, color, position, style, bg }
```

No configuration file needed; all settings are UI-driven.

## Troubleshooting

### Videos won't play in preview
- **Cause**: Browser codec support or CORS issues
- **Fix**: Try a different browser (Chrome/Firefox recommended)

### Export hangs after "Rendering"
- **Cause**: Browser tab backgrounded, or insufficient memory
- **Fix**: Keep browser tab active; close other apps; try shorter videos first

### Audio not included in export
- **Cause**: Audio context not created or audio elements not ready
- **Fix**: Ensure audio files load (check console for 404s); try re-adding audio

### "Failed to attach" error (project files)
- **Cause**: CORS policy or local file:// protocol limitation
- **Fix**: Use a local server (`python3 -m http.server`); or manually re-upload files

### MP4 not available, WebM only
- **Cause**: Browser lacks H.264 codec support (Firefox on Linux)
- **Fix**: Use Chrome/Safari/Edge, or accept WebM format

## Recent Changes

### v3.0 — Channel-Based Architecture
- **Removed** Step 1 (Project Setup) — editor opens directly
- **Replaced** lane system (`S.lanes`) with 4-channel system (`S.channels = {A, B, C, D}`)
- **Added** layout switcher in header (Full / Split / Quad)
- **Added** dynamic timeline with per-channel tracks, "+" buttons, and drag-and-drop
- **Added** multi-image intro/outro with per-image duration sliders
- **Fixed** preview jittering (seek threshold increased to 0.15s)
- **Fixed** outro display (corrected `maxChDur` reference)
- **Fixed** audio missing from export (cloned elements for `createMediaElementSource`)
- **Fixed** library audio CORS (fallback to direct URL for `<audio>` element)
- **Cleaned up** dead CSS (~180 lines), dead JS backward-compat functions (~50 lines)

### v2.0
- **Text Overlay**: Add customizable text with font size, color, position, style, and background options
- **Improved Intro/Outro**: Larger dropzones with thumbnail previews, range sliders for duration
- **Carousel Settings**: UI controls for interval, position, size, and shape
- **Expanded Audio Library**: Added Chill and Cinematic categories plus Fluffing a Duck
- **Editor Modal**: Wider canvas (900px max-width, 450×800px display)

## Future Enhancements

- [ ] Color grading and brightness/contrast adjustments
- [ ] Speech-to-text subtitle automation
- [ ] Batch export to multiple platforms with watermark
- [ ] Cloud storage integration (Google Drive, Dropbox)
- [ ] Local AI music generator integration
- [ ] Plugin system for custom transitions/effects
- [ ] Real-time collaboration (WebRTC)

## Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Make your changes
4. Test in Chrome, Firefox, and Safari
5. Commit and push
6. Open a Pull Request

### Code Style
- Vanilla JavaScript (no frameworks)
- Camel case for functions/variables
- Comments for complex logic sections
- Keep single-file structure (no bundling)

## License

MIT License – See LICENSE file for details

## Acknowledgments

- **Music**: Kevin MacLeod ([Incompetech](https://incompetech.com)) — Licensed under Creative Commons: By Attribution 4.0
- **Inspiration**: YouTube Shorts, TikTok video editors, and the 3D printing community
- **Tech**: Canvas API, MediaRecorder, Web Audio API

## Disclaimer

This tool is provided as-is. Use responsibly:
- Ensure you own or have permission to use all input videos and audio
- Respect platform terms of service when uploading content
- Attribution credits are auto-generated for Kevin MacLeod music; always verify they're included

## Contact & Support

- **Issues**: Open an issue on GitHub for bugs or feature requests

---

**Happy video making! 🚀**
