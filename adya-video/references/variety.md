# Variety engine — replicate, or genuinely fresh

The failure mode this fixes: once a video looks good, every later video copies its colors, motion, and layout. That's anchoring/mode-collapse — the model reuses the last thing it liked. To get real variety you must *force divergence on purpose*; it does not happen by default.

## First question of every new video
Ask before anything else:

> "Do you want to **replicate** a previous video (I'll match its look and just swap the content), **adapt** one (same bones, fresh treatment), or build **completely fresh** (deliberately different from everything before)?"

If they don't name a prior video, list what exists (see the ledger below) so they can point to one.

## Replicate mode
Copy the chosen project as the template, swap in the new script/scenes, keep the palette, motion, and layout. This is the *consistency* path — for a series that should feel uniform. Read the prior `index.html` and reuse its patterns exactly.

## Fresh mode — the divergence checklist (mandatory)
When the user wants a new video, **read the ledger** (below) for what recent videos used, then deliberately choose differently. Before writing any HTML, pick a NEW point on at least **4 of these axes** vs the most recent 1–2 videos, and state your choices to the user:

1. **Composition / layout** — centered vs edge-anchored vs split-screen vs asymmetric grid vs full-bleed. (Don't reuse last video's framing.)
2. **Motion vocabulary** — entrance directions, eases, and transition types. If the last one used back.out pop-ins + crossfades, use something else (whip-pans, blur-through, mask reveals, kinetic type, shader morph).
3. **Scene rhythm** — number of scenes, hold vs rapid-cut, where the peak lands. A 3-scene slow build is different from a 6-scene staccato.
4. **Visual motif / metaphor** — the central idea (a converging network ≠ a timeline ≠ a stacked-cards reveal ≠ a single hero object ≠ a data-grid). Invent a motif that fits THIS topic.
5. **Typography treatment** — scale, weight contrast, all-caps vs sentence case, mono accents, kinetic vs static.
6. **Imagery ratio** — pure type/graphics vs image-led (Higgsfield/`generate-image`). Flip it from last time where it fits the type.
7. **Energy** — calm/editorial vs high/punchy.

**The only constant is the Adya logo.** There is NO house palette and NO default fonts (see `references/design-system.md`). Palette and typography are themselves divergence axes that must be **unique every video** — taken from the user, or invented fresh. Never reuse a prior video's colors/fonts, and never fall back to teal/indigo + Inter "because it's Adya." The logo (`assets/adya-logo.webp`) appears in every video and is the sole through-line.

**Don't lift specific assets** from a prior video in fresh mode — no reused background plate, no copied scene, no recycled motif, no repeated palette or font pairing. Generate or design new ones.

Optional but powerful: for a fresh video, briefly pitch **2 distinct concept directions** (different motif + energy) and let the user pick. Choosing between two divergent options breaks the default-pattern reflex better than a single take.

## The style ledger
Maintain a running fingerprint so "fresh" has something to diverge *from*. After each render, append one line to `.adya-video-ledger.md` in the parent folder where videos are created (create it if absent):

```
- <date> | <topic> | type:<launch|explainer|demo> | palette:<bg/accent in words+hex> | fonts:<display/body> | motif:<one phrase> | motion:<one phrase> | layout:<one phrase> | imagery:<none|plate|image-led>
```

Read this file at the start of fresh mode AND whenever the user says "you decide" on design — palette and fonts must differ from every row here. If it doesn't exist yet (first video on this machine), there's nothing to avoid — just build well, then start the ledger.

Example ledger entries (so you can see what "different" looks like):
```
- 2026-06-14 | GTM Agent 15s | type:explainer | palette:dark navy + teal #2DD4BF | fonts:Inter/JetBrains Mono | motif:tools→one governed core | motion:back.out pops + crossfade | layout:edge-anchored | imagery:plate(CTA)
- 2026-06-15 | ESA 30s | type:explainer | palette:dark navy + teal #2DD4BF | fonts:Inter/JetBrains Mono | motif:4-agent left→right pipeline | motion:card cascade + arrow draw | layout:centered row | imagery:plate(CTA)
```
A fresh video after these must NOT reuse that dark-navy+teal/Inter look at all — e.g. go warm cream + ink editorial with a serif display, or high-contrast mono, or a bold duotone — a clearly different palette, type, motif, and motion. (The first two videos used teal/Inter only because that was the old default; that default is now retired.)
