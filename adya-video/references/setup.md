# Setup check (Step 1)

Run these before any build. The goal is to fail fast on a fresh machine instead of dying at render time. Expect a one-time ~10–15 min setup per person; after that it's fast.

## 1. System binaries

```bash
node -v        # need 18+
ffmpeg -version | head -1     # required by HyperFrames render + ffprobe
python3 --version             # needed only for free Kokoro TTS fallback
```
- **Missing ffmpeg** (most common gap): macOS `brew install ffmpeg`; Debian/Ubuntu `sudo apt-get install -y ffmpeg`. You cannot silently install this — show the command and wait.
- Chrome for rendering is managed by HyperFrames itself (`npx hyperframes browser` if it complains).

## 2. Required skills

The default (HyperFrames) path needs the HyperFrames skill bundle. Check whether `npx hyperframes --version` works:

```bash
npx --yes hyperframes --version
```

If the **HyperFrames skills** aren't installed in the user's agent, offer to install and run on yes:
```bash
npx skills add heygen-com/hyperframes      # installs hyperframes, hyperframes-cli, hyperframes-media, gsap, etc.
```

For **Higgsfield** (only needed if AI visuals are wanted), install the CLI and confirm login:
```bash
curl -fsSL https://raw.githubusercontent.com/higgsfield-ai/cli/main/install.sh | sh
higgsfield account status     # shows plan + remaining credits; if "Session expired" -> higgsfield auth login
```
The `higgsfield-generate` skill (if used) ships via the user's skills marketplace; if it's not present the CLI still works directly per `references/higgsfield.md`.

For **Remotion** (the second engine — used when a video calls for custom/physics/3D animation, on demand) see `references/engines.md` and `references/remotion-build.md`. It scaffolds its own project via `npx create-video@latest`; Node 18+ covers it. No separate install needed until a video uses it.

## 3. API keys (per person — never commit)

- **ElevenLabs** (voiceover): each teammate gets their own key at elevenlabs.io → Profile → API key. Then `export ELEVENLABS_API_KEY=sk_...` (or put it in a local, git-ignored `.env` and source it). Free tier = 10k chars/month (~plenty for short videos). Verify:
  ```bash
  ELEVENLABS_API_KEY=... ./scripts/elevenlabs_tts.sh list | head
  ```
- **Higgsfield** (optional AI visuals): auth via `higgsfield auth login` (per person, own credits / billing).

If the user has no ElevenLabs key and wants a free run, you can still produce a video with **local Kokoro TTS** (more robotic):
```bash
python3 -m pip install --break-system-packages kokoro-onnx soundfile   # one-time
npx hyperframes tts "text" -v af_nova -s 1.1 -o audio/line.wav
```

## Gate
Do not proceed to render steps until: Node 18+, ffmpeg present, HyperFrames runs, and an ElevenLabs key (or an explicit choice to use free Kokoro) is confirmed. Higgsfield is only required if/when the user asks for AI visuals.
