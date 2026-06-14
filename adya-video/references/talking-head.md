# Tutorial / talking-head videos (a real person on camera)

When the deliverable is a person explaining a topic on camera — their **own face and voice** — edited with b-rolls, captions, and a face-to-corner picture-in-picture (PiP) bubble. This is **footage editing**, so the master tool is **`video-use`** (built for talking heads, tutorials, montages, b-roll, subtitles), not generation. HyperFrames/Remotion are only for added title cards / intro-outro and (optionally) the circular PiP compositing. The Adya logo is still the one constant.

**Keep the person's real voice — do NOT replace it with ElevenLabs TTS.** The generated-voice path is for from-scratch videos; here the authenticity is the point.

## Inputs from the user
- The **recording** (talking-head, or screen + webcam, or just webcam).
- Any **b-roll** they have (screen recordings, clips, images) — or let the skill source/generate it.
- The **topic / key points** — helps place b-roll and write captions / lower-thirds.

## Workflow (video-use as master)
1. **Transcribe** the recording (`video-use` / `watch`) → timestamped transcript. This drives the cuts, b-roll placement, and captions.
2. **Cut** filler, stumbles, dead air, long pauses → a tight talking track.
3. **B-roll plan:** for each concept/feature the speaker mentions, overlay a b-roll at that timestamp. Sources, cheapest first: user clips / screen recordings → `generate-image` stills with Ken Burns → stock → Higgsfield clips (gated, `higgsfield.md`).
4. **Two layout states (this is the move you want):**
   - **A — speaker primary:** face full-frame (or large), talking to camera.
   - **B — b-roll primary + face bubble:** b-roll fills the frame and the speaker shrinks to a **circular PiP in the bottom-right** (~300px diameter at 1080p, subtle ring + soft shadow, ~64px margin). Animate the face scaling/moving A→B when the b-roll enters, and back to A when it leaves.
5. **Captions:** burn subtitles (`video-use`) — essential for silent autoplay. Optional lower-third name/title.
6. **Branding + audio:** Adya logo in a corner throughout; optional HyperFrames intro title card + outro CTA with the logo, stitched onto the edited cut. Add a quiet music bed under the real voice (`music.md`, lower than usual since there's already speech).
7. **Export, review, iterate** on cut points, b-roll choices, and PiP timing.

## The circular face-bubble — how to actually do it
Prefer `video-use`'s conversational overlay/PiP if it supports a circular crop. For precise control, two reliable ways:
- **ffmpeg:** crop the webcam to a square, apply a circular alpha mask, scale, and `overlay` it bottom-right over the b-roll for the segments where state B is active; animate position/scale via overlay/zoompan expressions.
- **HyperFrames composite:** b-roll as a full-frame `<video>` clip; the speaker as a second `<video>` clip styled `border-radius:50%` (circle) bottom-right; GSAP-animate its scale/position for the A↔B transitions; keep the original audio on its track. HyperFrames renders the composite — best when you want branded motion around the bubble.

Match **resolution + fps** across any stitched/composited pieces (1080p at the recording's fps) or the seams judder.

## Honest notes
- Editing can't fully fix a bad source — if the recording has bad audio (hiss, echo) or poor framing, say so up front.
- This path overlaps "demo" when the recording is a screen-share walkthrough; the difference is whether a face is on camera. Both use `video-use` as master.
