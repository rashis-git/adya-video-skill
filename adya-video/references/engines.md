# Engines — HyperFrames + Remotion (use each for what it's best at)

Two real engines. **Neither is a fallback.** Choose per video based on the animation the user wants — or use **both in one video**, each for the parts it does best. Always tell the user, briefly, what each is good at and ask what they're picturing, then route.

## What each is best at

**HyperFrames** — HTML/CSS/GSAP, single-file, seek-captured.
- Best for: voiceover-**synced** video, captions/subtitles synced to audio, title cards, kinetic typography, data/infographic scenes, audio-reactive visuals, fast scene-based promos, quick iteration.
- Built in: local TTS, transcription, caption sync, lint/validate/inspect, local render. It's the natural **master compositor** — it holds the VO + music + caption timeline and assembles everything.
- Reach for it when the job is "styled text + motion + synced audio, made fast."

**Remotion** — React components, frame-function render.
- Best for: complex/custom **signature** animation, spring physics, precise frame-level choreography, reusable parametric/data-driven templates, React-three-fiber 3D, component systems reused across many videos.
- Reach for it when the user wants a *specific* animated moment that's hard or fiddly in CSS/GSAP, a polished reusable motion component, real physics, 3D, or data-driven templating at scale.

Both can do "nice motion graphics." The honest split is **effort and control**: HyperFrames = fast + audio-native + caption-native; Remotion = deeper control + springs/physics + 3D + reusable components.

## How to choose — ask the user (at frame planning)
Say what each is good at in a sentence, then ask something like:
> "Is there a specific moment you picture — something custom, physics-y, or 3D (I'd build that in **Remotion**) — or is this mostly synced motion-graphics, text, and captions (**HyperFrames**)? Or a mix, where one hero animation is Remotion and the rest is HyperFrames?"

Route on the answer:
- Mostly synced motion graphics / text / captions → **HyperFrames** (whole video).
- A standout custom/complex/3D animation, a reusable component, or a data-driven template → **Remotion** (whole video, or just that segment).
- Wants both → **hybrid** (below).

If the user has no view, recommend by video type: explainer/demo → HyperFrames; a launch with a "wow" hero moment → hybrid (Remotion hero + HyperFrames everything else).

## Hybrid — the recommended pattern (HyperFrames master + Remotion hero clips)
Keep **HyperFrames as the master timeline** (it owns VO, music, captions, final assembly) and let **Remotion render the hero animation segment(s)** as MP4 assets that drop into the HyperFrames timeline as video clips:
1. Build the Remotion segment at the **same resolution + fps** as the HF project (e.g. 1920×1080 @ 30). Render it to `assets/segment-hero.mp4` (muted / no baked audio).
2. In HyperFrames, place it as a video clip on its own track: `<video muted playsinline src="assets/segment-hero.mp4" data-start="…" data-duration="…" data-track-index="…">`, with VO/music/captions on their own tracks (see `hyperframes-build.md` video+audio rules).
3. Render the HF master → final MP4. HyperFrames composites the Remotion footage with everything else, perfectly synced to the voice.

**Alternative (sequential):** render each engine's part separately, `ffmpeg` concat them, then lay one continuous VO+music over the top. Use only when parts are cleanly back-to-back; the master-timeline approach above is better for sync.

**Match across engines or the seams break:** resolution, **fps (30)**, and color space. Mismatched fps causes judder at the join.

## Variety + brand still apply to both
Engine choice is independent of look. A Remotion segment must use **this video's unique palette + fonts** (from `design-system.md`), not a Remotion default, and the **Adya logo** is still the only constant. See `variety.md`.

## Mechanics
- HyperFrames build: `references/hyperframes-build.md`.
- Remotion build (setup, component, render): `references/remotion-build.md`.
