# HyperFrames build (Steps 4–7)

Always invoke the **`hyperframes`** skill itself for the framework rules — this file only adds the patterns and the gotchas that bite in practice. Before building, write a **unique per-project `design.md`** (this video's own palette + fonts — see `references/design-system.md`; there is no house brand) and copy the **Adya logo** into the project. The logo is the only constant.

## Project bootstrap
```bash
npx hyperframes init "<Topic>" --example blank --resolution landscape --non-interactive --skip-skills
# resolution: landscape (1920x1080) | portrait (1080x1920) | square (1080x1080)
cd "<Topic>" && npm install
cp <skill>/assets/adya-logo.webp ./assets/adya-logo.webp   # the one constant
# then WRITE a unique ./design.md for this video (palette + fonts) — see design-system.md; do NOT reuse a previous one
```

## Scene structure (what worked)
- One standalone composition (`index.html`, composition-id from the scaffold, usually `main`), 3–4 scenes as `.clip` divs, one root GSAP timeline registered on `window.__timelines["main"]`.
- Each scene is a full-frame layer: `.scene { position:absolute; inset:0; width:1920px; height:1080px; background:var(--bg); overflow:hidden; }` with an explicit `z-index` per scene (`#s1{z-index:1}…#s4{z-index:4}`).
- **Crossfade between scenes via overlap + alternating track indices.** Same `data-track-index` can't overlap, so alternate (s1=1, s2=2, s3=1, s4=2) and start each scene ~0.35s before the previous ends. Fade the incoming scene's opacity 0→1 at its start; because each scene has an opaque bg of the same color, the handoff is seamless even if timing is slightly off. Don't add exit animations except on the final scene — the next scene covering it IS the transition.
- Aim for 8–10 elements per scene (bg glow, ghost type, content, mono metadata in a corner, hairline). Empty frames read as broken.

## GSAP gotchas (these cause silent breakage — lint passes, video ships wrong)
1. **CSS `translate(-50%,-50%)` centering gets clobbered by GSAP.** If you center with `transform: translate(-50%,-50%)` and then GSAP animates `scale`/`rotation`/`x`/`y` on that element, GSAP overwrites the transform and the element jumps. Fix: remove the CSS translate and put `xPercent:-50, yPercent:-50` in **both** the `from` and `to` of the GSAP `fromTo`. Applies to centered cores, rings, and any `left:50%` node.
2. **`drawSVG` is a paid GSAP plugin — not in the free CDN.** For line/arc draw-ons, use `stroke-dasharray` = path length and animate `strokeDashoffset` from length → 0. Compute the length (line: hypotenuse; circle arc: `2πr`).
3. **Prefer `tl.fromTo()` over `tl.from()` inside `.clip` scenes.** `from()` uses `immediateRender` and can flash/skip during the capture engine's non-linear seek. `fromTo` is deterministic at every timeline position.
4. **Never stack two transform tweens on the same element at overlapping times.** A `y` entrance + a `scale` Ken Burns on one `<img>` will fight. Either combine into one `fromTo`, or split across a wrapper (animate wrapper opacity/position, animate the inner `<img>` scale).
5. **Don't rely on CSS `opacity:0` + a separate reveal tween for a sub-element.** If that tween doesn't apply (clip lifecycle / seek), the element stays invisible. Let the **scene-level** opacity fade carry its children in, and only animate sub-elements' entrances with `fromTo` (which sets their own start state).
6. **Ambient loops must be on the timeline** (`tl.to(..., {yoyo:true, repeat:N})`), never bare `gsap.to()` — bare tweens run on wallclock and don't render in capture. Use finite `repeat` (never `repeat:-1`).
7. **z-order for diagram frames:** connector lines (SVG) go *below* the node cards and the core, so lines tuck under the opaque boxes and meet the core's edge cleanly. A bug we hit: an SVG with `z-index:1` painted lines *on top of* the cards (slicing through label text) because the cards were `z-auto`. Give the SVG `z-index` below the cards (cards z3, core z4, lines z2, scrim z1, bg image z0).

## Backgrounds / reusing Higgsfield plates
To composite an AI plate behind content: a wrapper `div` (z0) holding the `<img>` (`object-fit:cover`), a radial **scrim** div over it (`z1`, e.g. `radial-gradient(circle at 50% 52%, rgba(8,12,20,0.45) 0%, rgba(8,12,20,0.90) 60%)`) to keep text legible, content above. Give the image a slow Ken Burns (`fromTo scale 1 → 1.06`). Mark the wrapper/scrim/oversized-ghost decoratives with `data-layout-ignore` (or `data-layout-allow-overflow`) so `inspect` stays clean for intentional bleed.

## Voiceover timing (retime scenes to the audio, not the reverse)
1. Generate VO lines (`scripts/elevenlabs_tts.sh`) and record each duration.
2. Place audio clips back-to-back from ~0.2s on one audio track. Set each `<audio>` `data-start`/`data-duration`; `src` points at the mp3. **Adjacent clips on the same track must not touch exactly** — the framework counts `end == next start` as an overlap and errors. Trim each clip's `data-duration` ~0.03–0.04s short of the next clip's start (you're only cutting trailing silence, inaudible).
3. Set each scene to start ~0.3–0.35s before its line and end after it (overlap the prior scene by 0.35 for the crossfade). Update the scene `data-start`/`data-duration`, the root `data-duration` (= last scene end), and the `S2/S3/S4` start constants in the script (internal element offsets are relative to those, so they move automatically).

## Verify, then render (Gate 2 before render)
```bash
npx hyperframes lint                 # 0 errors (the "gsap_studio_edit_blocked" warning is benign)
npx hyperframes validate             # WCAG AA contrast — fix failing text colors within this video's palette
npx hyperframes inspect              # 0 layout issues, or mark intentional overflow
npx hyperframes snapshot --at 1.8,6,10.5,14   # hero frames; read the contact-sheet.jpg yourself
# --- show stills to user, get approval ---
npx hyperframes render --output "<Topic>_<len>.mp4"
ffprobe -v error -show_entries format=duration:stream=codec_type -of default=nw=1 "<Topic>_<len>.mp4"
```
Render time ≈ a couple minutes for ~15s. The render log's trailing "Xs" is elapsed time, not video length — confirm real duration with `ffprobe`.
