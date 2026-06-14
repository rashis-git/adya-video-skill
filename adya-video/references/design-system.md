# Design system — unique every time (the only constant is the logo)

**Strict rule.** This skill has NO house palette, NO default fonts, NO template. Do not carry colors, type, motion, or layout from a previous video or from any "Adya brand palette." The ONLY element every video must contain is the **Adya logo** (`assets/adya-logo.webp`). Everything else is decided fresh, per video.

If you ever catch yourself reaching for teal `#2DD4BF` / indigo / Inter / JetBrains Mono because "that's Adya," stop — that was an old default and is now banned as a fallback. Those may only appear if the *user explicitly asks* for them.

## Decide the design system at intake (part of Step 2)
Ask the user:
- **Colors** — a preferred scheme, mood, or specific hex values?
- **Typography** — preferred fonts, or a vibe (editorial serif, geometric sans, condensed, mono, hand-drawn…)?
- **References** — any look/brand/mood they want to echo?
- **If they say "you decide":** you MUST invent a genuinely unique palette + font pairing for this video, distinct from every entry in the ledger (`references/variety.md`). Never default to a prior video's look or to teal/Inter. State what you chose and the reasoning in one line.

## Inventing a unique system (you-decide mode)
1. Read the ledger; note every palette and font pairing already used.
2. Pick a **different** direction: a different hue family, a different light/dark balance, a different type personality. (If the last three were dark + cool accents, do warm, or light/editorial, or high-contrast mono — something clearly new.)
3. Build a coherent palette: one background, one foreground/text, 1–2 accents, tinted neutrals — derived from a single hue or a deliberate pairing. Ensure WCAG AA text contrast (`hyperframes validate` enforces it).
4. Pick a font pairing with real contrast (characterful display + clean body). Use fonts HyperFrames can embed (most common Google fonts work — write the `font-family` and the compiler embeds it) or have the user drop `.woff2` files in `fonts/`. **Vary the pairing every time.**
5. Write these into a **fresh per-project `design.md`** in the project root (HyperFrames reads it as that project's source of truth). This file is unique to THIS video — it is not a brand file and must not be reused verbatim next time.

## The logo — the one invariant
- File: `assets/adya-logo.webp` — a multicolor gradient mark on a transparent background. Copy it into every project's `assets/`.
- It must appear in **every** video: typically small in a corner for most of the runtime (height ~48–64px at 1080p) and/or larger on the closing/CTA frame.
- **Never recolor, restyle, stretch, or rotate it** — it's the constant that makes the video Adya's. Preserve aspect ratio.
- Because it's multicolor, protect legibility: give it clear space, and on busy or light backgrounds place it on a subtle neutral/dark chip or add a soft shadow. It must read cleanly against whatever unique palette this video uses.

## Per-project design.md (what to write)
Generate `design.md` before building, containing:
- **Palette** — bg, fg/text, 1–2 accents, neutrals, as hex (this video's unique scheme).
- **Type** — font families + weight roles (display/body/labels).
- **Any user do/don'ts.**
Do not copy a previous `design.md`. Log the chosen palette + fonts to the ledger after rendering so the next "you decide" video diverges from it.
