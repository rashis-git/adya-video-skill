---
name: adya-video
description: >-
  Create an on-brand Adya marketing or product-explainer video from a topic — writes the script, generates a human ElevenLabs voiceover, builds an animated HyperFrames (or Remotion) composition, renders an MP4, and iterates with the user. Optional cinematic AI visuals via Higgsfield (pay-as-you-go). Use this whenever someone wants to make an Adya video, a GTM/agent promo, a product walkthrough, a launch teaser, a social clip, or "turn this topic/feature into a video" — even if they don't say the word "video" explicitly (e.g. "can we make something to show the Recruitment Agent" or "I need a 15s clip for LinkedIn about AGP"). If the required skills aren't installed, this skill walks the user through installing them.
---

# Adya Video

Turn a topic into a finished, on-brand Adya video. This skill is an **orchestrator**: it composes other skills (HyperFrames, ElevenLabs, Higgsfield) and bakes in Adya's brand, voice, and the production discipline learned from real builds. The pipeline is the easy part — the value here is that every output looks and sounds like *Adya*, and that expensive steps are gated so nobody burns credits by accident.

**Two engines, used for what each is best at.** HyperFrames (HTML/CSS/GSAP — fast, audio/caption-native, the natural master compositor) and Remotion (React — complex/custom animation, spring physics, 3D, reusable components). Choose per video by the animation the user wants, or use **both** in one video (a Remotion hero segment inside a HyperFrames master). Always tell the user what each is good at and ask what they're picturing — see **`references/engines.md`**. Neither needs a paid API to render.

**This skill routes to the wider toolbox.** Generating graphics is the core path, but video *editing* (existing footage), asset creation (images, diagrams, UI mockups), and content polish each have a best-fit skill. Read **`references/toolbox.md`** for the job→skill decision table — consult it whenever a job isn't "generate motion graphics from scratch."

## How this skill works (the loop)

1. **Setup check** — confirm the environment + required skills + keys are ready. Gate everything on this.
2. **Intake** — **replicate-or-fresh** (anti-sameness), **video type** (launch / explainer / demo / tutorial-talking-head), topic, **context grounding**, **design system** (unique colors/fonts — no default), channel/length, voice, and two universal add/skip choices: **background music** and **subtitles** (offered on every video).
3. **Script** → user approves *before* any audio is generated.
4. **Frame plan + engine choice** — beats + scenes; unique design; pick HyperFrames / Remotion / hybrid by the animation the user wants.
5. **Voiceover, music & subtitles** — ElevenLabs (human voice), measured for timing; add a music bed and/or subtitles if the user wants them (both optional, every type).
6. **Build + verify** — build in the chosen engine(s), lint/validate/inspect, snapshot the hero frames → user approves *before* the full render.
7. **Render** → MP4.
8. **Review loop** — ask for specific input, iterate.
9. **Optional Higgsfield upgrade** — only on request, cost-gated.

Three approval gates exist on purpose (script → storyboard → Higgsfield). They protect the user's time and money. Never skip them silently.

---

## Step 1 — Setup check (always do this first)

A teammate's machine may not match the author's. Before anything else, read **`references/setup.md`** and run the checks it describes. In short, you need: Node 18+, ffmpeg, the HyperFrames skills, an ElevenLabs API key, and (only if AI visuals are wanted) the Higgsfield CLI logged in.

If a **skill** is missing, offer to install it and run the command on a yes — the install commands are in `references/setup.md`. If a **system binary** (ffmpeg) or **API key** is missing, you can't silently install it; show the exact command/instructions and wait. Don't proceed to render steps until the checks pass — a missing ffmpeg or key fails late and wastes the user's time.

Keys are **per-person** (each teammate brings their own ElevenLabs key and Higgsfield login). Never hardcode a key into the skill or a committed file.

## Step 2 — Intake

Ask only what you can't infer. Defaults in brackets. **Lead with the first two — they shape everything.**

