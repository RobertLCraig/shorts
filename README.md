# Bambu Shorts Studio

A powerful, web-based video editing tool designed specifically for creating short-form vertical videos (9:16 aspect ratio) optimized for YouTube Shorts, TikTok, Instagram Reels, and other social platforms. Perfect for 3D printing creators, product demos, and time-lapses.

## Features

### 🎬 Core Video Editing
- **Multi-Lane Montage**: Drag and drop videos into main/secondary lanes with support for:
  - **Single Layout**: One video full-screen
  - **Split-Horizontal**: Two videos stacked vertically with adjustable gap
  - **Picture-in-Picture**: Primary video full-screen with secondary in the corner
- **Flexible Video Pool**: Upload multiple videos, reassign them to lanes in real-time
- **Duration Balance**: Visual feedback on lane duration imbalance with smart suggestions

### 🎨 Content Enhancement
- **Intro/Outro Images**: Add custom opening/closing images with:
  - **Canvas Editor**: Drag to position, scroll to zoom, scale and arrange images at max viewable size
  - **Duration Control**: Set custom duration for each intro/outro (1–10 seconds)
  - **Live Preview**: See your placement before export
- **Carousel Overlay**: Rotating product images with configurable:
  - Position (top-left/right, bottom-left/right)
  - Rotation interval (2–5s)
  - Size and shape (small/medium/large, rounded/circle/square)
- **Thumbnail Generator**: Grab a frame from preview or upload custom thumbnail

### 🎵 Audio Management
- **Local Audio Upload**: Add multiple audio tracks with per-track volume control (sliders)
- **Built-in Audio Library**: Curated royalty-free music from Kevin MacLeod (Incompetech):
  - Upbeat tracks (Monkeys Spinning Monkeys, Sneaky Snitch, etc.)
  - Lofi ambient (Local Forecast, Mining by Moonlight, After Lemons)
  - One-click add-to-project with automatic attribution
- **Audio Mixing**: All tracks mixed and exported together

### 🎯 Export & Distribution
- **Multi-Format Export**: MP4 (if supported) or WebM with configurable CRC/bitrate
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
- **Save/Load JSON**: Export project configuration (video layout, audio, metadata, settings)
- **One-Click Restore**: Re-upload videos and re-add audio; lane assignments and metadata are preserved
- **Persistent Settings**: Crop mode, speed, quality (CRF), dimensions

### ⚙️ Advanced Settings
- **Crop Modes**: Center-crop, blur-padding, or stretch videos to fit frame
- **Speed Control**: 1x–4x playback speed (affects frame count and export time)
- **Video Quality (CRF)**: 18 (highest) to 28 (lowest) for MP4/WebM export
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

1. **Upload Videos**: Drag video files onto the upload zone or click to browse
2. **Arrange Lanes**: Drag videos from the pool into main/secondary lanes
3. **Add Audio**: Upload local audio files or pick from the built-in library
4. **Add Extras**: 
   - Upload intro/outro images and use the canvas editor to position them
   - Add carousel overlay images for product showcases
5. **Preview**: Play through the montage and adjust settings in real-time
6. **Export**: Click "Process & Export" to render the final video (takes 1-5 min depending on duration)
7. **Distribute**: Download video, share to platforms with auto-formatted descriptions, or save project for later

## Usage Examples

### Example 1: 3D Print Timelapse with Music
1. Upload 2–3 timelapse videos
2. Add them to the main lane in sequence
3. Pick "Monkeys Spinning Monkeys" from the audio library
4. Add an intro image (e.g., product render) with 2-second duration
5. Export and upload to YouTube Shorts with auto-generated hashtags

### Example 2: Product Comparison (Split-Screen)
1. Upload two comparison videos
2. Select **Split-Horizontal** layout
3. Drag one video to main lane, one to secondary
4. Add carousel overlay with product renders
5. Set up descriptions for all platforms
6. Export and batch-download the video + ZIP

## Technical Details

### Architecture
- **Single-file HTML app**: No build process required; just open in a browser
- **Canvas-based rendering**: All video composition happens on a `<canvas>` element
- **MediaRecorder API**: Frame-level rendering with automatic capture for precise export quality
- **Web Audio API**: Audio mixing and synchronized playback during export

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
└── .git/                     # Git repository
```

## Key Sections (video2short.html)

1. **HTML** (Lines 1–1960): 
   - Three-step workflow: Project Setup → Editor → Export
   - Modal dialogs for audio library and image editor
   - Settings panels for video, carousel, audio, and intro/outro

2. **CSS** (Lines 11–1618):
   - Dark theme with green accents
   - Responsive grid layout
   - Animations and transitions

3. **JavaScript** (Lines 2008–3203):
   - **State Management** (`S`): Global state for videos, audio, settings
   - **Navigation** (`goStep`, `renderAll`)
   - **Video Logic** (`loadVideos`, `setupLaneDropTarget`, `renderLanes`)
   - **Playback Engine** (`computeMontageDuration`, `resolveTimeInLane`, `drawFrame`)
   - **Export Pipeline** (`processAndExport`, `setupExportPage`)
   - **UI Helpers** (`toast`, `esc`, `fmtTime`, etc.)
   - **Editor** (`openIOEditor`, `drawEditor`, `ioEditorSave`)

## API & Dependencies

### External CDN Resources
- **JSZip** (3.10.1): ZIP file generation for batch downloads
  ```html
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
  ```
- **Google Fonts**: DM Sans, IBM Plex Mono, Instrument Serif

### Web APIs Used
- **Canvas 2D**: `getContext('2d')`, drawing, image composition
- **MediaRecorder**: Frame + audio capture for export
- **Web Audio API**: Audio context, gain nodes, mixing
- **Fetch API**: Audio library downloads, CORS-aware fallback
- **IndexedDB** (optional future): Project persistence
- **File API**: Blob/File handling, Object URLs

## Configuration & Settings

All settings are stored in the global `S` object:

```javascript
S.cropMode       // 'crop' | 'padding' | 'stretch'
S.speed          // 1 | 1.5 | 2 | 3 | 4
S.crf            // 18–28 (video quality, lower = higher quality)
S.layout         // 'single' | 'split-h' | 'pip'
S.meta           // title, desc, fileUrl, shopUrl, tags
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

## Future Enhancements

- [ ] Text overlay support (titles, captions, watermarks)
- [ ] Color grading and brightness/contrast adjustments
- [ ] Speech-to-text subtitle automation
- [ ] Batch export to multiple platforms with watermark
- [ ] Cloud storage integration (Google Drive, Dropbox)
- [ ] Mobile app (React Native / Capacitor)
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
- **Email**: [your-email@example.com](mailto:your-email@example.com) (optional)
- **Discord**: [Join our community](https://discord.gg/your-invite) (optional)

---

**Happy video making! 🚀**
