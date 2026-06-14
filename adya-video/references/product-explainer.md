# Product explainer videos (Step 3b)

When the video shows a real Adya product/agent UI rather than a pure brand message, you need raw material before scripting. Collect it, then turn features into beats.

## Collect from the user
1. **UI assets** — screenshots/exports of the screens to feature (PNG/JPG), or a live URL. If a URL, the `website-to-hyperframes` skill can capture it into usable panels.
2. **Features to showcase** — in priority order. For each: the one-line benefit (not just the feature name) and any exact copy/claim to include.
3. **Optional** — a logical order/flow (onboarding → action → result), and the target persona (developer / GSI / CxO) so the framing matches `references/script-style.md`.

Ask for these together; don't start building without the screens.

## Turn features into beats
- One feature ≈ one beat. Open with the problem/hook, then 2–4 feature beats, then CTA. Cap at what fits the length (15s ≈ 3 short beats; 30s ≈ 4–5).
- Each beat pairs a **screen** with a **one-line benefit caption** in Adya voice. The voiceover narrates the benefit; the screen is the proof.
- Lead each beat with the outcome ("Approve a post in two clicks"), not the mechanic.

## Give screenshots cinematic motion (never embed a flat image)
Flat screenshots read as dead. Apply one treatment per screen (see the `hyperframes` motion-principles for code):
- **Device frame** — wrap in a laptop/browser/phone shell (border-radius + box-shadow).
- **Ken Burns** — slow `scale 1 → 1.05` over the beat.
- **Floating UI parallax** — extract one key element (a button, a metric) onto its own layer and drift it at a different depth.
- **Scroll/clip reveal** — clip the image to a viewport window and animate `y` to imply scrolling.
- **Callout** — a teal marker/circle or hairline pointer to the element the caption is about (deterministic CSS/SVG, seekable).
Remember the GSAP rule: don't stack two transform tweens on one `<img>` — animate a wrapper for position and the inner image for scale.

## Keep it honest
Don't claim features the product doesn't have. If a screen is a mockup/aspirational, frame it as "what's coming," not shipped. Use real metrics only if confirmed (see script-style grounding).
