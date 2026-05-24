---
name: webclaw
description: >
  Web content extraction using webclaw CLI. Converts URLs to clean markdown,
  plain text, or JSON. Supports CSS selectors, crawling, LLM-powered extraction.
  Use when fetching web pages, documentation, articles, or any online content.
---

# Webclaw

CLI tool for extracting web content as markdown/text/JSON.

## Quick Start

```bash
# Basic extraction (markdown output)
webclaw https://example.com

# LLM-optimized (minimal tokens)
webclaw https://example.com -f llm

# JSON with metadata
webclaw https://example.com -f json
```

## Timeout Strategy (IMPORTANT)

**Always start without proxy using 8-second timeout.** If it fails or times out, retry through local proxy with longer timeout.

```bash
# Step 1: Direct, 8s timeout
webclaw <url> -t 8

# Step 2: If step 1 fails, use proxy with 30s timeout
webclaw <url> -p http://localhost:3738 -t 30
```

The proxy handles better some sites with bot protection or slow responses.

## Common Flags

| Flag | Purpose |
|------|---------|
| `-f llm` | LLM-optimized output (~90% fewer tokens) |
| `-f json` | Full JSON with metadata |
| `--include "selector"` | CSS selector to extract only matching elements |
| `--exclude "selector"` | Remove matching elements |
| `--only-main-content` | Extract article/main/role=main only |
| `--metadata` | Include page metadata |
| `-t <seconds>` | Request timeout |

## Content Filtering

```bash
# Article body only
webclaw <url> --include "article" -t 8

# Remove noise
webclaw <url> --exclude "nav, footer, .sidebar" -t 8

# Main content shortcut
webclaw <url> --only-main-content -t 8
```

## Crawling

```bash
# Crawl docs site
webclaw https://docs.example.com --crawl --depth 2 --max-pages 50 -t 8

# Sitemap discovery
webclaw https://docs.example.com --map
```

## Vertical Extractors (typed JSON)

```bash
# List available extractors
webclaw extractors

# GitHub PR
webclaw vertical github_pr https://github.com/owner/repo/pull/123

# Reddit thread
webclaw vertical reddit https://reddit.com/r/sub/comments/abc/title
```

## Further Reading

- [CLI Reference](references/cli-reference.md) — all flags and options
- [Vertical Extractors](references/vertical-extractors.md) — site-specific extractors
