---
name: "omni-inference"
description: "Call OmniRoute's OpenAI-compatible endpoints: chat completions, Anthropic messages, Responses API, images, TTS/STT, embeddings, web search and fetch."
---

<!-- Source: github.com/diegosouzapw/OmniRoute/skills/omni-inference -->

# OmniRoute: Inference

Requires `OMNIROUTE_URL` and `OMNIROUTE_KEY` (see `omni-auth`). Full API schema: `GET $OMNIROUTE_URL/api/openapi/spec`. Other endpoints exist (batches, files, rerank, moderations, OCR, video/music generation, `/v1/explain/routing`, `/v1/quotas/check`) — check the OpenAPI spec for them.

## Chat completions

- `POST $OMNIROUTE_URL/v1/chat/completions` — OpenAI format
- `POST $OMNIROUTE_URL/v1/messages` — Anthropic Messages format
- `POST $OMNIROUTE_URL/v1/responses` — OpenAI Responses API

Discover: `curl $OMNIROUTE_URL/v1/models | jq '.data[].id'`. Combos (e.g. `auto`, `cost-optimized`, `subscription`) auto-fallback through multiple providers.

```bash
curl -X POST $OMNIROUTE_URL/v1/chat/completions \
  -H "Authorization: Bearer $OMNIROUTE_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model": "<model-id>", "messages": [{"role": "user", "content": "Refactor this function"}], "stream": true}'
```

```bash
curl -X POST $OMNIROUTE_URL/v1/messages \
  -H "Authorization: Bearer $OMNIROUTE_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -H "Content-Type: application/json" \
  -d '{"model": "<model-id>", "max_tokens": 4096, "messages": [{"role": "user", "content": "Hi"}]}'
```

Tool use: supports OpenAI `tools` and Anthropic `tools`. Tool results are auto-compressed via RTK; disable per request with header `X-Omniroute-Rtk: off`. Thinking/reasoning blocks are forwarded verbatim.

Errors: `401` invalid key · `400 invalid_model` check `/v1/models` · `503 circuit_open` retry later or use a combo · `429` honor `Retry-After`.

## Image generation

- `POST /v1/images/generations` · `POST /v1/images/edits` · `POST /v1/images/variations`
- Discover: `curl $OMNIROUTE_URL/v1/models/image | jq '.data[]'` → `{ id, owned_by, sizes, capabilities }`

```bash
curl -X POST $OMNIROUTE_URL/v1/images/generations \
  -H "Authorization: Bearer $OMNIROUTE_KEY" -H "Content-Type: application/json" \
  -d '{"model": "dall-e-3", "prompt": "a red bicycle on a wet street, photoreal", "n": 1, "size": "1024x1024", "response_format": "b64_json"}'
```

Errors: `400 invalid_size` · `400 content_policy_violation` · `503` try another model.

## Text-to-speech

`POST /v1/audio/speech` returns binary audio. Discover voices: `curl $OMNIROUTE_URL/v1/models/tts | jq '.data[]'` (each has `voices`).

```bash
curl -X POST $OMNIROUTE_URL/v1/audio/speech \
  -H "Authorization: Bearer $OMNIROUTE_KEY" -H "Content-Type: application/json" \
  -d '{"model": "tts-1", "input": "Hello from OmniRoute.", "voice": "alloy", "response_format": "mp3"}' --output speech.mp3
```

## Speech-to-text

`POST /v1/audio/transcriptions` (multipart) · `POST /v1/audio/translations` (to English). Discover: `/v1/models/stt`.

```bash
curl -X POST $OMNIROUTE_URL/v1/audio/transcriptions \
  -H "Authorization: Bearer $OMNIROUTE_KEY" \
  -F "file=@audio.mp3" -F "model=whisper-1" -F "response_format=verbose_json"
```

Formats: mp3, mp4, mpeg, mpga, m4a, wav, webm. Responses: json, text, srt, verbose_json, vtt. Usual limit ~25MB.

## Embeddings

`POST /v1/embeddings`. Discover: `/v1/models/embedding` → `{ id, dimensions, max_input_tokens }`.

```bash
curl -X POST $OMNIROUTE_URL/v1/embeddings \
  -H "Authorization: Bearer $OMNIROUTE_KEY" -H "Content-Type: application/json" \
  -d '{"model": "text-embedding-3-large", "input": ["first text", "second text"], "encoding_format": "float"}'
```

## Web search

`POST /v1/web/search`. Discover: `curl $OMNIROUTE_URL/v1/models/web | jq '.data[] | select(.kind == "webSearch")'`.

```bash
curl -X POST $OMNIROUTE_URL/v1/web/search \
  -H "Authorization: Bearer $OMNIROUTE_KEY" -H "Content-Type: application/json" \
  -d '{"model": "tavily/search", "query": "OmniRoute latest release", "max_results": 5, "include_answer": true}'
```

Fields: `model`, `query`, `max_results` (default 5), `include_answer`, `search_depth` (`basic`/`advanced`, Tavily). Response: `{ answer?, results:[{ url, title, content, score }] }`.

## Web fetch

`POST /v1/web/fetch`. Discover: `select(.kind == "webFetch")` on `/v1/models/web`.

```bash
curl -X POST $OMNIROUTE_URL/v1/web/fetch \
  -H "Authorization: Bearer $OMNIROUTE_KEY" -H "Content-Type: application/json" \
  -d '{"model": "jina/reader", "url": "https://example.com", "format": "markdown"}'
```

Formats: markdown (default), html, text. Errors: `400 invalid_url` · `403 blocked` try another model · `503` provider unavailable.