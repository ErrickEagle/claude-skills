---
name: "openmontage"
description: "Make videos with OpenMontage (explainers, promos, montages, animations, shorts, dubs). Use when the user asks to make, edit or render a video, or names OpenMontage."
---

# OpenMontage video production

OpenMontage (https://github.com/calesthio/OpenMontage, AGPLv3) is an agent-driven video production system. It is a Python + FFmpeg + Node/Remotion toolchain, not just instructions, so you must make sure the project is installed before producing anything. The project's own `AGENT_GUIDE.md` is the source of truth for how to work; this skill only gets you there.

## 1. Find or install the project

Look for an existing checkout first, in this order:

1. `$OPENMONTAGE_HOME` if set
2. The current working directory (it is a checkout if `AGENT_GUIDE.md` and `pipeline_defs/` exist)
3. `~/OpenMontage`, then `./OpenMontage`

If none exists, install it (tell the user first; it is about 160 MB plus dependencies):

```bash
# Prerequisites: Python 3.10+, FFmpeg, Node.js 18+ (22+ for HyperFrames), git, make
python3 --version; ffmpeg -version | head -1; node --version
git clone --depth 1 https://github.com/calesthio/OpenMontage.git ~/OpenMontage
cd ~/OpenMontage && make setup
```

If `make` is missing (macOS/Linux):

```bash
python3 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt \
  && (cd remotion-composer && npm install) && pip install piper-tts && cp .env.example .env
```

Windows PowerShell: `py -3 -m venv .venv; .\.venv\Scripts\Activate.ps1; pip install -r requirements.txt; cd remotion-composer; npm install; cd ..; pip install piper-tts; Copy-Item .env.example .env`

If a prerequisite is missing, install it with the platform package manager (apt/brew/winget) when possible, otherwise tell the user what to install.

## 2. Prepare the shell every time

Run all project commands from the checkout root with the venv first on PATH, so tools like `piper` are found:

```bash
cd ~/OpenMontage && export PATH="$PWD/.venv/bin:$PATH"
```

Use `.venv/bin/python` (or `.venv\Scripts\python` on Windows), never the system Python.

## 3. Check capabilities

```bash
make preflight
```

This prints which tools are available and which are missing. Tell the user in plain language what you can make right now and what needs an API key.

- Without keys, these work: HyperFrames/Remotion motion graphics, Three.js worlds, character animation, diagrams, subtitles, Pixabay music search, trimming/stitching/reframing/colour grade, reference-video analysis.
- Free offline narration (Piper) also needs a voice model: `python -m piper.download_voices en_US-lessac-medium` into `~/.piper/models`. It downloads from huggingface.co; if the network blocks that, say so and suggest a cloud TTS key instead.
- Keys go in `.env` at the checkout root (see `.env.example`). Useful ones: `PEXELS_API_KEY` / `PIXABAY_API_KEY` (free stock footage), `ELEVENLABS_API_KEY` or `OPENAI_API_KEY` (voice), `FAL_KEY` or `REPLICATE_API_TOKEN` (many image/video models in one key), `GOOGLE_API_KEY`, `RUNWAY_API_KEY`, `KLING_API_KEY`. Only write keys the user gives you; never print them back.

## 4. Follow the project's agent guide

Read `AGENT_GUIDE.md` in full before acting on the request, and follow it exactly. In short:

- Vague request ("make me a video") -> read `skills/meta/onboarding.md`.
- A reference video as inspiration -> read `skills/meta/video-reference-analyst.md`.
- **Rule Zero:** every production goes through a pipeline in `pipeline_defs/` (animated-explainer, animation, avatar-spokesperson, character-animation, cinematic, clip-factory, documentary-montage, hybrid, localization-dub, podcast-repurpose, screen-demo, talking-head). Read the manifest, run preflight, then for each stage read `skills/pipelines/<pipeline>/<stage>-director.md` before doing that stage's work.
- Before calling any tool with an `agent_skills` field, read that skill in `.agents/skills/`.
- Do not write ad-hoc scripts that bypass the pipeline. Announce provider/model and cost before any paid generation call, and ask before changing major choices.

## 5. Deliver

When the render finishes, give the user the final video file (send or save it where they can open it), with its length and resolution, and mention any fallbacks used. In an ephemeral cloud session, remind the user that the install does not persist and the next session will reinstall.