- **Replicate or fresh?** (ask FIRST) — replicate a previous video (match its look, swap content), adapt one, or build **completely fresh** (deliberately unlike anything before). This is the anti-sameness control: read **`references/variety.md`** and, in fresh mode, follow its divergence checklist so the new video doesn't clone the last one. Don't reuse a prior video's palette emphasis, motion, layout, or assets in fresh mode.
- **Video type** — **launch** (heavily animated, cinematic, imagery-led — "make it sexy"), **explainer** (concept-driven motion graphics), **demo** (real UI screens + features), or **tutorial / talking-head** (a real person on camera, edited with b-rolls + captions + the face-to-corner bubble — `video-use` master, keep their real voice → `references/talking-head.md`). Each has a different plan — read **`references/video-types.md`**.
- **Topic / goal** — what's it about? The one thing a viewer should remember?
- **Context grounding** — do we already have facts for this product/topic (Adya knowledge base / project docs)? If yes, ground from them. **If not, ask the user for the product content** — what it is, key features/benefits, proof points, target persona, must-say claims — *before* scripting. Never invent product facts.
- **Design system** — colors, fonts, mood, any references? **There is NO default palette or font.** If the user says "you decide," invent a *unique* scheme for this video (never teal/Inter or a prior video's look). The **only constant in every video is the Adya logo** (`assets/adya-logo.webp`). See **`references/design-system.md`**.
- **Production path** — generate from scratch (HyperFrames, default), edit existing footage (`video-use`), or hybrid. See `references/toolbox.md`.
- **Channel & aspect ratio** — LinkedIn/X/website [landscape 1920×1080], Stories/Reels [vertical 1080×1920], feed [square 1080×1080].
- **Length** — [15s] (≈35 words). Launch/demo often 30–60s.
- **Background music (offer on every video — add or skip):** does the user want a music bed? If yes, do they have a track or should you source one? See **`references/music.md`**.
- **Subtitles (offer on every video — add or skip):** does the user want on-screen captions? Available on all four types (synced to the voiceover for generated videos, burned from the transcript for footage). See Step 5.
- **Voice** — [Sarah]. Alternatives in `references/script-style.md`.

Don't batch-interrogate. Lead with replicate-or-fresh + type; infer the rest and state your assumptions.

## Step 3 — Script (Gate 1)

Write a tight script in Adya's voice. Read **`references/script-style.md`** for the voice rules, the banned-word list (from Rules.md), the beat structure, and how to ground Adya facts (AGP/MAN/ESM, the agents, positioning) so a teammate doesn't need to know them.

Optionally run the draft through the `de-ai` skill so it reads human, not machine — it pairs with the human ElevenLabs voice. Present the script as plain text with the beat breakdown. **Stop and get approval before generating audio** — ElevenLabs costs characters and re-voicing an unapproved script is waste.

### Step 3b — UI intake (for demo videos, and any video that shows real UI)

For a **demo** video (or an explainer/launch that shows real screens), collect raw material before scripting:
- **UI images / screenshots** (or a live URL — `website-to-hyperframes` can capture it; or screen-recording footage → `video-use`). If there's no real UI and one is needed, you can mock it up with `frontend-design`/`taste-skill` (see `references/toolbox.md`).
- **Features to showcase**, in priority order, and any specific copy/claims.
Read **`references/product-explainer.md`** for how to turn features into beats and give screenshots cinematic motion (device frames, Ken Burns, floating-UI parallax, callouts) instead of flat embeds.

## Step 4 — Frame plan

Plan beats before writing HTML. **In fresh mode, first apply the divergence checklist in `references/variety.md`** so this video's motif, motion, layout, and energy differ from recent ones — state the choices to the user. In replicate mode, mirror the chosen prior video instead. Match the rhythm and visual approach to the chosen **video type** (`references/video-types.md`): a *launch* builds to a dazzling peak and leans on imagery; an *explainer* follows `hook → solution → proof → CTA`; a *demo* walks screen-by-screen. Generate a **unique per-project `design.md`** from the design system decided at intake (`references/design-system.md`) — never a default Adya palette or font. Place the **Adya logo** (`assets/adya-logo.webp`) in every video; it is the only constant. Name each beat's job and transition. **Choose the engine(s)** here per **`references/engines.md`**: ask the user whether any moment should be a custom/physics/3D animation (Remotion) vs synced motion-graphics + captions (HyperFrames), or a mix; then build with the right tool for each part. Mechanics: `references/hyperframes-build.md` and `references/remotion-build.md`.

## Step 5 — Voiceover, music & subtitles

Generate the VO with the bundled script: `scripts/elevenlabs_tts.sh`. It reads `ELEVENLABS_API_KEY`, generates one MP3 per line, and prints durations (you need these to time the scenes). For **names/acronyms**, respell phonetically so the voice says them right — e.g. "Adya" → write **"Aadhya"** (pronounced AHD-yaa); "GTM" → "GTM"; "AI" → "AI". See `references/script-style.md` for the pronunciation table.

If the user has no ElevenLabs key and wants to proceed free, fall back to local Kokoro TTS (`npx hyperframes tts`, more robotic) — note the quality tradeoff.

**Background music (if the user opted in — offer on every video):** prepare a bed per **`references/music.md`** — their track or a sourced one, length-matched and ducked under the voice with ffmpeg, on its own audio track. Match the mood to the type (launch = driving/cinematic, explainer = calm underscore, demo/tutorial = light/neutral). Skip if they opted out.

**Subtitles (if the user opted in — offer on every video):** add synced on-screen captions in this video's palette, kept clear of any talking-head bubble.
- Generated-VO videos → sync captions to the script/voiceover timing (invoke the `hyperframes` skill's captions reference for synced styling).
- Footage videos → burn subtitles from the transcript with `video-use`.
Skip if they opted out.

## Step 6 — Build + verify (Gate 2)

Build the HyperFrames composition following **`references/hyperframes-build.md`** — it contains the scene structure, the crossfade-via-tracks pattern, the GSAP gotchas that cause silent breakage (centering, SVG draw-ons, intentional-overflow markers), and how to retime scenes to the measured VO durations. Then:

```bash
npx hyperframes lint        # 0 errors required
npx hyperframes validate    # WCAG contrast — fix any failing text color
npx hyperframes inspect     # 0 layout issues, or mark intentional overflow
npx hyperframes snapshot --at <hero times>   # capture stills
```

Show the user the hero-frame stills (or a silent draft) and **get approval before the full render** — rendering is the slow step. Read the contact sheet yourself first and fix anything obviously off.

## Step 7 — Render

```bash
npx hyperframes render --output "<Topic>_<length>.mp4"
```
Verify the result with `ffprobe` (duration + audio stream present) and open it for the user. Then **append a one-line style fingerprint to the ledger** (`.adya-video-ledger.md` in the videos' parent folder) per `references/variety.md`, so future "fresh" videos have something concrete to diverge from.

## Step 8 — Review loop

Ask for **specific** input ("voice / pacing / a specific frame / colors / copy"). Most fixes are free edits + re-render. Keep prior versions (don't overwrite) so the user can compare. Save versioned filenames (`_v2`, `_v3`).

## Step 9 — Optional Higgsfield upgrade (Gate 3, pay-as-you-go)

Only when the user explicitly wants AI imagery beyond motion graphics. Read **`references/higgsfield.md`** first — it enforces the cost discipline: prefer **image over video** (video is far more expensive), reuse already-generated assets across scenes, warn on credit cost (a 2k GPT-Image-2 plate ≈ 7 credits), and composite plates *behind* content with a scrim so text stays legible. Confirm spend with the user before each generation.

---

## Reference map

| Read this | When |
|---|---|
| `references/setup.md` | Always, Step 1 — env, skill installs, keys |
| `references/variety.md` | Step 2 + 4 — replicate vs fresh, the divergence checklist, the style ledger (anti-sameness) |
| `references/video-types.md` | Step 2 — launch vs explainer vs demo, each with its plan |
| `references/toolbox.md` | Whenever the job isn't "generate from scratch" — job→skill routing (video editing, assets, diagrams, UI mockups, polish, localization) |
| `references/script-style.md` | Step 3 — voice, banned words, beats, Adya facts, pronunciation |
| `references/music.md` | Step 5 — background music: provide or source, ffmpeg bed prep, levels |
| `references/product-explainer.md` | Step 3b — UI images/screens → scenes (demo videos) |
| `references/talking-head.md` | Tutorial / talking-head type — video-use editing, b-rolls, face-to-corner PiP bubble, captions |
| `references/engines.md` | Step 4 — HyperFrames vs Remotion strengths, how to choose/ask, the hybrid pattern |
| `references/hyperframes-build.md` | Steps 4–7 — HyperFrames scene patterns, GSAP gotchas, retiming, render |
| `references/remotion-build.md` | Step 4–7 — Remotion engine: setup, render, hero-segment for hybrid |
| `references/higgsfield.md` | Step 9 — cost-disciplined AI visuals |
| `references/design-system.md` | Step 2 + 4 — NO house palette/fonts; decide or invent a unique design per video; logo is the only constant |
| `assets/adya-logo.webp` | The one invariant — placed in every video |
| `scripts/elevenlabs_tts.sh` | Step 5 — generate + measure VO |

## Principles (why the gates exist)

- **Free by default.** HyperFrames graphics + reused assets cost nothing. Only ElevenLabs and Higgsfield cost money, and both are gated.
- **Approve before you spend.** Script before audio; storyboard before render; explicit confirm before Higgsfield.
- **Unique every time, logo always.** No house palette, fonts, or template — invent or take the design per video (`references/design-system.md`). The Adya logo is the only constant and must appear in every video. Voice/grounding rules live in `references/script-style.md`.
- **Honest about state.** If a step is skipped or a render is over length, say so.
