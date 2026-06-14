#!/usr/bin/env bash
# Adya Video — ElevenLabs voiceover helper.
# Generates one MP3 per line and prints durations (needed to time scenes).
#
# Auth: each person brings their own key. Set it one of two ways:
#   export ELEVENLABS_API_KEY=sk_...            (preferred)
#   or put ELEVENLABS_API_KEY=... in a .env the caller sources.
#
# Usage:
#   ./elevenlabs_tts.sh list                         # list available voices (id | name | gender | accent)
#   ./elevenlabs_tts.sh gen <voice_id> <out.mp3> "text to speak"
#   ./elevenlabs_tts.sh dur <file.mp3>               # print duration in seconds
#
# Recommended voices (id | name):
#   EXAVITQu4vr4xnSDxMaL | Sarah   — mature, confident female (default)
#   JBFqnCBsd6RMkjVDRZzb | George  — warm British male
#   cjVigY5qzO86Huf0OWal | Eric    — smooth, trustworthy male
#   hpp4J3VqNfWAUOO0d1Us | Bella   — professional, warm female
#
# Pronunciation: respell names phonetically in the text. e.g. "Adya" -> "Aadhya" (AHD-yaa).
set -euo pipefail
MODEL="${ELEVENLABS_MODEL:-eleven_multilingual_v2}"

if [ -z "${ELEVENLABS_API_KEY:-}" ]; then
  echo "ERROR: ELEVENLABS_API_KEY not set. export ELEVENLABS_API_KEY=sk_... and retry." >&2
  exit 1
fi

cmd="${1:-}"
case "$cmd" in
  list)
    curl -s -H "xi-api-key: $ELEVENLABS_API_KEY" "https://api.elevenlabs.io/v1/voices" \
      | python3 -c "import sys,json; [print(v['voice_id'],'|',v['name'],'|',v.get('labels',{}).get('gender',''),v.get('labels',{}).get('accent','')) for v in json.load(sys.stdin).get('voices',[])]"
    ;;
  gen)
    VID="$2"; OUT="$3"; TEXT="$4"
    BODY=$(python3 -c "import json,sys; print(json.dumps({'text':sys.argv[1],'model_id':sys.argv[2],'voice_settings':{'stability':0.45,'similarity_boost':0.8,'style':0.0,'use_speaker_boost':True}}))" "$TEXT" "$MODEL")
    curl -s -X POST "https://api.elevenlabs.io/v1/text-to-speech/$VID" \
      -H "xi-api-key: $ELEVENLABS_API_KEY" -H "Content-Type: application/json" \
      -d "$BODY" --output "$OUT"
    # sanity: fail loudly if the API returned a JSON error instead of audio
    if file "$OUT" | grep -qiv "audio"; then
      echo "ERROR: ElevenLabs did not return audio. Response head:" >&2; head -c 200 "$OUT" >&2; echo; exit 1
    fi
    D=$(ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 "$OUT")
    echo "$OUT : ${D}s"
    ;;
  dur)
    ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 "$2"
    ;;
  *)
    echo "usage: $0 {list | gen <voice_id> <out.mp3> \"text\" | dur <file.mp3>}" >&2; exit 1 ;;
esac
