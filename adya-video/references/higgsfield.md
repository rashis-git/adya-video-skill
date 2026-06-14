# Higgsfield AI visuals (Step 9 — optional, pay-as-you-go)

Use only when the user explicitly wants AI-generated imagery beyond motion graphics. For a governance-first B2B brand, clean HyperFrames motion graphics is usually the right format — Higgsfield is for a hero plate or a "wow" shot, not the whole video. Invoke the **`higgsfield-generate`** skill for full model/flag detail; this file is the cost discipline.

## Cost discipline (real numbers)
- Credits are real money and small balances vanish fast: a **2k GPT-Image-2 plate ≈ 7 credits**. Video (image-to-video) costs **far** more than an image.
- **Always confirm spend before each generation.** Check `higgsfield account status` and tell the user the cost and remaining balance first.
- **Prefer image over video.** A single still plate composited behind content gets ~80% of the polish for a fraction of the cost.
- **Reuse generated assets.** One plate can serve multiple scenes (e.g. the same cosmic core behind both a "convergence" frame and the CTA). Don't regenerate what you already have.
- Cheaper paths when iterating: `Z Image` (fast/cheap), or 1k instead of 2k resolution.

## Generate a background plate
```bash
higgsfield account status     # confirm credits first
higgsfield generate create gpt_image_2 \
  --prompt "Abstract cinematic background for an enterprise AI brand film. Deep navy-black canvas, soft volumetric teal and indigo glow from a luminous core, faint concentric governance ring, subtle node mesh, particle dust, premium minimal, lots of dark negative space. No text, no logos, no letters." \
  --aspect_ratio 16:9 --resolution 2k --wait
# download the printed URL into the project:
curl -s -o assets/plate.png "<printed_url>"
```
Then composite per `references/hyperframes-build.md` (wrapper + scrim + Ken Burns), keeping a dark scrim so any overlaid text stays legible. Re-run `validate` to confirm contrast still passes over the brighter image.

## Access / billing
Per-person: each teammate uses their own `higgsfield auth login` and their own credits. Never assume a shared pool. If `higgsfield account status` shows too few credits for the requested generation, say so and let the user decide to top up or stay with free motion graphics.

## When NOT to spend
- The frame's problem is layout/geometry/z-order → that's a **free** HyperFrames fix, not a generation. (We once "fixed" a frame that looked unpolished purely by correcting connector-line z-order and reusing an existing plate — zero new credits.)
- The user just wants a quick draft → ship the free motion-graphics version first; add AI visuals only if they ask.
