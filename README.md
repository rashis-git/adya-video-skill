# adya-video — installable skill

Turn a topic into an on-brand Adya marketing / explainer / demo video: script → ElevenLabs voiceover → animation → MP4, with a review loop and optional Higgsfield AI visuals (pay-as-you-go). Built so anyone on the team can run it from Claude Code. Two first-class animation engines — **HyperFrames** (fast, audio/caption-native) and **Remotion** (custom/physics/3D, reusable components) — chosen per video or combined.

## What's here
```
adya-video/
├── SKILL.md                 # the orchestrator workflow (start here)
├── assets/adya-logo.webp    # the ONLY constant across videos (placed in every one)
├── scripts/elevenlabs_tts.sh# voiceover generation + duration measurement
└── references/              # setup, variety (anti-sameness), video-types, design-system, engines,
                             #   script-style, hyperframes-build, music, product-explainer,
                             #   higgsfield, remotion, toolbox
```

> **No house palette, fonts, or template.** Every video gets a unique design (user-specified or invented). The Adya logo is the only thing every video shares.

## What it can make

**Four video types:**
- **Launch** — heavily animated, cinematic, imagery-led ("make it sexy"). Announcements, teasers, homepage hero.
- **Explainer** — concept-driven motion graphics. "What is X / how it works / the thesis."
- **Demo** — real UI screens + features. Team-shot footage is edited first (`video-use`), then b-rolls/callouts/captions layered on.
- **Tutorial / talking-head** — a real person on camera + b-rolls + the face-to-corner circle + captions; keeps their real voice.

**Across every type:** script in Adya's voice (grounded in real product facts), human voiceover (ElevenLabs) or kept real voice or free local TTS, **optional background music** and **optional subtitles** (you choose per video), b-rolls, optional AI visuals (Higgsfield / FLUX), diagrams/infographics, unique design every time, a replicate-or-fresh variety control, and any aspect ratio (landscape / vertical / square). Two engines — HyperFrames + Remotion — chosen per video or combined.

## Install (per teammate)

**Option A — from git (recommended):** in Claude Code or a terminal:
```bash
npx skills add rashigupta-Adya/adya-video-skill
```
The skills CLI installs `adya-video/SKILL.md` + its bundled references into `~/.claude/skills/adya-video/`. Restart your agent session after installing.

**Option B — manual:** download this repo, copy the `adya-video/` folder into `~/.claude/skills/`, then restart the agent session.

After install, the skill triggers when you say things like *"make a 15s Adya video about AGP"* or *"turn the Recruitment Agent into an explainer."* On first run it checks your environment and offers to install anything missing (see `adya-video/references/setup.md`).

## One-time prerequisites (the skill checks these for you)
- Node 18+, **ffmpeg**, Chrome (HyperFrames manages it).
- HyperFrames skills: `npx skills add heygen-com/hyperframes`.
- **Your own** ElevenLabs API key → `export ELEVENLABS_API_KEY=sk_...` (each person brings their own).
- Optional (only for AI visuals): Higgsfield CLI + `higgsfield auth login` (your own credits).

## Cost model
Free by default (HyperFrames graphics + local render). The only paid steps are ElevenLabs voiceover (cheap; free tier ~10k chars/mo) and Higgsfield AI visuals (opt-in, gated, image-over-video). Keys and billing are per-person.
