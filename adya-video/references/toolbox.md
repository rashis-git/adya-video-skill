# Toolbox — routing jobs to the right skill

This skill is an orchestrator. Don't reinvent what another skill does — **route to it**. Pick by the *job in front of you*, not by habit. Most of these are optional and only matter for specific jobs; the core path (script → ElevenLabs → HyperFrames → render) needs none of them. Invoke a skill only when its row applies. If a teammate lacks one, it installs on demand (most are `npx skills add …` or already present).

## Decision table

| The job | Use | Notes / cost |
|---|---|---|
| **Generate a video from scratch** (motion graphics, title cards, data viz) | `hyperframes` and/or `remotion` — choose per `references/engines.md` | Free local render. Two first-class engines; can be combined in one video. |
| **Edit existing footage** — a screen recording, talking-head, b-roll: cut, color grade, burn captions, overlays, face-to-corner PiP bubble | `video-use` (master) | Free. The OTHER half of "video creation." For a person-on-camera tutorial with b-rolls + circular face bubble, see **`references/talking-head.md`**. |
| **Analyze / ingest a reference video** (transcript, what's in it, repurpose a long video into clips) | `watch` | Free. Good for QA-ing your own render too. |
| **Capture a live product UI / website into scenes** | `website-to-hyperframes` | Free. Best for product explainers when there's a URL. |
| **Still image asset / background plate** | `generate-image` (FLUX / Nano Banana 2) **first** | Likely cheaper/free vs Higgsfield. Try this before spending Higgsfield credits. |
| **Premium cinematic AI plate or AI video clip** | `higgsfield-generate` | Pay-as-you-go, gated. Image-over-video. See `higgsfield.md`. |
| **Diagram / architecture / flow** (AGP·MAN·ESM, a pipeline) for explainers | `markdown-mermaid-writing` + `infographics` | Free. Turn structure into clean diagrams → scenes. |
| **Mock up a product UI when there's no real screenshot** | `frontend-design` / `taste-skill` / `ui-ux-pro-max`, then `image-to-code-skill` to bring into a scene | Free. Produces a believable UI frame for explainers. |
| **Polish a scene's layout/typography/color** | `taste-skill` / `ui-ux-pro-max` / `pixel-perfect-build` | Free. The scenes are HTML — design skills apply directly. |
| **Make the script sound human (de-AI it)** | `de-ai` | Free. Run the script through this before voicing — pairs with the human ElevenLabs voice. |
| **Script ideation / repurpose to other channels** (captions, threads) | `marketing-skills:copywriting` / `:social-content` | Free. Keep Adya voice from `script-style.md` as the source of truth; use these for variants, not to overwrite voice. |
| **Talking-head presenter video** | `heygen-video` (+ `heygen-avatar`) | Needs HeyGen auth/credits. Optional video *type*, not the default. |
| **Localize the video to another language** (Hindi, etc.) | `heygen-translate` | Needs HeyGen. Useful for India + global. |
| **Product photography / packaging shots** | `higgsfield-product-photoshoot` | Pay-as-you-go. Only if showing a physical/product image. |
| **Consistent recurring character/face across videos** | `higgsfield-soul-id` | Pay-as-you-go. For a recurring brand presenter. |

## Two production paths (decide at intake)

- **Path A — Generate (default):** no footage. Build everything in `hyperframes` (graphics + VO). This is the validated path the rest of the skill describes.
- **Path B — Edit footage:** the user has a screen recording / talking-head / raw clips. Drive `video-use` to transcribe, cut, color, and burn captions; optionally add a `hyperframes` title card / intro-outro and an ElevenLabs VO bed. (This mirrors the API-key tutorial editing pattern: footage in video-use + HyperFrames intro/outro + glass captions.)
- **Hybrid:** footage edited in `video-use` + generated motion-graphics scenes from `hyperframes`, stitched together. Common for product demos (real screen capture + branded intro/outro/CTA).

Ask at intake: *"Are we generating this from scratch, or do you have footage/screen-recordings to edit?"*

## Asset-creation order (cost-aware)
For any still/visual asset, prefer the cheaper tool first: **generate-image (FLUX/Nano Banana) → mermaid/infographics for diagrams → frontend/taste skills for UI mockups → Higgsfield only for premium cinematic plates/clips.** Reuse generated assets across scenes before generating new ones.

## Deliberately NOT in scope (to avoid bloat)
- `scientific-schematics`, scientific-* skills — for research figures, not marketing.
- Heavy strategy skills (`pm-*`, `gtm-*`) — those plan campaigns; this skill *produces a video*. Use them upstream, separately.
- You CAN use both engines in one video — but via the deliberate hybrid pattern in `references/engines.md` (matched fps/resolution), not by accident. Don't layer `marketing-skills` copy over the Adya voice — keep one source of truth for the script.
