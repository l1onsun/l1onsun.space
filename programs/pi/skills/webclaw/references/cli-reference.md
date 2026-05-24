# CLI Reference

Complete reference for the `webclaw` command-line tool.

## Basic Extraction

Pass one or more URLs as positional arguments. webclaw fetches each page, extracts the main content, and outputs clean markdown.

| Flag | Description |
|------|-------------|
| `webclaw <url>` | Extract a single URL |
| `webclaw url1 url2 url3` | Batch extract multiple URLs |
| `--urls-file <file>` | Read URLs from a file, one per line |
| `--file <path>` | Read HTML from a local file |
| `--stdin` | Read HTML from stdin |

```bash
webclaw https://example.com
webclaw https://example.com https://news.ycombinator.com
webclaw --urls-file urls.txt
curl -s https://example.com | webclaw --stdin
```

## Output Formats

| Flag | Description |
|------|-------------|
| `-f markdown` | Clean markdown (default) |
| `-f text` | Plain text, no formatting |
| `-f json` | Full ExtractionResult as JSON |
| `-f llm` | LLM-optimized: 9-step pipeline (~90% fewer tokens) |
| `--metadata` | Include page metadata in output |
| `--raw-html` | Raw HTML without extraction |

```bash
webclaw https://example.com -f llm
webclaw https://example.com -f json
webclaw https://example.com --metadata
```

## Content Filtering

Use CSS selectors to control extraction.

| Flag | Description |
|------|-------------|
| `--include <selectors>` | CSS selectors to extract (exclusive mode) |
| `--exclude <selectors>` | CSS selectors to remove |
| `--only-main-content` | Extract article, main, or role="main" only |

```bash
webclaw https://example.com --include "article"
webclaw https://example.com --include ".post-content, .comments"
webclaw https://example.com --exclude "nav, footer, .sidebar"
webclaw https://example.com --include "main" --exclude ".ads, .related-posts"
webclaw https://example.com --only-main-content
```

## Browser Impersonation

TLS fingerprint impersonation (no headless browser).

| Flag | Description |
|------|-------------|
| `-b chrome` | Chrome profiles (default): v142, v136, v133, v131 |
| `-b firefox` | Firefox profiles: v144, v135, v133, v128 |
| `-b random` | Random profile per request |

## Proxy

| Flag | Description |
|------|-------------|
| `-p <url>` | Single proxy: `http://user:pass@host:port` |
| `--proxy-file <file>` | Proxy pool, one per line in `host:port:user:pass` format |

webclaw auto-loads `proxies.txt` from working directory if present.

```bash
webclaw https://example.com -p http://user:pass@proxy.example.com:8080
webclaw https://example.com --proxy-file proxies.txt
```

## Crawling

BFS same-origin crawler.

| Flag | Description |
|------|-------------|
| `--crawl` | Enable BFS crawling |
| `--depth <n>` | Max crawl depth (default: 1) |
| `--max-pages <n>` | Max pages (default: 20) |
| `--concurrency <n>` | Parallel requests (default: 5) |
| `--delay <ms>` | Delay between requests (default: 100) |
| `--path-prefix <path>` | Only crawl URLs with this path prefix |
| `--sitemap` | Seed from sitemap before BFS |

```bash
webclaw https://docs.example.com --crawl --depth 3 --max-pages 100
webclaw https://docs.example.com --crawl --path-prefix /api/
```

## Sitemap Discovery

```bash
webclaw https://docs.example.com --map
webclaw https://docs.example.com --map > urls.txt
```

## Change Tracking

```bash
webclaw https://example.com -f json > snapshot.json
webclaw https://example.com --diff-with snapshot.json
```

## Brand Extraction

```bash
webclaw https://example.com --brand
```

## LLM Features

| Flag | Description |
|------|-------------|
| `--extract-json <schema>` | Extract data matching JSON schema (string or @file) |
| `--extract-prompt <text>` | Natural language extraction |
| `--summarize [sentences]` | Summarize page (default: 3 sentences) |
| `--llm-provider <name>` | Force provider: ollama, openai, anthropic |
| `--llm-model <name>` | Override model |
| `--llm-base-url <url>` | Override provider base URL |

```bash
webclaw https://example.com --summarize
webclaw https://example.com --extract-prompt "Get all pricing tiers"
webclaw https://example.com --extract-json '{"type":"object","properties":{"title":{"type":"string"}}}'
webclaw https://example.com --summarize --llm-provider openai
```

## PDF Extraction

Auto-detected via Content-Type header.

```bash
webclaw https://example.com/report.pdf
webclaw https://example.com/report.pdf --pdf-mode fast
```

## Other Options

| Flag | Description |
|------|-------------|
| `-t <seconds>` | Request timeout (default: 30) |
| `-v` | Verbose logging |

## Cloud API

| Flag | Description |
|------|-------------|
| `--api-key <key>` | Set webclaw API key (or `WEBCLAW_API_KEY` env) |
| `--cloud` | Force all requests through cloud API |

**Modes:**
- **Local only** (default): No API key, everything local
- **Automatic fallback**: API key set, tries local first, cloud on failure
- **Cloud forced**: `--cloud` flag, direct to cloud API

| Feature | Local | Cloud |
|---------|-------|-------|
| Bot protection bypass | No | Yes |
| JS rendering | No | Yes |
| Proxy rotation | Manual | Automatic |
| Speed | Fast | Depends |
| Cost | Free | Credits |
| Privacy | Local | Server |
