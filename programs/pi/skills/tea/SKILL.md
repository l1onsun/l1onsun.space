---
name: tea
description: >
  Gitea CLI client for managing pull requests, issues, reviews, and API calls.
  Use when interacting with Gitea repos: listing PRs, checking CI status,
  reading reviews/comments, or making arbitrary API requests.
---

# tea

CLI tool for interacting with Gitea instances.

## Quick Start

```bash
# List open PRs with key fields
tea pulls list -f "index,title,state,head,base,ci" -o table

# List issues
tea issues list -f "index,title,state,labels" -o table

# Show current user
tea whoami
```

## Pull Requests

```bash
# List PRs with custom fields
tea pulls list -f "index,title,state,author,head,base,ci,comments" -o table

# Filter by state
tea pulls list --state closed --lm 10

# Checkout a PR locally
tea pr checkout <index>
```

## API
##  Reviews

To read reviews, use `tea api`

```bash
# List reviews on a PR
tea api '/repos/{owner}/{repo}/pulls/{pr_number}/reviews'

# Reviews contain: state (APPROVE / REQUEST_CHANGES / COMMENT),
# user, body, comments_count, submitted_at, stale flag
```

### Review states

| State | Meaning |
|-------|---------|
| `APPROVE` | Approved |
| `REQUEST_CHANGES` | Changes requested |
| `COMMENT` | Comment only |

## Comments

There are two types — regular and review (inline code) comments.

```bash
# Regular issue/PR comments
tea api '/repos/{owner}/{repo}/issues/{pr_number}/comments'
```

### Getting all inline review comments

Inline code comments are attached to reviews, not directly to the PR.
The endpoint `/pulls/{pr}/comments` may return 404 — this is a known quirk.

**Step-by-step workflow:**

```bash
# 1. List all reviews on a PR
tea api '/repos/{owner}/{repo}/pulls/{pr_number}/reviews'

# 2. For each review (with comments_count > 0), fetch its inline comments:
tea api '/repos/{owner}/{repo}/pulls/{pr_number}/reviews/{review_id}/comments'
```

Each review comment contains: `body`, `user.login`, `path` (file), `diff_hunk`, `created_at`.

**Example response from `/pulls/{pr}/reviews`:**
```json
[
  {
    "id": 18315,
    "user": { "login": "temikgo" },
    "state": "REQUEST_CHANGES",
    "body": "",
    "comments_count": 27,
    "submitted_at": "2026-05-23T11:28:34+02:00",
    "stale": true
  },
  {
    "id": 18006,
    "user": { "login": "iliacherezov" },
    "state": "COMMENT",
    "body": "",
    "comments_count": 1,
    "submitted_at": "2026-05-18T17:06:16+02:00",
    "stale": true
  }
]
```
Note: `body` is often empty — the actual feedback lives in inline comments fetched via `reviews/{id}/comments`.

## tea api — Arbitrary API Calls

The most powerful command. Endpoint placeholders (`{owner}`, `{repo}`) are auto-filled from local git context.

```bash
# GET request (default)
tea api '/repos/{owner}/{repo}/pulls/35/reviews'

# POST with fields
tea api '/repos/{owner}/{repo}/issues/35/comments' -f "body=Looks good!"

# Raw JSON body
tea api '/repos/{owner}/{repo}/issues/35/comments' -d '{"body":"LGTM"}'

# Include HTTP headers in output
tea api '/repos/{owner}/{repo}/issues' -i

# Output as JSON
tea api '/repos/{owner}/{repo}/pulls' -o json
```


## To find PR for branch:

```bash
tea api '/repos/{owner}/{repo}/pulls?state=open' | jq '.[] | select(.head.ref == "my-branch")'
```
