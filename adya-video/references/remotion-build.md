# Remotion build (first-class engine)

Remotion is a full engine, not a fallback — see `references/engines.md` for when to pick it vs HyperFrames vs hybrid. Use it for complex/custom signature animation, spring physics, precise frame-level control, React-three-fiber 3D, or reusable parametric/data-driven templates. Invoke the **`remotion`** skill for framework specifics; this file is the Adya-specific wiring.

The Adya-specific pieces are the same regardless of engine:
- **Design:** there is no house brand — apply **this video's** unique palette + fonts (`references/design-system.md`); the **Adya logo** (`assets/adya-logo.webp`) is the only constant and must appear.
- **Script & voice:** `references/script-style.md` (banned words, Adya facts, pronunciation, ElevenLabs voices via `scripts/elevenlabs_tts.sh`).
- **Variety:** honor `references/variety.md` — a unique look, logged to the ledger.

## Setup (on demand — only when a video uses Remotion)
```bash
npx create-video@latest        # scaffold (Blank/Hello World template)
cd <project> && npm install
npm run dev                    # Remotion Studio preview
```
Node 18+ covers it. Set the composition to the video's target **1920×1080 @ 30fps** (or the chosen aspect) in `Root.tsx`.

## Audio timing
Measure the VO mp3 durations (`scripts/elevenlabs_tts.sh dur ...`) and drive sequence lengths from them: a `<Sequence durationInFrames={Math.round(seconds * fps)}>` per beat. If Remotion is the whole video, add the VO + music as `<Audio>` tracks; if Remotion is only a hero segment in a hybrid, render it muted and let HyperFrames carry the audio.

## Render
**Whole video:**
```bash
npx remotion render <entry> <CompId> out/video.mp4 --codec h264
ffprobe -v error -show_entries format=duration:stream=codec_type -of default=nw=1 out/video.mp4
```
**Hero segment for a hybrid** (muted, exact fps/res so it drops cleanly into the HF timeline):
```bash
npx remotion render <entry> <HeroCompId> "<HF-project>/assets/segment-hero.mp4" --codec h264
```
Then place it in the HyperFrames master as a `<video>` clip (see `references/engines.md` → Hybrid).

## Match these or seams/sync break
Resolution, **fps (30)**, and color space must match the HyperFrames project when combining. Mismatched fps judders at the join.
