# Background music

Every finished video should have a music bed unless the user opts out. Ask at intake: **"Do you have a music track to use, or should I source one?"**

## Mode A — user provides a track
They drop an mp3/wav into the project (or point to a path). Use it.

## Mode B — skill sources one
There's no music *generation* skill, so source rather than invent:
- If the user has a local music library/folder, pick a track that matches the energy (launch = driving/cinematic; explainer = calm/underscore; demo = light/neutral).
- Otherwise, ask the user to grab a royalty-free track (Pixabay Music, YouTube Audio Library, Free Music Archive) and drop it in — these can't be fetched silently. Suggest a mood so they pick fast.
- If the user has a Mubert key and wants generated music, that's a per-person paid option (out of default scope) — see the higgsfield/codebase notes; most of the time a free library track is faster.

## Prepare the bed (ffmpeg) — do this, don't wing the levels
Match length, set a quiet level under the voice, and fade in/out. HyperFrames owns playback so you can't GSAP-animate volume — bake the fades into the file:

```bash
# DUR = final video length in seconds; OUT_END = DUR - 1
ffmpeg -y -i music_raw.mp3 \
  -af "afade=t=in:st=0:d=0.6,afade=t=out:st=<OUT_END>:d=1.0,volume=0.14" \
  -t <DUR> audio/music_bed.mp3
```
- `volume=0.14` puts the bed well under the voiceover. Target feel: music ≈ −28 to −30 LUFS, voice ≈ −14 LUFS (the voice should clearly sit on top). Nudge volume down to ~0.10 if the track is dense, up to ~0.18 if sparse.
- If there's no voiceover (rare), the bed can sit louder (~0.4–0.6).

## Add it to the composition
One `<audio>` clip on its own track, separate from the VO track:
```html
<audio id="music" data-start="0" data-duration="<DUR>" data-track-index="4" src="audio/music_bed.mp3" data-volume="1"></audio>
```
(Volume is already baked into the file, so `data-volume="1"`.) Keep it on a different `data-track-index` than the VO clips, and remember the no-touching rule only matters within a track — the single music clip spanning the whole video is fine.

## Sanity
After adding, the final `ffprobe` should still show one audio stream (HyperFrames mixes VO + music into the render). Listen on review: the voice must stay clearly intelligible over the bed. If it fights the voice, lower the `volume=` and re-prep.
