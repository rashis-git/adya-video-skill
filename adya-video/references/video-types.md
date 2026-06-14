# Video types (pick at intake)

Ask which of these the user wants — each has a different plan, energy, visual approach, and cost. Don't default silently; the type changes everything downstream.

**Universal add-ons (offer on EVERY type, user's add/skip call):** **background music** (`references/music.md`) and **subtitles/captions**. Both are optional and available regardless of type — always ask; never assume.

## 1. Product Launch — "make it sexy"
High-energy, cinematic, imagery-forward. This is the one that should look premium and animated.
- **Energy / rhythm:** high. SLAM-proof-SLAM-hold, or slow-build → PEAK → resolve. Big reveals, shader transitions, kinetic typography, depth.
- **Visuals:** imagery-led, not just motion graphics. Use Higgsfield cinematic plates / `generate-image` hero shots (gated — confirm spend), full-bleed image scenes with parallax/Ken Burns, glow and particle motion. Typography is large and expressive.
- **Length:** 20–45s. **Cost:** higher (AI imagery is the point here) — still gate Higgsfield and prefer reusing/`generate-image` first.
- **Skills:** `hyperframes` + `higgsfield-generate`/`generate-image` + shader transitions (see `gsap`/hyperframes transitions). Optionally `higgsfield` image-to-video for one hero clip if budget allows.
- **Use when:** announcing a product, a teaser, a hype moment, a homepage hero.

## 2. Context / Product Explainer — concept-driven motion graphics
What we've built so far (GTM Agent, ESA). Clarity and narrative over spectacle.
- **Energy / rhythm:** medium. hook → solution → proof → CTA.
- **Visuals:** motion graphics, diagrams (mermaid/`infographics`), node/flow systems, clean cards, one focal accent per scene. Mostly free; an optional single AI plate for the CTA.
- **Length:** 15–30s. **Cost:** ~free.
- **Skills:** `hyperframes` (+ optional one Higgsfield/`generate-image` plate).
- **Use when:** explaining what something is, how it works, the thesis.

## 3. Product Demo — show the actual UI
Walkthrough of real screens and the features the user wants to highlight.
- **Energy / rhythm:** medium, clarity-first. Problem → feature beats (one screen each) → CTA.
- **Visuals:** real screenshots or a screen recording, in device frames, with Ken Burns, callouts (markers/arrows), floating-UI parallax. If a live URL, use `website-to-hyperframes` to capture.
- **When the team shoots footage and hands it over (the common case):** ALWAYS edit it FIRST with `video-use` — transcribe, cut filler/mistakes/dead air, tighten the pacing — and only THEN layer b-rolls, callouts, captions, animations, and a branded intro/outro on top. Never skip the cleaning pass and never animate over a raw, uncut take. (Same order applies to the tutorial/talking-head type.)
- **Length:** 30–90s. **Cost:** ~free (unless mocking up screens with `generate-image`/frontend skills).
- **Needs from user:** UI assets (screenshots/URL/recording) + features in priority order. See `product-explainer.md`.
- **Use when:** demonstrating the product in action to a buyer/developer.

## 4. Tutorial / talking-head — a real person on camera
Someone records themselves explaining a topic (face + voice); you edit it, add b-rolls, captions, and the face-to-corner bubble.
- **Energy / rhythm:** conversational, paced by the speaker. Cut tight; b-roll keeps it visual.
- **Visuals:** the recording itself + b-roll overlays. Signature move: b-roll fills the screen while the speaker shrinks to a **circular PiP bottom-right**. Burned captions.
- **Length:** 1–5 min typical. **Cost:** ~free (b-roll mostly user/screen/`generate-image`; Higgsfield clips optional).
- **Master tool:** `video-use` (footage editing) — keep the person's **real voice**, don't TTS it. Optional HyperFrames intro/outro + logo.
- **Needs from user:** the recording + any b-roll + key points. Full workflow + the face-bubble mechanics in **`references/talking-head.md`**.
- **Use when:** a founder/teammate explains something to camera, a how-to, a personal take.

## Plan accordingly
After the type is chosen, build the beat plan to match its rhythm and visual approach (`references/hyperframes-build.md` for the mechanics, `references/variety.md` so it doesn't clone the last video). A launch video and an explainer on the *same topic* should look noticeably different — different energy, different visual language.
