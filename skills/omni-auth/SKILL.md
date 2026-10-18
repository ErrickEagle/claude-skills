---
name: "omni-auth"
description: "Authenticate to an OmniRoute AI gateway (Bearer API key or dashboard session cookie). Start here before any OmniRoute REST call."
---

<!-- Source: github.com/diegosouzapw/OmniRoute/skills/omni-auth -->

# OmniRoute: Authentication

Local/remote AI gateway exposing OpenAI-compatible REST. One key, many providers, auto-fallback, RTK token saver, MCP server, A2A agents.

## Setup

```bash
export OMNIROUTE_URL="http://localhost:20128"      # or VPS / tunnel URL
export OMNIROUTE_KEY="sk-..."                       # from Dashboard → API Keys
```

All requests: `${OMNIROUTE_URL}/v1/...` with `Authorization: Bearer ${OMNIROUTE_KEY}`.

Verify: `curl $OMNIROUTE_URL/api/health` → `{"ok":true}`

Remote API requests use a Bearer credential. Dashboard login is different: `POST /api/auth/login` accepts a management password and returns an `auth_token` session cookie.

## Dashboard auth endpoints

### POST /api/auth/login

```bash
curl -X POST $OMNIROUTE_URL/api/auth/login \
  -H "Content-Type: application/json" \
  -c cookie.jar \
  -d '{"password":"<management-password>"}'
```

### POST /api/auth/logout (needs CSRF token)

```bash
CSRF_TOKEN=$(curl -s $OMNIROUTE_URL/api/auth/csrf -b cookie.jar | jq -r .token)
curl -X POST $OMNIROUTE_URL/api/auth/logout \
  -b cookie.jar \
  -H "x-omniroute-csrf: $CSRF_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{}'
```

### OIDC

- `GET /api/auth/oidc/login` — builds an authorization URL from the configured OIDC issuer/client, sets a short-lived `oidc_state` cookie, redirects. Password login stays available as fallback.
- `GET /api/auth/oidc/callback` — validates state, exchanges code, verifies ID token against issuer JWKS, checks `oidcAllowedSubjects` if set, then mints the 30-day `auth_token` JWT and redirects to `/dashboard`.

### Other

- `GET /api/auth/csrf` — CSRF token for cookie-authenticated mutations
- `GET /api/auth/status` — current auth status

Full schemas: `GET $OMNIROUTE_URL/api/openapi/spec`.

## Discover models

```bash
curl $OMNIROUTE_URL/v1/models                  # chat/LLM (default)
curl $OMNIROUTE_URL/v1/models/image            # image-gen
curl $OMNIROUTE_URL/v1/models/tts              # text-to-speech
curl $OMNIROUTE_URL/v1/models/embedding        # embeddings
curl $OMNIROUTE_URL/v1/models/web              # web search + fetch
curl $OMNIROUTE_URL/v1/models/stt              # speech-to-text
```

Use `data[].id` as the `model` field. Combos appear with `owned_by:"combo"`.

## Related skills

- `omni-inference` — chat, images, TTS/STT, embeddings, web search/fetch
- `cli-serve` — install, start, stop the server
- More (routing, compression, MCP, A2A, monitoring): https://github.com/diegosouzapw/OmniRoute/tree/main/skills

## Errors

- `401` → set/refresh `OMNIROUTE_KEY` (Dashboard → API Keys)
- `400 Invalid model format` → check `model` exists in `/v1/models/<kind>`
- `503 Provider circuit open` → upstream provider down; retry after `Retry-After` seconds
- `429` → rate limited; honor `Retry-After`
- Connection refused → server not running; see `cli-serve`